Received: from outbound.ms.icloud.com (ms-2002h-snip4-8.eps.apple.com [57.103.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEC2737E0
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114896; cv=none; b=n2g+x7oRlGvSLlqUaHg0k00xDErSRaIR4ceLKEePGmNkHN1/b5M0Er+YagD0ydyvqMdLMf7FxvRY5oU085lNhonXvul7MwdNj9NKw5LB3EB0J8S5WI7hTUZcL0fnEPGVp1ZJsAUTrh92LbRpCjR4sOjQirU86SxQsyPBEe9q3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114896; c=relaxed/simple;
	bh=V/qyVjDWA9hf3HT1wXVL1mIgYgcOssN23sfhID3ufCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJAahj/Op+I2Qc7vy99OAlDluOttBoGI1PMi1uj8ZxzByqNv53A+IIdljMBoK+FtoFsGRF2OrWGOJLXsmPCqjhlEHk+JHPAmF9rXRRcYoHqElY9FCMCkpJf9Qds+JdE23RDHaSRMMAP2wXBuAqC3136nOFemcQB1y09xKY6KdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=L6OU5eyh; arc=none smtp.client-ip=57.103.74.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="L6OU5eyh"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id CC08818000BF;
	Mon, 27 Jul 2026 01:14:50 +0000 (UTC)
X-ICL-RepId: 019fa123-91d0-79cc-a942-0e56e86cf4ab
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgNAFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114894; x=1787706894; bh=V3v0uuvdQPDrcGdGjNZc+pczeojxIh7E+/M4tvsr98A=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=L6OU5eyhood/4DCWkmA0rINw7PKqAwnSw0KD/ghJITPabafYMNLwrixd0FxKIgASg3ewK3lfMps2nybonO9ct7stMg3xplfgWU/ORXLT9PMePrghS9FZBi512WSiIuzcaLRlJwzm+LhbAzN1fDlXPOdtsRYYDSGCawd9/Qs4q3MOBTU0p9peI8snkKq/Vaf9k2ZU8+rs3Mzs2HFzei4rpYGIuqsSibVZkNAxy2enr67N9jgI0T068ckQ8GAoYxiC14kH/tgKrFs13HMlzTPQ5MidWqWISe3kORbyADaYpAza+P/WSoCucSRGIuB2W/RBYzcMKBnzTXpx1fCwpi56fg==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 2B4A71800105;
	Mon, 27 Jul 2026 01:14:46 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 09/11] power: supply: max17042_battery: Initialize MAX17055 from battery info
Date: Sun, 26 Jul 2026 21:13:07 -0400
Message-ID: <20260727011319.621794-10-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX16cyDnlJbQI7
 n02D9/zGarEdOKmvIQVEV4FjBOJVH2AyQLJkQAbmO+0hKjwC50LrooL4FvzJCRNqCCHl0hXNSUx
 juJelj0NkPty++w4kCzGK7Mt9yb6xuJdgaISvjCGPC5dI4dyIoBUKFCF/8f2lr8ou1tTZuj72FF
 b6znFlqVucUFOFQzbpcKZPOywUfQ3GdFryTKda3rhFwQ+RgXoUz/rHqsyow0LIa+Fc4B/foPN6P
 KyzMwacZf05LtJTaM5K3CzXskn2Otgd/jHwataRcU0Cev81XKOFy0s5YvXjNnAJe67XqZJr0rjW
 3x+hGrRQdlUFDIAIOP/PD5lCNFRnpZNgCj3GomJgqciFXaYfhyEI3mTyQuFj1Y=
X-Authority-Info-Out: v=2.4 cv=G54R0tk5 c=1 sm=1 tr=0 ts=6a66b10c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wkD5_1Zv00kWz-F82TkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WhguIQL8B97A4z0sz8zBoaI_fcAWjGCB
X-Proofpoint-ORIG-GUID: WhguIQL8B97A4z0sz8zBoaI_fcAWjGCB

From: Vincent Cloutier <vincent@cloutier.co>

Use charge-full-design-microamp-hours and
charge-term-current-microamp from monitored-battery to prepare MAX17055
DesignCap, IChgTerm, and EZ Config dQAcc values in the power-supply
registration callback.

Apply positive battery values and treat zero like an absent property.
Validate all supplied positive values before changing the sparse
configuration. Reject values that quantize to zero, capacities that cannot
produce dQAcc, and termination currents outside the signed register range.
Limit this path to MAX17055 because the other supported gauges require
complete characterization data.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 82 +++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 33a2cc378b46..db3b1bc5388f 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -62,6 +62,7 @@
 #define MAX17042_RESISTANCE_LSB		1 / 4096 /* Ω */
 #define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
 
+#define MAX17055_DQACC_DIV		32
 #define MAX17055_DPACC_FACTOR		44138
 #define MAX17055_DPACC_VCHG_FACTOR	51200
 #define MAX17055_FSTAT_DNR_BIT		BIT(0)
@@ -1240,6 +1241,85 @@ static int max17042_init_defaults(struct max17042_chip *chip)
 	return 0;
 }
 
