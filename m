From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] thermal: tsens: Make some symbols static
Date: Mon, 13 May 2019 21:52:16 +0800
Message-ID: <20190513135216.23540-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org, david.brown@linaro.org, amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pm@vger.kernel.org

Fix sparse warnings:

drivers/thermal/qcom/tsens-v0_1.c:322:29: warning: symbol 'tsens_v0_1_feat' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v0_1.c:330:24: warning: symbol 'tsens_v0_1_regfields' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v1.c:147:29: warning: symbol 'tsens_v1_feat' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v1.c:155:24: warning: symbol 'tsens_v1_regfields' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v2.c:30:29: warning: symbol 'tsens_v2_feat' was not declared. Should it be static?
drivers/thermal/qcom/tsens-v2.c:38:24: warning: symbol 'tsens_v2_regfields' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
 drivers/thermal/qcom/tsens-v1.c   | 4 ++--
 drivers/thermal/qcom/tsens-v2.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index b3a63d7..a319283 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -319,7 +319,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 /* v0.1: 8916, 8974 */
 
-const struct tsens_features tsens_v0_1_feat = {
+static const struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -327,7 +327,7 @@ const struct tsens_features tsens_v0_1_feat = {
 	.max_sensors	= 11,
 };
 
-const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* No VERSION information */
 
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index a1221ef..10b595d 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -144,7 +144,7 @@ static int calibrate_v1(struct tsens_priv *priv)
 
 /* v1.x: qcs404,405 */
 
-const struct tsens_features tsens_v1_feat = {
+static const struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -152,7 +152,7 @@ const struct tsens_features tsens_v1_feat = {
 	.max_sensors	= 11,
 };
 
-const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
 	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 36fbfa6..1099069 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -27,7 +27,7 @@
 
 /* v2.x: 8996, 8998, sdm845 */
 
-const struct tsens_features tsens_v2_feat = {
+static const struct tsens_features tsens_v2_feat = {
 	.ver_major	= VER_2_X,
 	.crit_int	= 1,
 	.adc		= 0,
@@ -35,7 +35,7 @@ const struct tsens_features tsens_v2_feat = {
 	.max_sensors	= 16,
 };
 
-const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
 	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
-- 
2.7.4
