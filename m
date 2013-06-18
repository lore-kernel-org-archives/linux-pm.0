From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Thermal: x86_pkg_temp: fix krealloc() misuse in in pkg_temp_thermal_device_add()
Date: Tue, 18 Jun 2013 21:09:12 +0800
Message-ID: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:55794 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3FRNJO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2013 09:09:14 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik8so1785972bkc.9
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2013 06:09:13 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

If krealloc() returns NULL, it doesn't free the original. So any code
of the form 'foo = krealloc(foo, ...);' is almost certainly a bug.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 5de56f6..b90e84b 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -394,6 +394,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	char buffer[30];
 	int thres_count;
 	u32 eax, ebx, ecx, edx;
+	u8 *temp;
 
 	cpuid(6, &eax, &ebx, &ecx, &edx);
 	thres_count = ebx & 0x07;
@@ -417,13 +418,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	spin_lock(&pkg_work_lock);
 	if (topology_physical_package_id(cpu) > max_phy_id)
 		max_phy_id = topology_physical_package_id(cpu);
-	pkg_work_scheduled = krealloc(pkg_work_scheduled,
-				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
-	if (!pkg_work_scheduled) {
+	temp = krealloc(pkg_work_scheduled,
+			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
+	if (!temp) {
 		spin_unlock(&pkg_work_lock);
 		err = -ENOMEM;
 		goto err_ret_free;
 	}
+	pkg_work_scheduled = temp;
 	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
 	spin_unlock(&pkg_work_lock);
 

