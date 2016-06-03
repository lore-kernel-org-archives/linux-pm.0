From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH] leds: handle suspend/resume in heartbeat trigger
Date: Fri, 03 Jun 2016 12:04:52 +0200
Message-ID: <57515644.9050604@samsung.com>
References: <1464874906-13120-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFp3DnGp2MRQOSOpRHhuD5_2MiA2Wge01W6B43YHpQ8S8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:14166 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbcFCKE4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 06:04:56 -0400
In-reply-to: <CAPDyKFp3DnGp2MRQOSOpRHhuD5_2MiA2Wge01W6B43YHpQ8S8Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 06/03/2016 11:32 AM, Ulf Hansson wrote:
> On 2 June 2016 at 15:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The following phenomena was observed: when suspending the
>> system, sometimes the heartbeat LED was left on, glowing and
>> wasting power while the rest of the system is asleep, also
>> disturbing power dissapation measures on the odd suspend
>> cycle when it's left on.
>>
>> Clearly this is not how we want the heartbeat trigger to
>> work: it should turn off and leave the LED off during
>> system suspend.
>
> Agree!
>
>>
>> This removes the heartbeat trigger when preparing suspend and
>> restores it during resume. The trigger code will make sure all
>> LEDs are left in OFF state after removing the trigger, and
>> will re-enable the trigger on all LEDs after resuming.
>
> I believe most other led-trigger types that should also be "suspended"
> in the similar fashion as the heartbeat. Perhaps not all, but least
> some more (timer, cpu, etc).
>
> I looked at the cpu trigger, which currently registers a syscore_ops
> to deal with suspend/resume. That means the trigger being suspended
> far later in system PM suspend phase, and I wonder if that is really
> necessary!?
> Does people really care about the cpu trigger being active that late
> in the system PM suspend phase!?
>
> More importantly, I think it could be problematic to allow it that
> late in system PM phase, at least for for those ARM SoC I have been
> working on which might use an i2c transfer to control the led.
>
> Okay, my point is, perhaps we should do this in a more generic manner
> and manage the suspend/resume of triggers in
> drivers/leds/led-triggers.c?

We'd have to consider it in connection with pm_ops in led-class.c, which
set brightness to LED_OFF on suspend and set it back to the previous
value on resume. Setting brightness to LED_OFF results also in disabling
blinking. In case of drivers that implement blink_set op this results
in disabling hardware blinking, but it is not reactivated upon resume,
where only brightness_set{_blocking} op is called.

> If we need the suspend/resume trigger to be optional, we can add that
> as a configuration flag in struct led_trigger, to inform the
> led-triggers.c about the wanted behaviour. In that way, each
> led-trigger type don't have to register their own set of pm_notifiers.

> Some core comments below...
>
>>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>   drivers/leds/trigger/ledtrig-heartbeat.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
>> index 410c39c62dc7..c80e91152b6b 100644
>> --- a/drivers/leds/trigger/ledtrig-heartbeat.c
>> +++ b/drivers/leds/trigger/ledtrig-heartbeat.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/leds.h>
>>   #include <linux/reboot.h>
>> +#include <linux/suspend.h>
>>   #include "../leds.h"
>>
>>   static int panic_heartbeats;
>> @@ -154,6 +155,26 @@ static struct led_trigger heartbeat_led_trigger = {
>>          .deactivate = heartbeat_trig_deactivate,
>>   };
>>
>> +static int heartbeat_pm_notifier(struct notifier_block *nb,
>> +                                unsigned long pm_event, void *unused)
>> +{
>> +       int rc;
>> +
>> +       switch (pm_event) {
>> +       case PM_SUSPEND_PREPARE:
>
> I think you should add:
> case PM_HIBERNATION_PREPARE:
> case PM_RESTORE_PREPARE:
>
>> +               led_trigger_unregister(&heartbeat_led_trigger);
>> +               break;
>> +       case PM_POST_SUSPEND:
>
> I think you should add:
> case PM_POST_HIBERNATION:
> case PM_POST_RESTORE:
>
>> +               rc = led_trigger_register(&heartbeat_led_trigger);
>> +               if (rc)
>> +                       pr_err("could not re-register heartbeat trigger\n");
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       return NOTIFY_DONE;
>> +}
>> +
>>   static int heartbeat_reboot_notifier(struct notifier_block *nb,
>>                                       unsigned long code, void *unused)
>>   {
>> @@ -168,6 +189,10 @@ static int heartbeat_panic_notifier(struct notifier_block *nb,
>>          return NOTIFY_DONE;
>>   }
>>
>> +static struct notifier_block heartbeat_pm_nb = {
>> +       .notifier_call = heartbeat_pm_notifier,
>> +};
>> +
>>   static struct notifier_block heartbeat_reboot_nb = {
>>          .notifier_call = heartbeat_reboot_notifier,
>>   };
>> @@ -184,12 +209,14 @@ static int __init heartbeat_trig_init(void)
>>                  atomic_notifier_chain_register(&panic_notifier_list,
>>                                                 &heartbeat_panic_nb);
>>                  register_reboot_notifier(&heartbeat_reboot_nb);
>> +               register_pm_notifier(&heartbeat_pm_nb);
>>          }
>>          return rc;
>>   }
>>
>>   static void __exit heartbeat_trig_exit(void)
>>   {
>> +       unregister_pm_notifier(&heartbeat_pm_nb);
>>          unregister_reboot_notifier(&heartbeat_reboot_nb);
>>          atomic_notifier_chain_unregister(&panic_notifier_list,
>>                                           &heartbeat_panic_nb);
>> --
>> 2.4.11
>>
>
> Besides my upper comments, this looks like a good approach!
>
> Kind regards
> Uffe
>
>


-- 
Best regards,
Jacek Anaszewski
