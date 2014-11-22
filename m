From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] usb: dwc2: Fix build warning when CONFIG_PM_SLEEP=n
Date: Sat, 22 Nov 2014 02:18:14 +0100
Message-ID: <546FE456.5030302@intel.com>
References: <1416407873-18166-1-git-send-email-fabio.estevam@freescale.com> <20141119150148.GA5202@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51157 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbaKVBST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Nov 2014 20:18:19 -0500
In-Reply-To: <20141119150148.GA5202@saruman>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@ti.com, Fabio Estevam <fabio.estevam@freescale.com>
Cc: paulz@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11/19/2014 4:01 PM, Felipe Balbi wrote:
> HI,
>
> On Wed, Nov 19, 2014 at 12:37:53PM -0200, Fabio Estevam wrote:
>> Building with bcm2835_defconfig, which has CONFIG_PM_SLEEP=n causes the
>> following build warning:
>>
>> drivers/usb/dwc2/platform.c:227:12: warning: 'dwc2_suspend' defined but not used [-Wunused-function]
>> drivers/usb/dwc2/platform.c:237:12: warning: 'dwc2_resume' defined but not used [-Wunused-function]
>>
>> Annotate these functions with '__maybe_unused' to prevent the warnings.
>>
>> Reported-by: Olof's autobuilder <build@lixom.net>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>   drivers/usb/dwc2/platform.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
>> index 57eb8a3..ff0ed0b 100644
>> --- a/drivers/usb/dwc2/platform.c
>> +++ b/drivers/usb/dwc2/platform.c
>> @@ -224,7 +224,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
>>   	return retval;
>>   }
>>   
>> -static int dwc2_suspend(struct device *dev)
>> +static int __maybe_unused dwc2_suspend(struct device *dev)
> that SET_SYSTEM_SLEEP_PM_OPS again.
>
> Rafael, do you mind taking a patch like below:

I might, but ->

> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 383fd68..928e295 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -318,7 +318,6 @@ struct dev_pm_ops {
>   	int (*runtime_idle)(struct device *dev);
>   };
>   
> -#ifdef CONFIG_PM_SLEEP
>   #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>   	.suspend = suspend_fn, \
>   	.resume = resume_fn, \
> @@ -326,11 +325,7 @@ struct dev_pm_ops {
>   	.thaw = resume_fn, \
>   	.poweroff = suspend_fn, \
>   	.restore = resume_fn,
> -#else
> -#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
>   
> -#ifdef CONFIG_PM_SLEEP
>   #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>   	.suspend_late = suspend_fn, \
>   	.resume_early = resume_fn, \
> @@ -338,27 +333,16 @@ struct dev_pm_ops {
>   	.thaw_early = resume_fn, \
>   	.poweroff_late = suspend_fn, \
>   	.restore_early = resume_fn,
> -#else
> -#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> -#endif
>   
> -#ifdef CONFIG_PM_RUNTIME
>   #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>   	.runtime_suspend = suspend_fn, \
>   	.runtime_resume = resume_fn, \
>   	.runtime_idle = idle_fn,
> -#else
> -#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> -#endif
>   
> -#ifdef CONFIG_PM
>   #define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>   	.runtime_suspend = suspend_fn, \
>   	.runtime_resume = resume_fn, \
>   	.runtime_idle = idle_fn,
> -#else
> -#define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
> -#endif
>   
>   /*
>    * Use this if you want to use the same suspend and resume callbacks for suspend
>
> nobody will ever build a kernel without CONFIG_PM

-> that is not true.  The "tiny kernel" people what to be able to unset 
CONFIG_PM in particular.

> or any of its friends anyway and all that ifdeferry or __maybe_unused just to silence
> compilers warnings are very annoying.
>

We are modifying the power Kconfig in 3.19-rc1 so that PM_SLEEP will 
always select PM_RUNTIME, so some of the #ifdefs can safely go away.

Rafael

