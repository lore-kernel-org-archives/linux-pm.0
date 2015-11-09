From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: bq27xxx_battery: Revert "Remove unneeded dependency in
 Kconfig"
Date: Mon, 09 Nov 2015 14:50:47 +0100
Message-ID: <3819790.E2ziFviWmU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Xiong Zhou <jencce.kernel@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, linux-i2c@vger.kernel.org, Pali Rohar <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The dependency was clearly needed, without it it is possible to
build the core i2c driver as a loadable module and the bq27xxx
driver built-in, which results in link errors:

drivers/built-in.o: In function `bq27xxx_battery_i2c_read':
binder.c:(.text+0x360bf0): undefined reference to `i2c_transfer'
binder.c:(.text+0x360c10): undefined reference to `i2c_transfer'
drivers/built-in.o: In function `bq27xxx_battery_init':
binder.c:(.init.text+0xe668): undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `bq27xxx_battery_exit':
binder.c:(.exit.text+0x1a0c): undefined reference to `i2c_del_driver'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
---
The bug was originally found and fixed by Xiong Zhou, but Andrew Davis
broke it again by reverting the fix.

I found it today on my ARM randconfig builds.

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 237d7aa73e8c..9f53fb74ae6f 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -159,6 +159,7 @@ config BATTERY_SBS
 
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
+	depends on I2C || I2C=n
 	help
 	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) chips.
