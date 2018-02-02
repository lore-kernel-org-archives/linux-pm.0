From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH] leds: use QoS to control LED suspend behavior from
 userspace
Date: Fri, 2 Feb 2018 21:52:14 +0100
Message-ID: <f415fc12-0ffa-35e9-b7e5-57184d1a9aee@gmail.com>
References: <20180129194947.11071-1-0v3rdr0n3@gmail.com>
 <20180130082817.GA4136@amd>
 <CAFY_6qqX9x-DQ+CQRS0Q6DGwzF-zJ6w++OxgU8-+kL_fjXnN_w@mail.gmail.com>
 <fbebed0e-22ec-a13a-0bdd-7b241c21ab30@gmail.com>
 <CAFY_6qqxo2jF=5cd_Hd5svv3sGH7t8j+RVAShCZ-P-_gfAkufQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45357 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeBBUx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Feb 2018 15:53:29 -0500
In-Reply-To: <CAFY_6qqxo2jF=5cd_Hd5svv3sGH7t8j+RVAShCZ-P-_gfAkufQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Samuel Morris <samorris@lexmark.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sam Morris <0v3rdr0n3@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, linux-leds@vger.kernel.org

On 02/02/2018 04:40 PM, Samuel Morris wrote:
> On Thu, Feb 1, 2018 at 4:29 PM, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> Hi Samuel,
>>
>> Thanks for the patch.
>>
>> On 01/30/2018 03:55 PM, Samuel Morris wrote:
>>> On Tue, Jan 30, 2018 at 3:28 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>>> On Mon 2018-01-29 19:49:47, 0v3rdr0n3@gmail.com wrote:
>>>>> From: Samuel Morris <samorris@lexmark.com>
>>>>>
>>>>> Signed-off-by: Samuel Morris <samorris@lexmark.com>
>>>>
>>>> But... we'll really need description what this is supposed to do.
>>>
>>> I have an LED that indicates to the user that the machine is still
>>> powered when in suspend, so it needs to remain powered. This LED uses
>>> the leds-pwm driver, but it may use a different driver on future
>>> products, so making this change in that driver only would not be
>>> ideal. I asked linux-pm a related question a week or two ago, and
>>> Raphael Wysocki suggested looking into the PM_QOS_FLAG_NO_POWER_OFF
>>> flag. This is what I came up with. I realize this is a pretty broad
>>> change, but I figured I'd try the most general thing first.
>>>
>>>>
>>>> Because at least some LEDs (keyboard LEDs on PC) can't be powered on
>>>> during suspend.
>>>
>>> That is why I set the default behavior to PM_QOS_FLAG_NO_POWER_OFF=0 on probe.
>>>
>>>>
>>>> Does this work for your LEDs? Do we need a way for userspace to tell
>>>> if LED supports it or not?
>>>
>>> Yes, this fixes my problem. I could try testing on other LEDs as well
>>> that use different drivers if need be.
>>>
>>> I didn't see any reason not to make this userspace configurable. I
>>> imagine for some LEDs, the switch just won't work. Are you aware of
>>> any cases where attempting to keep an LED on would cause outright
>>> breakage? I would like these QoS parameters to be device tree, or
>>> otherwise per-board configurable, but I'm not aware of a standard way
>>> to do that. Maybe someone from linux-pm has an idea. Something like
>>> that might be more reasonable than allowing default userspace
>>> configurability.
>>
>> There is already retain-state-suspended property defined in
>> Documentation/devicetree/bindings/leds/leds-gpio.txt and used
>> in drivers/leds/leds-gpio.c. Now if we are going to add generic
>> pm_qos support to the LED core, the DT property should be made generic
>> too and moved to the Documentation/devicetree/bindings/leds/common.txt.
> 
> Sounds good, I'll start working on it. Though I can't help but think,
> if all devices share this pm_qos interface, couldn't the device tree
> interface be shared as well?

Could you please elaborate on that?

>> Then, if the property is present, we shouldn't expose this setting
>> to the userspace, see below.
> 
> I'm okay with dt only configurability. Though, if you're suggesting we
> should expose the flag to userspace based on whether or not it's dt
> configurable, I'm not so sure. I think those decisions should be
> independent. 

My concern here is backward compatibility - current users expect that
once the property is set in DT, the behavior on suspend is guaranteed
to not change.

> When you expose that flag with dev_pm_qos_expose_flags(),
> you also expose other flags.

How so? You're exposing only one flag:

dev_pm_qos_expose_flags(led_cdev->dev, PM_QOS_FLAG_NO_POWER_OFF)

I'm not familiar with this interface, though.

> I will probably just remove the userspace
> configurability for now. That can go in a separate patch, and maybe
> that can be configurable from the dt, or a kernel config parameter.

I'm fine with that.

>>>>
>>>>> @@ -196,6 +197,11 @@ static int led_suspend(struct device *dev)
>>>>>  {
>>>>>       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>>>
>>>>> +     if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>>>>> +                     PM_QOS_FLAGS_ALL) {
>>>>> +             return 0;
>>>>> +     }
>>>>
>>>> "if (". No need for { } s.
>>>
>>> Ok, I'll generate a new patch later if this seems likely to be integrated.
>>
>> Please also address problems detected by build bot [0].
> 
> Will do.
> 
>>
>>>>> +
>>>>>       if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>>>>>               led_classdev_suspend(led_cdev);
>>>>>
>>>>> @@ -206,6 +212,11 @@ static int led_resume(struct device *dev)
>>>>>  {
>>>>>       struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>>>>
>>>>> +     if(dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) ==
>>>>> +                     PM_QOS_FLAGS_ALL) {
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>>       if (led_cdev->flags & LED_CORE_SUSPENDRESUME)
>>>>>               led_classdev_resume(led_cdev);
>>>>>
>>>>> @@ -287,6 +298,18 @@ int led_classdev_register(struct device *parent, struct led_classdev *led_cdev)
>>>>>       list_add_tail(&led_cdev->node, &leds_list);
>>>>>       up_write(&leds_list_lock);
>>>>>
>>>>> +     /* Attempt to let userspace take over the policy. */
>>>>> +     ret = dev_pm_qos_expose_flags(led_cdev->dev,
>>>>> +                     PM_QOS_FLAG_NO_POWER_OFF);
>>>>> +     if (ret < 0) {
>>>>> +             dev_warn(led_cdev->dev, "failed to expose pm_qos_no_poweroff\n");
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>> +     ret = dev_pm_qos_update_flags(led_cdev->dev,
>>>>> +                     PM_QOS_FLAG_NO_POWER_OFF,
>>>>> +                     0);
>>>>> +
>>
>> So this part should be executed conditionally only if
>> retain-state-suspended wasn't defined. BTW you will have
>> to rebase your code onto some more recent code base.
>>
>> led_classdev_register() was renamed to of_led_classdev_register()
>> in 4.12 and it now accepts struct device_node. leds-gpio.c was
>> already changed to use it so it will be convenient to test the use case
>> with retain-state-suspended DT property.
> 
> Sounds good.
> 
>>
>>>>>       if (!led_cdev->max_brightness)
>>>>>               led_cdev->max_brightness = LED_FULL;
>>>>
>>>> Best regards,
>>>>                                                                         Pavel
>>>> --
>>>> (english) http://www.livejournal.com/~pavelmachek
>>>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>>>
>>> thanks,
>>> Sam
>>>
>>
>> [0] https://www.spinics.net/lists/linux-leds/msg09031.html
>>
>> --
>> Best regards,
>> Jacek Anaszewski
> 
> Thanks for the feedback,
> Sam
> 

-- 
Best regards,
Jacek Anaszewski
