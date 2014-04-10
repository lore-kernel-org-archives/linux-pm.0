From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: highbank: fix ARM_HIGHBANK_CPUFREQ dependency warning
Date: Thu, 10 Apr 2014 04:18:26 +0200
Message-ID: <1453884.JQRzhD9Q31@vostro.rjw.lan>
References: <1397010873-11020-1-git-send-email-wangkefeng.wang@huawei.com> <CAKohponpGAm4J2shQRV8doMZGT22eJ2MnU0+GzF-GkZirGPW5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponpGAm4J2shQRV8doMZGT22eJ2MnU0+GzF-GkZirGPW5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 09, 2014 09:58:26 AM Viresh Kumar wrote:
> On 9 April 2014 08:04, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > When make ARCH=arm multi_v7_defconfig, we get the following warnings:
> >
> > warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has
> > unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK
> > && REGULATOR && OF && THERMAL && CPU_THERMAL)
> >
> > To fix this, make ARM_HIGHBANK_CPUFREQ depend on ARCH_HAS_CPUFREQ and
> > REGULATOR instead of selecting them, PM_OPP will be selected by ARCH_HAS_CPUFREQ.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Well, it doesn't work as intended, I'm afraid:

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   588bc73d890c5dea35b7982a368c0e95089d5389
commit: 51be80edc69390521622df71855d86da4e358488 [67/68] cpufreq: highbank: fix ARM_HIGHBANK_CPUFREQ dependency warning
config: make ARCH=i386 allyesconfig

All warnings:

warning: (GENERIC_CPUFREQ_CPU0 && ARM_BIG_LITTLE_CPUFREQ && ARM_EXYNOS5440_CPUFREQ) selects PM_OPP which has unmet direct dependencies (ARCH_HAS_OPP)

> > ---
> >  drivers/cpufreq/Kconfig.arm | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
