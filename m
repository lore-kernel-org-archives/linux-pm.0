From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] acpi-cpufreq: De-register cpu notifier and free struct msr
 on error.
Date: Tue, 28 Jan 2014 10:41:52 +0100
Message-ID: <20140128104152.502ef069@amdc2363>
References: <1390881491-18998-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1390881491-18998-1-git-send-email-konrad.wilk@oracle.com>
Sender: cpufreq-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-pm@vger.kernel.org

Hi Konrad,

> If cpufreq_register_driver() fails we would free the acpi driver
> related structures but not free the ones allocated
> by acpi_cpufreq_boost_init() function. This meant that as
> the driver error-ed out and a CPU online/offline event came
> we would crash and burn as one of the CPU notifiers would point
> to garbage.
> 

Thanks for spotting this bug. My bad.

> This fixes a regression that commit
> cfc9c8ed03e4d908f2388af8815f44c87b503aaf "acpi-cpufreq: Adjust the
> code to use the common boost attribute" introduced.
> 
> CC: Lukasz Majewski <l.majewski@samsung.com>
> CC: Myungjoo Ham <myungjoo.ham@samsung.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c
> b/drivers/cpufreq/acpi-cpufreq.c index 79e5608..3e856d6 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -969,9 +969,10 @@ static int __init acpi_cpufreq_init(void)
>  	acpi_cpufreq_boost_init();
>  
>  	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
> -	if (ret)
> +	if (ret) {
>  		free_acpi_perf_data();
> -
> +		acpi_cpufreq_boost_exit();
> +	}
>  	return ret;
>  }
>  

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
