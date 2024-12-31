from flask import Flask, jsonify, redirect
import boto3

app = Flask(__name__)

BUCKET_NAME = "jayeshs3"
s3_client = boto3.client("s3")

@app.route("/", methods=["GET"])
#default
def default_redirect():
    return redirect("/list-bucket-content")

@app.route("/list-bucket-content", defaults={"path": ""}, methods=["GET"])
@app.route("/list-bucket-content/<path:path>", methods=["GET"])
def list_bucket_content(path):
    try:
        #adds / at end
        if path and not path.endswith("/"):
            path += "/"

        #get s3 bucket content
        response = s3_client.list_objects_v2(Bucket=BUCKET_NAME, Prefix=path, Delimiter="/")

        # check if path exist or not
        if "Contents" not in response and "CommonPrefixes" not in response:
            return jsonify({"error": f"The specified path '{path}' does not exist in the bucket."}), 404

        contents = []

        # add dir
        if "CommonPrefixes" in response:
            contents.extend([prefix["Prefix"][len(path):].rstrip("/") for prefix in response["CommonPrefixes"]])

        # add files
        if "Contents" in response:
            contents.extend([obj["Key"][len(path):] for obj in response["Contents"] if obj["Key"] != path])

        return jsonify({"content": contents})
    except Exception as e:
        return jsonify({"error": f"An unexpected error occurred: {str(e)}"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)