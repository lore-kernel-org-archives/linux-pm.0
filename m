From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2] leds: handle suspend/resume in heartbeat trigger
Date: Wed, 08 Jun 2016 11:54:52 +0200
Message-ID: <5757EB6C.10603@samsung.com>
References: <1465374588-8453-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1465374588-8453-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Thanks for the improved version.
Replaced the old one on linux-leds.git, for-next branch.

Best regards,
Jacek Anaszewski

On 06/08/2016 10:29 AM, Linus Walleij wrote:
> The following phenomena was observed: when suspending the
> system, sometimes the heartbeat LED was left on, glowing and
> wasting power while the rest of the system is asleep, also
> disturbing power dissapation measures on the odd suspend
> cycle when it's left on.
>
> Clearly this is not how we want the heartbeat trigger to
> work: it should turn off and leave the LED off during
> system suspend.
>
> This removes the heartbeat trigger when preparing suspend and
> restores it during resume. The trigger code will make sure all
> LEDs are left in OFF state after removing the trigger, and
> will re-enable the trigger on all LEDs after resuming.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Also register/unregister the trigger on PM_RESTORE and
>    PM_HIBERNATION notifications.
> - Jacek if you already applied v1 please apply this instead,
>    or tell me and I can make an incremental patch.
> ---
>   drivers/leds/trigger/ledtrig-heartbeat.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
> index 410c39c62dc7..c9f386213e9e 100644
> --- a/drivers/leds/trigger/ledtrig-heartbeat.c
> +++ b/drivers/leds/trigger/ledtrig-heartbeat.c
> @@ -19,6 +19,7 @@
>   #include <linux/sched.h>
>   #include <linux/leds.h>
>   #include <linux/reboot.h>
> +#include <linux/suspend.h>
>   #include "../leds.h"
>
>   static int panic_heartbeats;
> @@ -154,6 +155,30 @@ static struct led_trigger heartbeat_led_trigger = {
>   	.deactivate = heartbeat_trig_deactivate,
>   };
>
> +static int heartbeat_pm_notifier(struct notifier_block *nb,
> +				 unsigned long pm_event, void *unused)
> +{
> +	int rc;
> +
> +	switch (pm_event) {
> +	case PM_SUSPEND_PREPARE:
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		led_trigger_unregister(&heartbeat_led_trigger);
> +		break;
> +	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		rc = led_trigger_register(&heartbeat_led_trigger);
> +		if (rc)
> +			pr_err("could not re-register heartbeat trigger\n");
> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
>   static int heartbeat_reboot_notifier(struct notifier_block *nb,
>   				     unsigned long code, void *unused)
>   {
> @@ -168,6 +193,10 @@ static int heartbeat_panic_notifier(struct notifier_block *nb,
>   	return NOTIFY_DONE;
>   }
>
> +static struct notifier_block heartbeat_pm_nb = {
> +	.notifier_call = heartbeat_pm_notifier,
> +};
> +
>   static struct notifier_block heartbeat_reboot_nb = {
>   	.notifier_call = heartbeat_reboot_notifier,
>   };
> @@ -184,12 +213,14 @@ static int __init heartbeat_trig_init(void)
>   		atomic_notifier_chain_register(&panic_notifier_list,
>   					       &heartbeat_panic_nb);
>   		register_reboot_notifier(&heartbeat_reboot_nb);
> +		register_pm_notifier(&heartbeat_pm_nb);
>   	}
>   	return rc;
>   }
>
>   static void __exit heartbeat_trig_exit(void)
>   {
> +	unregister_pm_notifier(&heartbeat_pm_nb);
>   	unregister_reboot_notifier(&heartbeat_reboot_nb);
>   	atomic_notifier_chain_unregister(&panic_notifier_list,
>   					 &heartbeat_panic_nb);
>
