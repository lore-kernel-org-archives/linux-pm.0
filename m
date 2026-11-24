Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490399;
	b=cnGX74u9FwJdbeC27fzemg3+Q/3GOV/SZhpPTuf0bttOLJphsSOocNgrMLHxX3eIUi4A
	 /0msLEXdPZ4pYBVa70CwdBylcMsJgcgYXF+Ud93ezo09QLnwp2QCKXOx3QdSLbxBrAuHN
	 M+S+DT0gYafXw/GohWIFFLQeDvDCpCHuNLhJB3SXl1lpy1HtjBbptjF9tXjFAWdtrDIdq
	 TH1Pvwa7UTRM/FnBbYk8eX8sNHXSVC7UQP4ofkNDJmH9pFbspzvpog/sG3OrKC32OIbEL
	 wb/fkOC1meXYmXl2brZI1Rcx2dm21zTwL3nt4JD1v0AqI8KW5qfx4qBLGcu3HLDcSNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490399;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i2oKJV6XrXsCy+D4Qns138YPQw3ViRTw9F5eOp0zY9Y=;
	b=HlEj3oXJ6D9dJ9qhDyqztMW5vB3ZjkL25LAyJqULz68Ov6YMCDAuXe+QzSdDXR5O+5G5
	 atkgozhStEjboOlLHCNbb+OOxDfRDdMshEZEXnTZ6Rywxj4PHwRt/a6pZZNlfgqAK5wzM
	 A6K7LZY4RJnckP53xVBT2DJs1aQQWTQxzuUMGMAIdmkyaWpkzWQCXuT/lH6wvJYami0YO
	 KXze4B/JH3fHwMCq+fT6tZn5t8ilvuqWz35gEX3XbB8a+QBluOBApA0kq2DUNxtF26JDy
	 /aZizB/8aMlxgpaPc9z6ChEhjpyw2sqB+V2vgteMNzjBnjgZf2HhrAGFjzgDmVE+MoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C01J5f8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0B606A31E;
	Tue, 24 Nov 2026 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C01J5f8H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795490398;
	b=GL7OTHEYCE4gC5FgckwF2l/DDcSUZyZcBJDfsFJYmAd1YjZNsvX2PEucpTzl2HpsIl2a
	 d0lZ+NZ2k3MmMXPJ4o1Jb8L9tsJ6ltg+Q/tiZnGMQrQekvbckJtsMSaX7QZLXrgSP2OUZ
	 xQdhbCmrsCE5SjHvOEKYLRqiuXY0s7wIBzcmxrgogKHScVxlrnsXDSswbrMs0TYNz5SpO
	 1y9PgKSPD8vZ1AwGz36U4i9vNcHv6RB1AoeBxTmQT9whxJ7TXNRZkvlArk/FINQ5RB6I1
	 Z3j+VGrkjKFX4c5SlX7HBDlsy0VTxJ2vB1BdYpF9rSAfIVSVCAoWlS5KL70JvjjDSfg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795490398;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i2oKJV6XrXsCy+D4Qns138YPQw3ViRTw9F5eOp0zY9Y=;
	b=1UnNbONQFyaOA/W/RajJCuRjnZG1p4PWJpO7/ETdK1Q6lrdM6mfw66dYo5p3fSoGsO8T
	 PmynnWJLqsQMQfI05SVvb5HaAxT3DDQ4qMU3lsnfP6Eg53dVWd7a6sN2TBfjm2EAwVx4p
	 AbsRmDr6k5+qJCECLIRA75780gF+9YbVYSfEKqM4lfeCBHQd8qHzH8SlyDPhuO0YV5EDZ
	 oNkva6ASGLcRLKygkqb1LZpj1g9CAdtiNFGNZFtFnZZ+QY19aRvKhzJYBsowNRomN9kL9
	 m4fe4SBNbmDa1iEvrJgI1rbuTtpgArvrwkMMgvYNElBjFL6qagkv43WIJL6nO4UGL8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC9871F000C6;
	Tue, 24 Nov 2026 03:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795490398;
	bh=i2oKJV6XrXsCy+D4Qns138YPQw3ViRTw9F5eOp0zY9Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=C01J5f8HWBQM/+o3vxtOs0Uk4jhvYWTGueGVV36Vj7GvsjMlCGB39iou83UoXisXJ
	 3d5tg9EOhVn3RR8CM9lU6EG16vTWMG/3dKaUTnFV4Ngw7TZ+ONHpaq9jIzeiCEhe4R
	 YN/s5F4TGe3c0pkb8RebqFaMhEe7SsHw1wm/MFoFsB3LJlJYzS4jJJlTrJpPc10Sqw
	 1tbX+vN+8zyH9YS5IL9GqcOxWh5rMdDIlXndZq+/QWBIByfE93I9lgAgJsLPrrCm/u
	 4gJrBVaq4SN6PHPrVyvkErxo0MGTx+aHSoNhKkXT6EqabKVcUmRkgbZQGVsCJku4/Y
	 cAiIUp9s9x7/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 47A564C846;
	Tue, 24 Nov 2026 03:19:52 +0000 (UTC)
