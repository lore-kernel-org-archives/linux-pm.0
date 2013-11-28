From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2] cpufreq: exynos: Convert exynos-cpufreq to platform driver
Date: Thu, 28 Nov 2013 17:10:39 +0530
Message-ID: <CAK9yfHwzgmWxA2pOpHa0O0C8+zUGOxvH5jrNBM4bYEMiM8N2jQ@mail.gmail.com>
References: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
	<1385638547-2974-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385638547-2974-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 28 November 2013 17:05, Lukasz Majewski <l.majewski@samsung.com> wrote:
> To make the driver multiplatform-friendly, unconditional initialization
> in an initcall is replaced with a platform driver probed only if
> respective platform device is registered.
>
> Tested at: Exynos4210 (TRATS) and Exynos4412 (TRATS2)
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> Changes for v2:
> - Proper definition of exynos_cpufreq_init() function to squash warnings

Looks good. Just one minor nit which I forgot to mention earlier.

[snip]

>
> -static int __init exynos_cpufreq_init(void)
> +static int exynos_cpufreq_init(struct platform_device *pdev)

How about renaming this function to exynos_cpufreq_probe?

-- 
With warm regards,
Sachin
