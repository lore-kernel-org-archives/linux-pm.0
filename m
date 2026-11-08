Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794136949;
	b=MoyhGgeLp4RCYClWSfESaVLY4E9mhff+0KCi62O6n9vOSohn9dJOG++Yo8RUmyu93x2i
	 PksnaT/4T/OAVQ5DHJbVg9W0TaVuC0CFMx+2IvBdfjmuXeA4qlQKwHEdi5iuGGdj1TZPr
	 XWsmzNs65pt9/OMZ4aO+A6RQAfink+CvPmgm3zFev0feGwbSn8quWrF9YFgWYrFglgBIC
	 W5l38Jr6OIPxC6yyF3p2VMYjp4Dn2/f3+T95ZMvDHzTWhBrKBxnFHz/vamQNGEDMo9UJf
	 Hj7q9Dmw7T/VHYnKTd6GEg3XCCO8TCUn8nMbXwSfsV8TIqaVqj7w9GGBARxUGhNcxMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136949;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iRd7kFN62SFJJFCn39CsZlyKZ56SDZQR8ey9hsRQIqs=;
	b=Iy/Yhbif2Rj9+2oqNHz0Yy0wJ8f6UmSx5+JS/JUmlaUf7PaNCVcoTPyMsgRUUaj2gb2V
	 I8oN6NfhKaeBf+w/bkvcbdA2zYvfy65Pa1jYimxgxMpeKc1u4EpKSdsOGkLD6gm5pOKw9
	 6IFby6nwyoEgc9qtYagpUvblc2LeVklENAx7C3irdZXrbPX18PFGr88ueNLNo2gebW0mU
	 Cz1ddknHD5gAk1pDrwPHCv64Lzhw+KTkyLvRRXFIcfPsEkCChtOp3u968gqAh4Qddamp+
	 YbgAZkt1CVLgbLOZNWu89ec2isuYBGcwdyfGIlQZ9hIzcmpHvsAhRhohYbx28FfQdaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMUvNsuw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB2606A334;
	Sun,  8 Nov 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMUvNsuw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794136948;
	b=yrqXmQT2VdQBNMOXtI13k2zABY2til1NLf8JSbK/AoREc93KzLeR/JeiHE38RPe8w5VF
	 6mqnb6cmesMDEWywOVDwyI9qSOTcUtc7P3cWFc4gKUO62KvhnLNXjdXLu8cHFJq8fU3Tp
	 RpC90tidlPkxMGiJrce3gz0g5jM53oN6Hn0cZKEwCq+HEJEF8uuiTermsiz+BTFn8Z9v8
	 jLV97gzlzvHr8BvOVdSbfbtJ3gvem+IfWtcf+Ca2VSzigFDIDipWK+yuIrCmuksa0Ndgh
	 u7g6Qt++yHUV1ttXSoTz9GRt3TZyvKBxzXPWGh92cjczfWwFs/cObo51yX5ZBF/tG+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794136948;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iRd7kFN62SFJJFCn39CsZlyKZ56SDZQR8ey9hsRQIqs=;
	b=d/8gN4NmFMJgF5oszYTULAwK1NazmPaNDHscJqHldDiTtme8CdAMO4GlZxj03GMl2Crq
	 FCl/ALnqa+s8XB8LRuETD407XvDnRtmbe4qexBybT9q5LW2ZxNuNs3+4CXS72XAopMnO9
	 LI0DjomgjZS5IDQ8EkoJnUq7oHcWftCmz6jWBO2fTWXxuw61dlwHOa62Om0rxKeHV51cT
	 CuandhE+YASmftI7nWrxjb2D9IY/0awAiJEd1/qZX2foKi863GH0cGa5H676j0kk031tK
	 12huIX1H74cWJ/mQbyTkOndG7MHmSLGGOow6Z7hLbMUnMsoeHLQiL2Un4nVp73t97qA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0EBC01F008A2;
	Sun,  8 Nov 2026 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136948;
	bh=iRd7kFN62SFJJFCn39CsZlyKZ56SDZQR8ey9hsRQIqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JMUvNsuwUbyEZXYem24e+1BjP4Qr36Mv+rB1vCH3I+AEL1qqN8IizGlng9AZfZLUx
	 IPIolkH2PboDIYceqLBOGJ96TrtUpipK5t6NZY0VVXVs21eLt3MpwL0P4Mj+VUQ/1a
	 2AqzsVXmdUtr7Ycdx+s4zQRiPlkCV+KqRnoizvq8Evr760C7e4WlH4qUbiLTyFy5Z5
	 taGIBsx4jksNPWoWeGG2OQ5JnfU2rTlfptk/SFULFrZxcSdEWY70rYKrkx/AJ38Y/I
	 ghg+Bn9U2k9rMHRNSFFWQFe+NQc3MvUgSUUAhEw8xgDdOuf2InQ3RWXzXmr7nSAtIG
	 ysX1TXUpXo92w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9975147F03;
	Sun,  8 Nov 2026 11:22:26 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 12:22:26 +0100
