From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OLPC rtc-cmos support
Date: Sun, 8 Jul 2007 12:10:50 -0700
Message-ID: <200707081210.51145.david-b__1837.99112351171$1183921982$gmane$org@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707072213.41028.david-b@pacbell.net>
	<20070708184035.GA20078@dmt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708184035.GA20078@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 July 2007, Marcelo Tosatti wrote:

> Like this? 

Not quite ...


> +struct resource rtc_platform_irq = {
> +	.flags = IORESOURCE_IRQ,
> +	.start = 8,
> +	.end = 8,
> +};

Unused, right?


> +static int olpc_rtc_init(void)

... should be marked __init ...

> +{
> +	rtc_info.rtc_day_alarm = 0;
> +	rtc_info.rtc_mon_alarm = 0;
> +	rtc_info.rtc_century = 0;
> +	rtc_info.wake_on = rtc_wake_on;
> +	rtc_info.wake_off = rtc_wake_off;

... that can all just be static init ...

> +
> +	(void)platform_device_register(&olpc_rtc_device);
> +
> +	device_init_wakeup(&olpc_rtc_device.dev, 1);

... do the init_wakeup before registering the device, so
there can never be confusion about whether a probe() will
see that part of device config ...

> +
> +	return 0;
> +}
> +fs_initcall(olpc_rtc_init);

... and try to register platform devices in arch_initcall().
Just to avoid potential confusion; that's where it's normally
done, and I don't think you had a need to do it elsewhere.

- Dave



> +#endif /* CONFIG_RTC_DRV_CMOS */
> +
>  static void olpc_pm_exit(void)
>  {
>  	/* Clear any pending events, and disable them */
> 
