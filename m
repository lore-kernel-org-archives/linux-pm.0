From: kbuild test robot <fengguang.wu@intel.com>
Subject: drivers/cpuidle/driver.c:81:1: sparse: symbol
 '__pcpu_scope_cpuidle_drivers' was not declared. Should it be static?
Date: Fri, 02 Nov 2012 10:52:24 +0800
Message-ID: <50933568.RII3EAaoOWvGDiO6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_50933568.YW4QNls9isen1RcIFvI93nXHufzQy+v0y8+aR8a7+DT47PhA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9071 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762607Ab2KBCww (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Nov 2012 22:52:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This is a multi-part message in MIME format.

--=_50933568.YW4QNls9isen1RcIFvI93nXHufzQy+v0y8+aR8a7+DT47PhA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   e709b61f9efd3b4ac899e5c4f7b881fdc694f343
commit: 4e6eebfe11765c746aef06f7c6aa0a6d3ff34a1c cpuidle: support multiple drivers
date:   5 hours ago


sparse warnings:

+ drivers/cpuidle/driver.c:81:1: sparse: symbol '__pcpu_scope_cpuidle_drivers' was not declared. Should it be static?

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--=_50933568.YW4QNls9isen1RcIFvI93nXHufzQy+v0y8+aR8a7+DT47PhA
Content-Type: text/x-diff;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="make-it-static-4e6eebf.diff"

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 465e256..3af841f 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -78,7 +78,7 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
 
 #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
 
-DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
+static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
 
 static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
 {

--=_50933568.YW4QNls9isen1RcIFvI93nXHufzQy+v0y8+aR8a7+DT47PhA--
