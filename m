From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v8 8/9] power: bq27xxx_battery: Add print_dm_blocks() to log chip memory
Date: Sun, 26 Feb 2017 23:11:16 -0800
Message-ID: <20170227071117.18934-9-liam@networkimprov.net>
References: <20170227071117.18934-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36572 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdB0HNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2017 02:13:45 -0500
Received: by mail-pg0-f67.google.com with SMTP id 25so3343681pgy.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2017 23:12:16 -0800 (PST)
In-Reply-To: <20170227071117.18934-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Enable listing of chip RAM and/or NVM at startup, for debugging use.
Intially supports BQ27425. Support for other chips may be added.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 41d4ce7..8ba0568 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -703,6 +703,74 @@ static int bq27xxx_battery_read_dm_block(struct bq27xxx_device_info *di,
 	return ret;
 }
 
+/* Translate F4 floating point values to/from hexadecimal:
+ *   perl -e 'printf("%08x\n", unpack("I", pack("f", 3.93e-4   )))' # 39ce0b91
+ *   perl -e 'printf("%f\n"  , unpack("f", pack("I", 0x39ce0b91)))' # 0.000393
+ */
+
+#define BQ27XXX_DM_INFO(f,o,v) dev_info(di->dev, "offset %d, " f "\n", o, v)
+
+static void bq27xxx_battery_print_dm_blocks(struct bq27xxx_device_info *di) {
+	enum { H1, H2, H4, I1, I2, U1, F4 };
+
+	struct dm_reg { int offset, type; }
+		/* each array row describes one data block */
+		c425_s82[][10] = {
+			{ { 2,H1},{ 3,I2},{ 5,H2},{12,I2},{14,I2},{18,I2},{22,I2},{29,U1},{30,I2},{99,0} },
+			{ {32,I2},{34,I2},{36,I2},{38,U1},{39,U1},{40,F4},{99,0} },
+		},
+		c425_s104[][10] = {
+			{ { 0,I2},{ 2,I1},{ 3,I1},{ 4,I1},{99,0} },
+		},
+		c425_s105[][10] = {
+			{ { 0,F4},{ 4,I2},{99,0} },
+		};
+		/* add more subclass maps here */
+
+	struct dm_class { int id, blocks; struct dm_reg (*reg)[10]; }
+		c425[] = {
+			{ .id =  82, .blocks = 2, .reg = c425_s82  },
+			{ .id = 104, .blocks = 1, .reg = c425_s104 },
+			{ .id = 105, .blocks = 1, .reg = c425_s105 },
+			{ .reg = NULL }
+		};
+		/* add more chip maps here */
+
+	struct dm_class *chip = c425; /* set to your chip */
+
+	struct bq27xxx_dm_buf buf = { };
+	int c, b, r;
+
+	for (c=0; chip[c].reg != NULL; ++c) {
+		buf.class = chip[c].id;
+		dev_info(di->dev, "subclass %d registers...\n", chip[c].id);
+
+		for (b=0; b < chip[c].blocks; ++b) {
+			buf.block = b;
+			if (bq27xxx_battery_read_dm_block(di, &buf) < 0)
+				continue;
+
+			for (r=0; chip[c].reg[b][r].offset != 99; ++r) {
+				int o = chip[c].reg[b][r].offset;
+				u8* p = &buf.a[o % BQ27XXX_DM_SZ];
+
+				switch (chip[c].reg[b][r].type) {
+				case H1: BQ27XXX_DM_INFO("%02x", o,   *p); break;
+				case I1: BQ27XXX_DM_INFO("%d", o, (s8)*p); break;
+				case U1: BQ27XXX_DM_INFO("%u", o,     *p); break;
+				case H2: BQ27XXX_DM_INFO("%04x", o,
+						   be16_to_cpup((u16*)p)); break;
+				case I2: BQ27XXX_DM_INFO("%d", o,
+					      (s16)be16_to_cpup((u16*)p)); break;
+				case H4:
+				case F4: BQ27XXX_DM_INFO("%08x", o,
+						   be32_to_cpup((u32*)p)); break;
+				}
+			}
+		}
+	}
+}
+
 static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
 					    struct bq27xxx_dm_buf *buf,
 					    enum bq27xxx_dm_reg_id reg_id,
@@ -936,6 +1004,8 @@ void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 	bq27xxx_battery_set_config(di, &info);
 
 out:
+	/* bq27xxx_battery_print_dm_blocks(di); uncomment for debugging */
+	(void)bq27xxx_battery_print_dm_blocks; /* prevent compiler warning */
 	bq27xxx_battery_set_seal_state(di, true);
 }
 
-- 
2.9.3
