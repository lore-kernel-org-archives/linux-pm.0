From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 3/8] cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code
 to work with common boost solution
Date: Fri, 26 Jul 2013 12:58:02 +0530
Message-ID: <CAKohpo=3+JP0ppru5DSo72yWiN3Qg9xjNJX+6KgCNiEupZEMjA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-4-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1374770011-22171-4-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c

>  static void __init acpi_cpufreq_boost_init(void)
>  {
> +       acpi_cpufreq_driver.boost_supported = false;

Would be better if we do this in else of below if.

>         if (boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)) {
>                 msrs = msrs_alloc();


> @@ -1021,12 +995,11 @@ static int __init acpi_cpufreq_init(void)
>                         *iter = &cpb;
>         }
>  #endif
> +       acpi_cpufreq_boost_init();

We are calling it before registering cpufreq driver. Will this have
any complications?

>         ret = cpufreq_register_driver(&acpi_cpufreq_driver);
>         if (ret)
>                 free_acpi_perf_data();
> -       else
> -               acpi_cpufreq_boost_init();
>
>         return ret;
