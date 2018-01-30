From: Samuel Morris <samorris@lexmark.com>
Subject: Re: [PATCH] leds: use QoS to control LED suspend behavior from userspace
Date: Tue, 30 Jan 2018 09:55:27 -0500
Message-ID: <CAFY_6qqX9x-DQ+CQRS0Q6DGwzF-zJ6w++OxgU8-+kL_fjXnN_w@mail.gmail.com>
References: <20180129194947.11071-1-0v3rdr0n3@gmail.com> <20180130082817.GA4136@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20180130082817.GA4136@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: 0v3rdr0n3@gmail.com, Linux PM <linux-pm@vger.kernel.org>, linux-leds@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 30, 2018 at 3:28 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-01-29 19:49:47, 0v3rdr0n3@gmail.com wrote:
>> From: Samuel Morris <samorris@lexmark.com>
>>
>> Signed-off-by: Samuel Morris <samorris@lexmark.com>
>
> But... we'll really need description what this is supposed to do.

I have an LED that indicates to the user that the machine is still
powered when in suspend, so it needs to remain powered. This LED uses
the leds-pwm driver, but it may use a different driver on future
products, so making this change in that driver only would not be
ideal. I asked linux-pm a related question a week or two ago, and
Raphael Wysocki suggested looking into the PM_QOS_FLAG_NO_POWER_OFF
flag. This is what I came up with. I realize this is a pretty broad
change, but I figured I'd try the most general thing first.

>
> Because at least some LEDs (keyboard LEDs on PC) can't be powered on
> during suspend.

That is why I set the default behavior to PM_QOS_FLAG_NO_POWER_OFF=0 on probe.

>
> Does this work for your LEDs? Do we need a way for userspace to tell
> if LED supports it or not?

Yes, this fixes my problem. I could try testing on other LEDs as well
that use different drivers if need be.

I didn't see any reason not to make this userspace configurable. I
imagine for some LEDs, the switch just won't work. Are you aware of
any cases where attempting to keep an LED on would cause outright
breakage? I would like these QoS parameters to be device tree, or
otherwise per-board configurable, but I'm not aware of a standard way
to do that. Maybe someone from linux-pm has an idea. Something like
that might be more reasonable than allowing default userspace
configurability.

>
>> @@ -196,6 +197,11 @@ static int led_suspend(struct device *dev)
>>  {
>>       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>
>> +     if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>> +                     PM_QOS_FLAGS_ALL) {
>> +             return 0;
>> +     }
>
> "if (". No need for { } s.

Ok, I'll generate a new patch later if this seems likely to be integrated.

>
>> +
>>       if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>>               led_classdev_suspend(led_cdev);
>>
>> @@ -206,6 +212,11 @@ static int led_resume(struct device *dev)
>>  {
>>       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>
>> +     if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>> +                     PM_QOS_FLAGS_ALL) {
>> +             return 0;
>> +     }
>> +
>>       if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>>               led_classdev_resume(led_cdev);
>>
>> @@ -287,6 +298,18 @@ int led_classdev_register(struct device *parent, struct led_classdev *led_cdev)
>>       list_add_tail(&led_cdev->node, &leds_list);
>>       up_write(&leds_list_lock);
>>
>> +     /* Attempt to let userspace take over the policy. */
>> +     ret = dev_pm_qos_expose_flags(led_cdev->dev,
>> +                     PM_QOS_FLAG_NO_POWER_OFF);
>> +     if (ret < 0) {
>> +             dev_warn(led_cdev->dev, "failed to expose pm_qos_no_poweroff\n");
>> +             return 0;
>> +     }
>> +
>> +     ret = dev_pm_qos_update_flags(led_cdev->dev,
>> +                     PM_QOS_FLAG_NO_POWER_OFF,
>> +                     0);
>> +
>>       if (!led_cdev->max_brightness)
>>               led_cdev->max_brightness = LED_FULL;
>>
>
> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

thanks,
Sam
