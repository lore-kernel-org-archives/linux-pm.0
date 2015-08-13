From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH v2] Remove unselectable rule for arm-exynos-cpufreq.o
Date: Thu, 13 Aug 2015 22:01:23 +0900
Message-ID: <00c701d0d5c8$28186fd0$78494f70$@kernel.org>
References: <1439461941-13953-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <1439465318-18108-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <20150813113300.GU20238@linux>
 <CAJKOXPcxk3J0vmczJ7eOtUhzKxQW0Za0ZmgUAdX=jiT+eRxyKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJKOXPcxk3J0vmczJ7eOtUhzKxQW0Za0ZmgUAdX=jiT+eRxyKw@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Kukjin Kim' <kgene@kernel.org>
Cc: 'Jonas Rabenstein' <jonas.rabenstein@studium.uni-erlangen.de>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Krzysztof Kozlowski wrote:
> 
> 2015-08-13 20:33 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> > On 13-08-15, 13:28, Jonas Rabenstein wrote:
> >> Commit "cpufreq: exynos: remove Exynos4x12 specific cpufreq driver
> >> support" deleted option ARM_EXYNOS_CPUFREQ but missed to delete a rule
> >> in drivers/cpufreq/Makefile which depends on that option.
> >>
> >> Remove unselectable rule for arm-exynos-cpufreq.o from
> >> drivers/cpufreq/Makefile.
> >>
> >> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> >> ---
> >> I found this inconsistency using the undertaker and
> >> undertaker-checkpatch tools (https://undertaker.cs.fau.de/).
> >>
> >>  drivers/cpufreq/Makefile | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> >> index bbc4a9f..958be2b 100644
> >> --- a/drivers/cpufreq/Makefile
> >> +++ b/drivers/cpufreq/Makefile
> >> @@ -52,7 +52,6 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)             += arm_big_little_dt.o
> >>
> >>  obj-$(CONFIG_ARCH_DAVINCI)           += davinci-cpufreq.o
> >>  obj-$(CONFIG_UX500_SOC_DB8500)               += dbx500-cpufreq.o
> >> -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)     += arm-exynos-cpufreq.o
> >>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ) += exynos5440-cpufreq.o
> >>  obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)   += highbank-cpufreq.o
> >>  obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)  += hisi-acpu-cpufreq.o
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> And again from me:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Dear Kukjin,
> Can you take it and send in (updated) pull request with Exynos4x12
> cpufreq patches?
> 
OK, sure. I'll take this.

Thanks,
Kukjin
