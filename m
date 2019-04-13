From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] interconnect: qcom: Make qcs404_rpm static
Date: Sat, 13 Apr 2019 22:19:54 +0800
Message-ID: <20190413141954.38900-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, georgi.djakov@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pm@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/interconnect/qcom/qcs404.c:27:21:
 warning: symbol 'qcs404_rpm' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/interconnect/qcom/qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index de35fd7..c320cbd 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -24,7 +24,7 @@
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
 
-struct qcom_smd_rpm *qcs404_rpm;
+static struct qcom_smd_rpm *qcs404_rpm;
 
 struct icc_rpm_smd_req {
 	__le32 key;
-- 
2.7.4
