Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CD31A55B;
	Tue, 13 Oct 2026 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850889; cv=none; b=Gxm1uUVy+mX5q6oW99gI+l/eWlr0ULunvPAccMH5vZy6aOvM76o5+5cw59hEcaArczDJvFXSH1Y7Tt0/B6GoKMyOaZTBEnHtPeMZw4Dnlq6094gPFCPHQWIjmywvzQPA9u6CouM8u3JMis0uyS1CTwW9EH9ZpAiD8pyTNFLdIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850889; c=relaxed/simple;
	bh=3IyRHAqESPnkbVSajEO3Jn9YI38E+fzQv+s0f+BpK9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9bRSLA7680Di05lvi3dlUXDhMpr0CQu2b1LftUkNx+xTJh5p4sdHV7rnPw5KE2KTbl32RhxZdS2Fk7SieAw9x2MRFRxG0BKXHqHhan8D2bWd7dgNwuOgatu7/Aes8yaer51QztswC1xY8Q633Z5/kXj9JpFPnSs6wOaxIv2VpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=dSK4aFMR; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="dSK4aFMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=RD/oeknw+n
	JIUaT8TcNT5qfIfKre8vK0H0zLEuANyPc=; b=dSK4aFMR29C/Wawz3pDSHt2AL7
	pN1QnQJEPDC2KTuZ+DfbB3x95xskjFkbB4oyfh4j7AAtG1UdOgV/3N2zO1gP4Kui
	yNSWU+5zaje0Xjw280lHA0WHAgvD/7d5Zp/143hiXFND6RFr3RApeMTkAH8zzkzZ
	5n3CTMTfumVKAk0Hg=
Received: from 5700g-x8664.ustc.edu.cn (unknown [114.214.192.228])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHNx6Fec1qVrHcAQ--.931S2;
	Tue, 13 Oct 2026 08:21:25 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
Subject: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Tue, 13 Oct 2026 08:21:24 +0800
Message-ID: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHNx6Fec1qVrHcAQ--.931S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47AFW7Xw1DZF4UKr4Uurg_yoWruF1fpa
	95JFZIyw1vyF43Aa47AF4Ikw4xKr4vy343Krn7W34Iv3W3trn2gr9rtFnxK348A3s3ZFyY
	kw4ak343Cr47GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeK
	sjUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARETB2rNcIkC0AANsF

From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
instead of an instantaneous measurement: the property getter indexes
context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
offset written by the maximum-load path.  Exposing that as power_now makes
userspace report e.g. 89 W while the battery is charging below 1 W, or
above 100 W while discharging at about 4 W.

The SM8750 PMIC GLINK node is already described in DT
("qcom,sm8750-pmic-glink" in sm8750-mtp/qrd), but the driver has no entry
for it, so it falls back to QCOM_BATTMGR_SM8350 and advertises POWER_NOW.

Add the SM8750 variant and a battery descriptor that reuses the SM8550
properties without POWER_NOW.  The property array is reordered so that
POWER_NOW is the last entry, which keeps the new descriptor a two-line
addition; property ordering itself is not ABI.

Voltage, current, charge counters and the charge-control thresholds are
retained.

Tested on Lenovo Legion Y700 Gen4 (TB322FC, SM8750P): charging and
discharging, UPower state-of-charge and rate are unchanged and power_now
is no longer exposed.

Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/power/supply/qcom_battmgr.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 7716eb9e1a..dbc98ac8a7 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SC8280XP,
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SM8550,
+	QCOM_BATTMGR_SM8750,
 	QCOM_BATTMGR_X1E80100,
 };
 
@@ -916,9 +917,13 @@ static const enum power_supply_property sm8550_bat_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
-	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	/*
+	 * Kept last on purpose: SM8750 reuses this list without POWER_NOW,
+	 * see sm8750_bat_psy_desc.
+	 */
+	POWER_SUPPLY_PROP_POWER_NOW,
 };
 
 static const struct power_supply_desc sm8550_bat_psy_desc = {
@@ -931,6 +936,23 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
 	.property_is_writeable = qcom_battmgr_bat_is_writeable,
 };
 
+/*
+ * The SM8750 QBG firmware fills BATT_POWER_NOW from its maximum-load updater
+ * instead of from an instantaneous measurement, so the published value is not
+ * a present power reading (it reports the maximum load, e.g. 89 W while the
+ * battery is actually charging below 1 W).  Do not advertise POWER_NOW on
+ * this platform.
+ */
+static const struct power_supply_desc sm8750_bat_psy_desc = {
+	.name = "qcom-battmgr-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sm8550_bat_props,
+	.num_properties = ARRAY_SIZE(sm8550_bat_props) - 1,
+	.get_property = qcom_battmgr_bat_get_property,
+	.set_property = qcom_battmgr_bat_set_property,
+	.property_is_writeable = qcom_battmgr_bat_is_writeable,
+};
+
 static int qcom_battmgr_ac_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
@@ -1617,6 +1639,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
+	{ .compatible = "qcom,sm8750-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8750 },
 	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
@@ -1690,7 +1713,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
-		if (battmgr->variant == QCOM_BATTMGR_SM8550)
+		if (battmgr->variant == QCOM_BATTMGR_SM8750)
+			psy_desc = &sm8750_bat_psy_desc;
+		else if (battmgr->variant == QCOM_BATTMGR_SM8550)
 			psy_desc = &sm8550_bat_psy_desc;
 		else
 			psy_desc = &sm8350_bat_psy_desc;
-- 
2.53.0

