## Create our bucket
'''sh
aws s3 mb s3://my-prefix-bucket234
'''

## Create a folder insidde a bucket
'''sh
aws s3api put-object --bucket="my-prefix-bucket234" --key="hello/"
'''

## Create a many folders
'''sh
aws s3api put-object --bucket "my-prefix-bucket234" --key "lorem/ipsum/dolor/sit/amet/consectetur/adipiscing/elit/sed/do/eiusmod/tempor/incididunt/ut/labore/et/dolore/magna/aliqua/ut/enim/ad/minim/veniam/quis/nostrud/exercitation/ullamco/laboris/nisi/ut/aliquip/ex/ea/commodo/consequat/duis/aute/irure/dolor/in/reprehenderit/in/voluptate/velit/esse/cillum/dolore/eu/fugiat/nulla/pariaturs/"
'''

