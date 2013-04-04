From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/18] cpufreq: blackfin: move cpufreq
	driver to drivers/cpufreq
Date: Thu,  4 Apr 2013 18:24:18 +0530
Message-ID: <23070472a9b7ed67cd4411b6c43a1f8770d7d11d.1365079581.git.viresh.kumar@linaro.org>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <cover.1365079581.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1365079581.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1365079581.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: robin.randhawa-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Liviu.Dudau-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steve.Bannister-5wv7dgnIgG8@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, arvind.chauhan-5wv7dgnIgG8@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, charles.garcia-tobin-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch moves cpufreq driver of BLACKFIN architecture to drivers/cpufreq.

Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/mach-common/Makefile                                       | 1 -
 drivers/cpufreq/Makefile                                                 | 1 +
 .../blackfin/mach-common/cpufreq.c => drivers/cpufreq/blackfin-cpufreq.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/blackfin/mach-common/cpufreq.c => drivers/cpufreq/blackfin-cpufreq.c (100%)

diff --git a/arch/blackfin/mach-common/Makefile b/arch/blackfin/mach-common/Makefile
index 75f0ba2..675466d 100644
--- a/arch/blackfin/mach-common/Makefile
+++ b/arch/blackfin/mach-common/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_PM)          += pm.o
 ifneq ($(CONFIG_BF60x),y)
 obj-$(CONFIG_PM)	  += dpmc_modes.o
 endif
-obj-$(CONFIG_CPU_FREQ)    += cpufreq.o
 obj-$(CONFIG_CPU_VOLTAGE) += dpmc.o
 obj-$(CONFIG_SMP)         += smp.o
 obj-$(CONFIG_BFIN_KERNEL_CLOCK) += clocks-init.o
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 36a93a6..19de776 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -83,3 +83,4 @@ obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)	+= at32ap-cpufreq.o
+obj-$(CONFIG_BLACKFIN)			+= blackfin-cpufreq.o
diff --git a/arch/blackfin/mach-common/cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
similarity index 100%
rename from arch/blackfin/mach-common/cpufreq.c
rename to drivers/cpufreq/blackfin-cpufreq.c
-- 
1.7.12.rc2.18.g61b472e