+static int max17042_apply_battery_properties(struct max17042_chip *chip,
+					     struct power_supply_battery_info *info)
+{
+	struct max17042_config_data *config;
+	struct device *dev = chip->dev;
+	bool have_design_cap;
+	bool have_ichgt_term;
+	u16 design_cap = 0;
+	u16 ichgt_term = 0;
+	u16 dqacc = 0;
+	u64 data64;
+
+	if (!info || chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)
+		return 0;
+
+	have_design_cap = chip->enable_current_sense &&
+		info->charge_full_design_uah > 0;
+	have_ichgt_term = chip->enable_current_sense &&
+		info->charge_term_current_ua > 0;
+	if (!have_design_cap && !have_ichgt_term)
+		return 0;
+
+	if (have_design_cap) {
+		data64 = (u64)info->charge_full_design_uah * chip->r_sns;
+		do_div(data64, MAX17042_CAPACITY_LSB);
+		if (!data64)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity is too small for sense resistor\n");
+		if (data64 > U16_MAX)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity exceeds register range\n");
+
+		design_cap = (u16)data64;
+		dqacc = design_cap / MAX17055_DQACC_DIV;
+		if (!dqacc)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity is too small for EZ config\n");
+	}
+
+	if (have_ichgt_term) {
+		data64 = (u64)info->charge_term_current_ua * chip->r_sns;
+		do_div(data64, MAX17042_CURRENT_LSB);
+		if (!data64)
+			return dev_err_probe(dev, -ERANGE,
+					     "charge termination current is too small for sense resistor\n");
+		if (data64 > S16_MAX)
+			return dev_err_probe(dev, -ERANGE,
+					     "charge termination current exceeds positive register range\n");
+
+		ichgt_term = (u16)data64;
+	}
+
+	config = chip->config_data;
+	if (!config) {
+		config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+	}
+
+	if (have_design_cap) {
+		config->design_cap = design_cap;
+		config->dqacc = dqacc;
+	}
+	if (have_ichgt_term)
+		config->ichgt_term = ichgt_term;
+
+	chip->config_data = config;
+	chip->enable_por_init = true;
+
+	return 0;
+}
+
+static int max17042_init_battery(struct power_supply *psy)
+{
+	struct max17042_chip *chip = power_supply_get_drvdata(psy);
+
+	return max17042_apply_battery_properties(chip, psy->battery_info);
+}
+
 static const struct regmap_config max17042_regmap_config = {
 	.name = "max17042",
 	.reg_bits = 8,
@@ -1293,6 +1373,7 @@ static const struct power_supply_desc max17042_psy_desc = {
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
 	.external_power_changed	= power_supply_changed,
+	.init		= max17042_init_battery,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props),
 };
@@ -1303,6 +1384,7 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
+	.init		= max17042_init_battery,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
-- 
2.55.0

