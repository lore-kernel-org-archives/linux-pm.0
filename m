From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/3] cpufreq / gx: Fix __init attribute locations
Date: Tue, 13 Aug 2013 18:20:08 +0800
Message-ID: <1376389210-11470-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54130 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615Ab3HMKVh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 06:21:37 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so8611433pab.39
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 03:21:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

 __init belongs after the return type on functions, not before it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/cpufreq/gx-suspmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 3dfc99b..e30fd16 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -183,7 +183,7 @@ static void gx_write_byte(int reg, int value)
  * gx_detect_chipset:
  *
  **/
-static __init struct pci_dev *gx_detect_chipset(void)
+static struct pci_dev * __init gx_detect_chipset(void)
 {
 	struct pci_dev *gx_pci = NULL;
 
-- 
1.7.9.5

