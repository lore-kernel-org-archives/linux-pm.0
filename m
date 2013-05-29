From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: MAINTAINERS: Add git tree path for ARM specific updates
Date: Wed, 29 May 2013 16:10:43 +0530
Message-ID: <aab5b5dc92b960e81e8fd1975eba81234a4ecac8.1369817795.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

To reduce cpufreq maintenance load on Rafael, ARM specific patches would be
Applied by me now. Rafael will pull in these changes from time to time (at
rc's). Additionally I would be sending him pull request for every merge window
and rc's (for fixes).

Web interface of my tree is present here:

https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=summary

Branch names would be: cpufreq-next and cpufreq-fixes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3a495..50c81bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2216,6 +2216,7 @@ L:	cpufreq@vger.kernel.org
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+T:	git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 
-- 
1.7.12.rc2.18.g61b472e

