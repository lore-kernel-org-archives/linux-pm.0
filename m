Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107794;
	b=ZzGzgsNaMsgOreNE2lswnKRocd9eMZrUZ9/e9sM2H1qNXaJC3p1tqhsIW1e72jr6xcr0
	 EZZ8w2kCtnfVQ1s/cqLDbxMST532DiSDUZxXHGr+p9Ihg57Y+vr5YTD/G5/q7SEi6PcLt
	 uDeov9pI9XZTlHZNFNa5AyClV6gBBqshpOPio8UvdYT4eGwadPGjUt1DIMAhpMZHB7GSo
	 IS4W23lwTgDcx19FW/NSGY7PUE0fT2vZNOn+QS3UW6udEEfi5+U74r8UMVBSSjjNsooP0
	 b7kb+ZXc2Hs1s89J9x5SdiXZ2NP9eEy6LMe+sPEbS9kGxkEyyx2qsWDiscIAcgtXPdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107794;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=DF5jq7LcllRPbW++Uz7QpUJQ2W6mZYaUl51ykSJdEOY=;
	b=COolQBOLuL6/ZPfoim1ZH0bsobSV73D1/2SZk7k0fcE+txozsXRuyE5Gdyasv7WvdCFn
	 pG4YWDIe6ZoMlh4TLDSCYv7hfN7xSBB0MKhbdNpl19MTIJmNi6ruWeqGYdsReitoVNohp
	 IiII11jWV6nmPjud6C5nPcMTrE9eY10hTqr0Krba8wmDv1+RXjb+zWXmFqTokf3zaf5RY
	 xBXhwqy9JCCBXhM9MXeSbHnrl8Cy+LBXkg8zz/pprObk0ydOlYcoxpABlNuXL3Iz35bV4
	 FD6yUI/l8uFTnVSx3kC4kvnFeC5ycg9XXAx1+8O53suxd8tb6Ig9RSKxQjdJiXo5dvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=dvdMAMao;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8A60A2638;
	Tue, 27 Oct 2026 13:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B8A60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=dvdMAMao
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=DF5jq7Lcll
	RPbW++Uz7QpUJQ2W6mZYaUl51ykSJdEOY=; b=dvdMAMaovYlfKjhrAF696q9Jxy
	vWm1/5/JytdOjC4XT6ZHPffk9eTKsy3ysoLdUKbsVjXkUgKlBNeKuWOjXB2W5ciX
	WF1pmJ1BvKlY3wcez1IJmjYm63OvpeqXiThYOUmuA6Fs+64W9sgCBqSdoQm3U/fx
	trbvopvBc7b+Dvk1o=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAXoUVNp+BqjmxRAA--.1869S2;
	Tue, 27 Oct 2026 21:29:49 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
Subject: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Tue, 27 Oct 2026 21:29:49 +0800
Message-ID: <20261027132949.242685-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAXoUVNp+BqjmxRAA--.1869S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47AFW7Xw1DZF48GryDWrg_yoWruFWfpa
	95JFZIyw1vyF43Aa47AF4Ikw4xKr4vy343KFn7W34Iva43trn2gr9rtFnxK348A3sayryF
	kw4ak343Cr47GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-P
	UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAAwsx

From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
instead of an instantaneous measurement: the property getter indexes
context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
offset written by the maximum-load path.  Exposing that as power_now makes
userspace report e.g. 89 W while the battery is charging below 1 W, or
above 100 W while discharging at about 4 W.

The SM8750 PMIC GLINK node is already described in DT
("qcom,sm8750-pmic-glink" in sm8750-mtp/qrd), but the driver has no entry
for that compatible, so the node resolves to the SM8550 entry listed second
in the same node and advertises POWER_NOW.

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
index 636d6f6..05846db 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SC8280XP,
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SM8550,
+	QCOM_BATTMGR_SM8750,
 	QCOM_BATTMGR_X1E80100,
 };
 
@@ -917,9 +918,13 @@ static const enum power_supply_property sm8550_bat_props[] = {
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
@@ -932,6 +937,23 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
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
@@ -1644,6 +1666,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
+	{ .compatible = "qcom,sm8750-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8750 },
 	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
@@ -1717,7 +1740,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
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

