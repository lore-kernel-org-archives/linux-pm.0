From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v11 06/10] power: bq27xxx_battery: Define access methods to write chip registers
Date: Mon, 20 Mar 2017 02:43:31 -0700
Message-ID: <20170320094335.19224-7-liam@networkimprov.net>
References: <20170320094335.19224-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35452 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdCTJuj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 05:50:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so18936695pge.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 02:50:38 -0700 (PDT)
In-Reply-To: <20170320094335.19224-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Declare bus.write/read_bulk/write_bulk() to support get/set of chip registers,
e.g. with inputs from power_supply_battery_info.

Add bq27xxx_write() & bq27xxx_xfer() helper functions to call the above.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2e2a3a8..f36a6f1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -807,6 +807,41 @@ static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
 	return ret;
 }
 
+static inline int bq27xxx_write(struct bq27xxx_device_info *di, int reg_index,
+				u16 value, bool single)
+{
+	int ret;
+
+	if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
+		return -EINVAL;
+
+	ret = di->bus.write(di, di->regs[reg_index], value, single);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to write register 0x%02x (index %d)\n",
+			di->regs[reg_index], reg_index);
+
+	return ret;
+}
+
+static inline int bq27xxx_xfer(struct bq27xxx_device_info *di,
+			       struct bq27xxx_dm_buf *buf, bool read)
+{
+	int ret;
+	int (*xfer)(struct bq27xxx_device_info*, u8, u8*, int) =
+		read ? di->bus.read_bulk : di->bus.write_bulk;
+
+	if (!di || di->regs[BQ27XXX_DM_DATA] == INVALID_REG_ADDR)
+		return -EINVAL;
+
+	ret = xfer(di, di->regs[BQ27XXX_DM_DATA], buf->a, BQ27XXX_DM_SZ);
+	if (ret < 0)
+		dev_dbg(di->dev, "failed to %s_bulk register 0x%02x (index %d)\n",
+			read ? "read" : "write",
+			di->regs[BQ27XXX_DM_DATA], BQ27XXX_DM_DATA);
+
+	return ret;
+}
+
 /*
  * Return the battery State-of-Charge
  * Or < 0 if something fails.
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b312bce..c3369fa 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -40,6 +40,9 @@ struct bq27xxx_platform_data {
 struct bq27xxx_device_info;
 struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
+	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool single);
+	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
+	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
 };
 
 struct bq27xxx_reg_cache {
-- 
2.9.3