Subject: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
 driver
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
Message-Id: <20261108-b4-sm5714-fuel-gauge-v1-2-c659b6c0884a@dxdmail.cc>
References: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
In-Reply-To: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794136945; l=8857;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=0xZbLK5B8C7WzRBXVs40P3RdNG+1xfko7pbUx/2GRKE=;
 b=czDEglVhaTbT3dT6wmTTHnq1gpm/CZ8WZr/a3swN6UJy77X6ik5nE2/kZ3ikG/r8WYBbkNw2J
 tHQpJuxstbnDYjUy5Xcylj7hqqakoWrPUh5FD/ziie+luG1TGWsF+oc
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

Add a driver for the fuel gauge of the Silicon Mitus SM5714. The state
of charge, voltage and current are read through an SRAM window, and the
SRAM read address is the only register the driver writes. The status
is derived from the battery current, as in s2mu005-battery. The driver
does not load a battery model, so capacity is only reported once
Samsung's software has initialized the gauge. The register layout and
scaling come from Samsung's GPL driver for the Galaxy Tab S9.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 MAINTAINERS                           |   1 +
 drivers/power/supply/Kconfig          |  10 ++
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/sm5714-battery.c | 221 ++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2875017d21c2..d9f37c040453 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25718,6 +25718,7 @@ M:	Nizat Mikayilli <nacht@dxdmail.cc>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuel-gauge.yaml
+F:	drivers/power/supply/sm5714-battery.c
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ee7dc5f2617a..c92d09a4f1c9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -240,6 +240,16 @@ config BATTERY_S2MU005
 
 	  This driver, if built as a module, will be called s2mu005-fuel-gauge.
 
+config BATTERY_SM5714
+	tristate "Silicon Mitus SM5714 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y to enable support for the fuel gauge of the Silicon Mitus
+	  SM5714, which reports the battery state of charge, voltage and
+	  current.
+
+	  This driver, if built as a module, will be called sm5714-battery.
+
 config BATTERY_COLLIE
 	tristate "Sharp SL-5500 (collie) battery"
 	depends on SA1100_COLLIE && MCP_UCB1200
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3c0d1006c1a..459f9cbe5f30 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
 obj-$(CONFIG_BATTERY_S2MU005)	+= s2mu005-battery.o
+obj-$(CONFIG_BATTERY_SM5714)	+= sm5714-battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
 obj-$(CONFIG_BATTERY_INTEL_DC_TI) += intel_dc_ti_battery.o