From: Jerome Berclaz via B4 Relay <devnull+jerome.berclaz.proton.me@kernel.org>
Date: Mon, 23 Nov 2026 19:19:50 -0800
Subject: [PATCH] power: supply: surface-rt-ec: add charge_behaviour and
 report "Not charging"
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-surface-rt-ec-charge-behaviour-v1-1-26b33fdbcd06@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQrCMBAFf6Xs2YUkFkF/RTyk64tdD61smiKU/
 rurHgeGmY0qTFHp0m1kWLXqPDnEQ0cy5ukB1rszpZBOMaYj12YlC9gWhrA75s6AMa86N+M+hF4
 yEEs+k0dehqLv3+B6+3NtwxOyfKu07x8BJyE/ggAAAA==
X-Change-ID: 20261123-surface-rt-ec-charge-behaviour-4004caee1fa9
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Jethro Bull <jethrob@hotmail.com>, 
 Jerome Berclaz <jerome.berclaz@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7492;
 i=jerome.berclaz@proton.me; h=from:subject:message-id;
 bh=S7sUxLnqWmnFPeONxMfiyCH0lGGULc5XZup7yTcUs8Q=;
 b=owGbwMvMwCVmvC9341tRgSLG02pJDNmsTOHpV2VFb7t9FbAJjdh/9q1pIt+zJVE3Km/7zpoo6
 bpm6bG6jlIWBjEuBlkxRRbWBsPU+SfYAgr15x2CmcPKBDKEgYtTACZyzoKR4ejdkA1SM6Zuu3jb
 7/KWJZezr66cfvhpe1P/92OX5W943Ohn+CuotUvrpFa/UkM0y5FM1l2m57Jr57B/dVJ9zmloX9k
 pwwcA
X-Developer-Key: i=jerome.berclaz@proton.me; a=openpgp;
 fpr=058031659FC80650712F9EC233BE6DB1ED151072
X-Endpoint-Received: by B4 Relay for jerome.berclaz@proton.me/default with
 auth_id=1608
X-Original-From: Jerome Berclaz <jerome.berclaz@proton.me>
Reply-To: jerome.berclaz@proton.me
Content-Transfer-Encoding: 7bit

From: Jerome Berclaz <jerome.berclaz@proton.me>

The Surface RT's Windows firmware has a "Battery Thermal Limit" _DSM
(4c2067e3-887d-475c-9720-4af1d3ed602e) on its battery device. Function 1
takes a value from 0 to 100, which Microsoft documents as the percentage
of the maximum charge rate, with 0 meaning that charging is stopped. The
firmware writes it with an SMBus byte write to EC register 0x00 when the
EC firmware major version (register 0x04) is 10 or later, and to
register 0x0d otherwise.

On EC firmware 0x0a.0x0d the EC charges at the full rate with 100 and
does not charge at all with any lower value (0, 25, 50, 80, 90 and 99
were tried): the adapter keeps powering the system and the battery
current drops to zero within a minute. The EC keeps the value across
adapter removal, suspend, reboot and power-off.

Expose this as the charge_behaviour property of the battery: "auto"
writes 100, "inhibit-charge" writes 0. Pick the register the way the
Windows firmware does; only register 0x00 has been tested.

Also report POWER_SUPPLY_STATUS_NOT_CHARGING instead of DISCHARGING when
the adapter is online and the EC is not charging, as happens with
charging inhibited.

Tested on a Microsoft Surface RT with a 7.3.1-based kernel (libre-tegra
tree): charge_behaviour reads "auto [inhibit-charge]" and the status is
"Not charging" while inhibited on AC; writing "auto" resumes charging
at about 0.9 A.

The register and its semantics were found, and this change and its
description written, with the help of an AI coding assistant (Claude),
from the ACPI tables of the device's Windows firmware and Microsoft's
battery documentation; I reviewed the change and tested it on my device
as described above.

Signed-off-by: Jerome Berclaz <jerome.berclaz@proton.me>
---
Notes:
- Only register 0x00 (EC firmware 10 and later) could be tested; the
  register for older EC firmware, 0x0d, comes from the firmware's ACPI
  code only.
- The EC treats every value below 100 as "stop charging", so only
  auto and inhibit-charge are offered.
- The EC keeps the setting across power-off, so a userspace policy has
  to restore "auto" itself, e.g. on shutdown; the driver leaves the
  value alone on probe and removal.
---
 drivers/power/supply/surface-rt-ec.c | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface-rt-ec.c b/drivers/power/supply/surface-rt-ec.c
