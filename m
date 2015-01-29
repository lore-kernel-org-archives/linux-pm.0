From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: exynos: allow modular build
Date: Thu, 29 Jan 2015 15:40:15 +0530
Message-ID: <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1799972.nQ2Axu0CEJ@wuerfel>
 <CAKohpom9L4jiMRGn3OaWyYM7iR3Ame4-LKG144yuHmRxCJud3g@mail.gmail.com>
 <2157802.ranbh8xTdL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2157802.ranbh8xTdL@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 29 January 2015 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> That might be close enough to what we want. It would by default enable
> ARM_EXYNOS_CPUFREQ for exynos based machines that do not use this driver
> (e.g. 5440, which has a separate driver, or exynos3/exynos7), but that
> can probably just be dealt with by disabling it in the user's defconfig.
> If i'm reading exynos_cpufreq_probe right, it would actually compile
> into an almost-empty file in this case and only kzalloc a few bytes
> of memory and then print a warning message.

I may be wrong this time around, but I will still try hard :

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0b2c33..91747c411d86 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -51,10 +51,9 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)              +=
arm_big_little_dt.o

 obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += exynos-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos-cpufreq.o exynos4210-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos-cpufreq.o exynos4x12-cpufreq.o
+obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos-cpufreq.o exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)   += exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)     += highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)                += imx6q-cpufreq.o
