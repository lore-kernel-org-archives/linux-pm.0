From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] intel_idle: avoid theoretical uninitialized data usage
Date: Mon, 24 Oct 2016 17:52:37 +0200
Message-ID: <20161024155259.3041159-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60382 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933767AbcJXPxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 11:53:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Henroid <andrew.d.henroid@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_PCI is disabled, pci_read_config_byte() may not update
its result, as indicated by this warning:

drivers/idle/i7300_idle.c: In function ‘i7300_idle_notifier’:
drivers/idle/i7300_idle.c:423:141: warning: ‘got_ctl’ may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/idle/i7300_idle.c:415:5: note: ‘got_ctl’ was declared here

We know the function is never called if CONFIG_PCI is not set, so
this is harmless, but we can avoid the problem by checking the
return value of the config space accessor before using the result.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/idle/i7300_idle.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index ffeebc7e9f1c..9a104e558c77 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -347,6 +347,7 @@ static int i7300_idle_thrt_save(void)
 {
 	u32 new_mc_val;
 	u8 gblactlm;
+	int ret;
 
 	pci_read_config_byte(fbd_dev, DIMM_THRTCTL, &i7300_idle_thrtctl_saved);
 	pci_read_config_byte(fbd_dev, DIMM_THRTLOW, &i7300_idle_thrtlow_saved);
@@ -364,7 +365,9 @@ static int i7300_idle_thrt_save(void)
 	 * unlimited-activations while in open-loop throttling (i.e., when
 	 * Global Activation Throttle Limit is zero).
 	 */
-	pci_read_config_byte(fbd_dev, DIMM_GBLACT, &gblactlm);
+	ret = pci_read_config_byte(fbd_dev, DIMM_GBLACT, &gblactlm);
+	if (ret)
+		return ret;
 	dprintk("thrtctl_saved = 0x%02x, thrtlow_saved = 0x%02x\n",
 		i7300_idle_thrtctl_saved,
 		i7300_idle_thrtlow_saved);
@@ -413,14 +416,16 @@ static void i7300_idle_stop(void)
 {
 	u8 new_ctl;
 	u8 got_ctl;
+	int ret;
 
 	new_ctl = i7300_idle_thrtctl_saved & ~DIMM_THRTCTL_THRMHUNT;
 	pci_write_config_byte(fbd_dev, DIMM_THRTCTL, new_ctl);
 
 	pci_write_config_byte(fbd_dev, DIMM_THRTLOW, i7300_idle_thrtlow_saved);
 	pci_write_config_byte(fbd_dev, DIMM_THRTCTL, i7300_idle_thrtctl_saved);
-	pci_read_config_byte(fbd_dev, DIMM_THRTCTL, &got_ctl);
-	WARN_ON_ONCE(got_ctl != i7300_idle_thrtctl_saved);
+	ret = pci_read_config_byte(fbd_dev, DIMM_THRTCTL, &got_ctl);
+
+	WARN_ON_ONCE(ret || (got_ctl != i7300_idle_thrtctl_saved));
 }
 
 
-- 
2.9.0

