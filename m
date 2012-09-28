From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/6] Change i2c_register_board_info from
 __init to __devinit
Date: Fri, 28 Sep 2012 15:40:18 +0800
Message-ID: <1348818018.10877.324.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>From 34aa38e12c04544d89af2eae46de284dc8a03b8d Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 27 Sep 2012 15:42:23 +0800
Subject: [RFC PATCH 4/6] Change i2c_register_board_info from __init to
 __devinit.

ACPI 5 supports enumerating I2C adapter and its slaves
via ACPI namespace, and this needs to be done at runtime,
after the ACPI I2C controller driver being loaded.

detailed usage of this API can be found in next patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/i2c/i2c-boardinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index f24cc64..1ecbbdc 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL_GPL(__i2c_first_dynamic_bus_num);
  * The board info passed can safely be __initdata, but be careful of embedded
  * pointers (for platform_data, functions, etc) since that won't be copied.
  */
-int __init
+int __devinit
 i2c_register_board_info(int busnum,
 	struct i2c_board_info const *info, unsigned len)
 {
-- 
1.7.7.6
