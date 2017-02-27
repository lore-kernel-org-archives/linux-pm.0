From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v8 5/9] power: bq27xxx_battery: Define access methods to write chip registers
Date: Sun, 26 Feb 2017 23:11:13 -0800
Message-ID: <20170227071117.18934-6-liam@networkimprov.net>
References: <20170227071117.18934-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35108 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdB0HNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2017 02:13:45 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so12022241pgz.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2017 23:12:12 -0800 (PST)
In-Reply-To: <20170227071117.18934-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

write(), read_bulk(), write_bulk() support setting chip registers,
e.g. with data obtained from power_supply_battery_info.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 include/linux/power/bq27xxx_battery.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bed9557..92df553 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -32,6 +32,9 @@ struct bq27xxx_platform_data {
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
