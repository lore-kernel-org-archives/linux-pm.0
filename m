From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: highbank: fix ARM_HIGHBANK_CPUFREQ dependency warning
Date: Wed, 9 Apr 2014 09:58:26 +0530
Message-ID: <CAKohponpGAm4J2shQRV8doMZGT22eJ2MnU0+GzF-GkZirGPW5g@mail.gmail.com>
References: <1397010873-11020-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1397010873-11020-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Langsdorf <mark.langsdorf@calxeda.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

On 9 April 2014 08:04, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> When make ARCH=arm multi_v7_defconfig, we get the following warnings:
>
> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has
> unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK
> && REGULATOR && OF && THERMAL && CPU_THERMAL)
>
> To fix this, make ARM_HIGHBANK_CPUFREQ depend on ARCH_HAS_CPUFREQ and
> REGULATOR instead of selecting them, PM_OPP will be selected by ARCH_HAS_CPUFREQ.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
