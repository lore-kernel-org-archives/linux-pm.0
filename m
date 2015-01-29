From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Thu, 29 Jan 2015 18:21:51 -0400
Message-ID: <20150129222150.GA29837@developer.amazonguestwifi.org>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <2157802.ranbh8xTdL@wuerfel>
 <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
 <1642077.OrkdxhO2uI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1642077.OrkdxhO2uI@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Arnd and Viresh,

On Thu, Jan 29, 2015 at 01:42:32PM +0100, Arnd Bergmann wrote:
> On Thursday 29 January 2015 15:40:15 Viresh Kumar wrote:
> >  obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
> >  obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
> > -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += exynos-cpufreq.o
> > -obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
> > -obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
> > -obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> > +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos-cpufreq.o exynos4210-cpufreq.o
> > +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos-cpufreq.o exynos4x12-cpufreq.o
> > +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos-cpufreq.o exynos5250-cpufreq.o
> > 
> 
> I'd have to try it, but this might fail if one of the three drivers
> is built-in and another one is a module.
> 
> 	Arnd

Let me make one step back here. The original issue is, now this exynos
cpufreq driver depends on of thermal; but of thermal can be built as
module, while this cpufreq driver cannot. Original proposal is to allow
module build in the exynos cpufreq driver.

On the original proposal, my concern is that the driver code does not
have separated modules, but one single module platform driver,  which uses functions from
other c files. On top of that, the patch originally allows four
(independent) modules builds. Although the children drivers still
selects the core part, we would still need to change the original patch
to add module dependency too.

So, my proposal was to, in order to allow module builds on this cpufreq
driver, we also need to properly construct the driver into a single
module, instead of several modules. The issue with my patch was the fact
that it was allowing platforms that do not use that driver, to select it
by default. And eventually this may cause a unusable module being loaded
into those systems.

Well, trying harder here in the same approach. The diff bellow is based
on Arnd's original patch and on Viresh's amendment, except that the core
part is now dependent on all the supported platforms, instead of
ARCH_EXYNOS. This way, it wont load in platforms that are not supposed
to be loaded. The user will be able to build the support for all
platforms, or select which platforms he/she wants (as originally),
except that now it can be a module, instead.

I believe now by default it will still keep the driver only on those
configs that expect it to be on. And it won't compile/load on platforms
that it is not supposed to. It brings closer a config that is dependent on this
driver, so it looks better in the menuconfig.

Let me know if I missed something (feel free to amend to your patch):

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3..c6e3a6e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -26,13 +26,21 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 
 
 config ARM_EXYNOS_CPUFREQ
-	bool
+	tristate "SAMSUNG EXYNOS CPUfreq Driver"
+	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
+	depends on THERMAL
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
+	  Supported SoC versions are:
+	     Exynos4210, Exynos4212, Exynos4412, and Exynos5250.
+
+	  If in doubt, say N.
 
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
 	depends on CPU_EXYNOS4210
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4210
 	  SoC (S5PV310 or S5PC210).
@@ -42,8 +50,8 @@ config ARM_EXYNOS4210_CPUFREQ
 config ARM_EXYNOS4X12_CPUFREQ
 	bool "SAMSUNG EXYNOS4x12"
 	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4X12
 	  SoC (EXYNOS4212 or EXYNOS4412).
@@ -53,28 +61,14 @@ config ARM_EXYNOS4X12_CPUFREQ
 config ARM_EXYNOS5250_CPUFREQ
 	bool "SAMSUNG EXYNOS5250"
 	depends on SOC_EXYNOS5250
+	depends on ARM_EXYNOS_CPUFREQ
 	default y
-	select ARM_EXYNOS_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS5440_CPUFREQ
-	bool "SAMSUNG EXYNOS5440"
-	depends on SOC_EXYNOS5440
-	depends on HAVE_CLK && OF
-	select PM_OPP
-	default y
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS5440
-	  SoC. The nature of exynos5440 clock controller is
-	  different than previous exynos controllers so not using
-	  the common exynos framework.
-
-	  If in doubt, say N.
-
 config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 	bool "EXYNOS Frequency Overclocking - Software"
 	depends on ARM_EXYNOS_CPUFREQ && THERMAL
@@ -90,6 +84,20 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 
 	  If in doubt, say N.
 
+config ARM_EXYNOS5440_CPUFREQ
+	bool "SAMSUNG EXYNOS5440"
+	depends on SOC_EXYNOS5440
+	depends on HAVE_CLK && OF
+	select PM_OPP
+	default y
+	help
+	  This adds the CPUFreq driver for Samsung EXYNOS5440
+	  SoC. The nature of exynos5440 clock controller is
+	  different than previous exynos controllers so not using
+	  the common exynos framework.
+
+	  If in doubt, say N.
+
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0..b26e2bf 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,10 +51,11 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= arm-exynos-cpufreq.o
+arm-exynos-cpufreq-y					:= exynos-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
+arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 9f2062a..32a895a 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -53,7 +53,7 @@ struct exynos_dvfs_info {
 	void __iomem	*cmu_regs;
 };
 
-#ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS4210_CPUFREQ)
 extern int exynos4210_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
@@ -61,7 +61,7 @@ static inline int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	return -EOPNOTSUPP;
 }
 #endif
-#ifdef CONFIG_ARM_EXYNOS4X12_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS4X12_CPUFREQ)
 extern int exynos4x12_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
@@ -69,7 +69,7 @@ static inline int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	return -EOPNOTSUPP;
 }
 #endif
-#ifdef CONFIG_ARM_EXYNOS5250_CPUFREQ
+#if IS_ENABLED(CONFIG_ARM_EXYNOS5250_CPUFREQ)
 extern int exynos5250_cpufreq_init(struct exynos_dvfs_info *);
 #else
 static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)

Eduardo Valentin