index b175bc63c504..164f475f97f8 100644
--- a/drivers/power/supply/surface-rt-ec.c
+++ b/drivers/power/supply/surface-rt-ec.c
@@ -11,7 +11,10 @@
 #include <linux/types.h>
 
 /* Register Addresses (B=byte; W=word; S=string) */
+#define REGB_CHARGE_LIMIT		0x00
 #define REGB_STATUS			0x02
+#define REGB_FW_MAJOR			0x04
+#define REGB_CHARGE_LIMIT_OLD		0x0d
 #define REGW_VOLTAGE_NOW		0x20
 #define REGW_CURRENT_NOW		0x24
 #define REGW_CAPACITY			0x28
@@ -37,6 +40,7 @@ struct srt_ec_device {
 
 	unsigned int technology;
 	unsigned int capacity;
+	u8 charge_limit_reg;
 
 	const char *serial;
 	char manufacturer[13];
@@ -45,6 +49,7 @@ struct srt_ec_device {
 
 static const enum power_supply_property srt_bat_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
@@ -126,6 +131,64 @@ static int srt_bat_get_value(struct i2c_client *client, int reg, int *val)
 	return 0;
 }
 
+/*
+ * The charge limit is the value of the "Battery Thermal Limit" _DSM of the
+ * Windows firmware (0 to 100 percent of the maximum charge rate). The EC
+ * charges at the full rate with 100 and does not charge at all with any
+ * lower value. It keeps the value across suspend, reboot and power-off.
+ */
+#define SRT_CHARGE_LIMIT_NONE		100
+#define SRT_CHARGE_LIMIT_INHIBIT	0
+
+static int srt_ac_online(struct i2c_client *client)
+{
+	int ret = i2c_smbus_read_byte_data(client, REGB_ONLINE);
+
+	if (ret < 0)
+		return ret;
+
+	return ret & BIT(0);
+}
+
+static int srt_bat_power_supply_set_property(struct power_supply *psy,
+					     enum power_supply_property psp,
+					     const union power_supply_propval *val)
+{
+	struct srt_ec_device *srt = power_supply_get_drvdata(psy);
+	u8 limit;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch (val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			limit = SRT_CHARGE_LIMIT_NONE;
+			break;
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			limit = SRT_CHARGE_LIMIT_INHIBIT;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = i2c_smbus_write_byte_data(srt->client,
+						srt->charge_limit_reg, limit);
+		if (ret < 0)
+			return ret;
+
+		power_supply_changed(psy);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int srt_bat_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
+}
+
 static int srt_bat_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -170,10 +233,24 @@ static int srt_bat_power_supply_get_property(struct power_supply *psy,
 		ret = srt_bat_get_value(client, REGB_ONLINE, &val->intval);
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		if (srt->capacity < 100)
+		if (srt->capacity < 100) {
 			ret = srt_bat_get_value(client, REGB_STATUS, &val->intval);
-		else
+			if (!ret && val->intval == POWER_SUPPLY_STATUS_DISCHARGING &&
+			    srt_ac_online(client) > 0)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		} else {
 			val->intval = POWER_SUPPLY_STATUS_FULL;
+		}
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = i2c_smbus_read_byte_data(client, srt->charge_limit_reg);
+		if (ret < 0)
+			break;
+
+		val->intval = ret == SRT_CHARGE_LIMIT_NONE ?
+			      POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO :
+			      POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		ret = 0;
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = srt->technology;
@@ -246,7 +323,11 @@ static const struct power_supply_desc srt_bat_power_supply_desc = {
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = srt_bat_power_supply_props,
 	.num_properties = ARRAY_SIZE(srt_bat_power_supply_props),
+	.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE),
 	.get_property = srt_bat_power_supply_get_property,
+	.set_property = srt_bat_power_supply_set_property,
+	.property_is_writeable = srt_bat_property_is_writeable,
 	.external_power_changed = power_supply_changed,
 };
 
@@ -314,6 +395,17 @@ static int srt_ec_probe(struct i2c_client *client)
 	else
 		srt->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
+	/*
+	 * Like the Windows firmware, use the charge limit register of EC
+	 * firmware 10 and later, and the older one before.
+	 */
+	ret = i2c_smbus_read_byte_data(client, REGB_FW_MAJOR);
+	if (ret < 0)
+		return ret;
+
+	srt->charge_limit_reg = ret >= 0x0a ? REGB_CHARGE_LIMIT :
+					      REGB_CHARGE_LIMIT_OLD;
+
 	bat_cfg.drv_data = srt;
 	bat_cfg.fwnode = dev_fwnode(dev);
 

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261123-surface-rt-ec-charge-behaviour-4004caee1fa9

Best regards,
--  
Jerome Berclaz <jerome.berclaz@proton.me>