diff --git a/drivers/power/supply/sm5714-battery.c b/drivers/power/supply/sm5714-battery.c
new file mode 100644
index 000000000000..bd8cb97d81df
--- /dev/null
+++ b/drivers/power/supply/sm5714-battery.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/units.h>
+
+#define SM5714_FG_REG_DEVICE_ID		0x00
+#define SM5714_FG_REG_SYSTEM_STATUS	0x10
+#define SM5714_FG_REG_AUX_STAT		0x22
+#define SM5714_FG_REG_SRAM_RADDR	0x8c
+#define SM5714_FG_REG_SRAM_RDATA	0x8d
+
+#define SM5714_FG_SYSTEM_STATUS_INIT	BIT(12)
+#define SM5714_FG_AUX_STAT_CURRENT_X2_5	BIT(10)
+
+#define SM5714_FG_SRAM_SOC		0x00
+#define SM5714_FG_SRAM_VBAT		0x03
+#define SM5714_FG_SRAM_CURRENT		0x05
+#define SM5714_FG_SRAM_VBAT_AVG		0x08
+#define SM5714_FG_SRAM_CURRENT_AVG	0x09
+
+struct sm5714_fg {
+	struct i2c_client *client;
+	struct mutex lock; /* SRAM read address and data */
+};
+
+static int sm5714_fg_read_sram(struct sm5714_fg *fg, u8 addr)
+{
+	int ret;
+
+	guard(mutex)(&fg->lock);
+
+	ret = i2c_smbus_write_word_data(fg->client, SM5714_FG_REG_SRAM_RADDR, addr);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_read_word_data(fg->client, SM5714_FG_REG_SRAM_RDATA);
+}
+
+static int sm5714_fg_sign_mag(int raw, int mul, int div)
+{
+	int val = mult_frac(raw & 0x7fff, mul, div);
+
+	return raw & BIT(15) ? -val : val;
+}
+
+static int sm5714_fg_get_voltage(struct sm5714_fg *fg, u8 addr, int *val)
+{
+	int ret;
+
+	ret = sm5714_fg_read_sram(fg, addr);
+	if (ret < 0)
+		return ret;
+
+	*val = 2700000 + sm5714_fg_sign_mag(ret, 10000, 109);
+
+	return 0;
+}
+
+static int sm5714_fg_get_current(struct sm5714_fg *fg, u8 addr, int *val)
+{
+	int aux, ret;
+
+	ret = sm5714_fg_read_sram(fg, addr);
+	if (ret < 0)
+		return ret;
+
+	aux = i2c_smbus_read_word_data(fg->client, SM5714_FG_REG_AUX_STAT);
+	if (aux < 0)
+		return aux;
+
+	*val = sm5714_fg_sign_mag(ret, MICRO, 2044);
+	if (aux & SM5714_FG_AUX_STAT_CURRENT_X2_5)
+		*val = *val * 5 / 2;
+
+	return 0;
+}
+
+static int sm5714_fg_get_capacity(struct sm5714_fg *fg, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(fg->client, SM5714_FG_REG_SYSTEM_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & SM5714_FG_SYSTEM_STATUS_INIT))
+		return -ENODATA;
+
+	ret = sm5714_fg_read_sram(fg, SM5714_FG_SRAM_SOC);
+	if (ret < 0)
+		return ret;
+
+	*val = min(ret >> 8, 100);
+
+	return 0;
+}
+
+static int sm5714_fg_get_status(struct sm5714_fg *fg, int *val)
+{
+	int now, avg, capacity, ret;
+
+	ret = sm5714_fg_get_current(fg, SM5714_FG_SRAM_CURRENT, &now);
+	if (ret)
+		return ret;
+
+	ret = sm5714_fg_get_current(fg, SM5714_FG_SRAM_CURRENT_AVG, &avg);
+	if (ret)
+		return ret;
+
+	/* Use the average as well, to ride out noise around 0 A */
+	if (now < 0 && avg < 0)
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+	else if (!now)
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	else if (!sm5714_fg_get_capacity(fg, &capacity) && capacity > 98)
+		*val = POWER_SUPPLY_STATUS_FULL;
+	else
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+
+	return 0;
+}
+
+static const enum power_supply_property sm5714_fg_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+};
+
+static int sm5714_fg_get_property(struct power_supply *psy,
+				  enum power_supply_property psp,
+				  union power_supply_propval *val)
+{
+	struct sm5714_fg *fg = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return sm5714_fg_get_status(fg, &val->intval);
+	case POWER_SUPPLY_PROP_CAPACITY:
+		return sm5714_fg_get_capacity(fg, &val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return sm5714_fg_get_voltage(fg, SM5714_FG_SRAM_VBAT, &val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		return sm5714_fg_get_voltage(fg, SM5714_FG_SRAM_VBAT_AVG, &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return sm5714_fg_get_current(fg, SM5714_FG_SRAM_CURRENT, &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		return sm5714_fg_get_current(fg, SM5714_FG_SRAM_CURRENT_AVG, &val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct power_supply_desc sm5714_fg_desc = {
+	.name = "sm5714-fuel-gauge",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sm5714_fg_props,
+	.num_properties = ARRAY_SIZE(sm5714_fg_props),
+	.get_property = sm5714_fg_get_property,
+};
+
+static int sm5714_fg_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct power_supply *psy;
+	struct sm5714_fg *fg;
+	int ret;
+
+	fg = devm_kzalloc(dev, sizeof(*fg), GFP_KERNEL);
+	if (!fg)
+		return -ENOMEM;
+
+	fg->client = client;
+
+	ret = i2c_smbus_read_word_data(client, SM5714_FG_REG_DEVICE_ID);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read device ID\n");
+
+	ret = devm_mutex_init(dev, &fg->lock);
+	if (ret)
+		return ret;
+
+	psy_cfg.drv_data = fg;
+	psy_cfg.fwnode = dev_fwnode(dev);
+
+	psy = devm_power_supply_register(dev, &sm5714_fg_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return dev_err_probe(dev, PTR_ERR(psy), "failed to register power supply\n");
+
+	return 0;
+}
+
+static const struct of_device_id sm5714_fg_of_match[] = {
+	{ .compatible = "siliconmitus,sm5714-fuel-gauge" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sm5714_fg_of_match);
+
+static struct i2c_driver sm5714_fg_driver = {
+	.driver = {
+		.name = "sm5714-fuel-gauge",
+		.of_match_table = sm5714_fg_of_match,
+	},
+	.probe = sm5714_fg_probe,
+};
+module_i2c_driver(sm5714_fg_driver);
+
+MODULE_AUTHOR("Nizat Mikayilli <nacht@dxdmail.cc>");
+MODULE_DESCRIPTION("Silicon Mitus SM5714 fuel gauge driver");
+MODULE_LICENSE("GPL");

-- 
2.56.0


