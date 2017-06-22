From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Thu, 22 Jun 2017 02:03:33 +0200
Message-ID: <CAJZ5v0hzkVwf1HkH4GLbAeK7iJ_7V1UXHErruuvMVEpb5MqZ3Q@mail.gmail.com>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr> <CAJZ5v0iL7voAz9T+36fXXncOj4UrFSAH8WzwEbec96GuFUteaQ@mail.gmail.com>
 <ccac39d6-4611-8b46-12f7-24227ef3b35e@gmail.com> <CAJZ5v0g_egRwxOLqft=JhvzAqBWuyvC8yiO7De5TYUZLUT2Fpw@mail.gmail.com>
 <7001768d-9134-4975-127e-e8444e00f677@gmail.com> <CAJZ5v0ihqn5Xcj1yoZcrb7caYiH+x8YivLJit6BqvDGradZJ=Q@mail.gmail.com>
 <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37175 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdFVADe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 20:03:34 -0400
Received: by mail-it0-f50.google.com with SMTP id m47so12018276iti.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 17:03:34 -0700 (PDT)
In-Reply-To: <b7a49925-d823-b03d-2990-2894ba2c2714@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mason <slash.tmp@free.fr>, Ulf Hansson <ulf.hansson@linaro.org>, JB <jb_lescher@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 22, 2017 at 1:55 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/21/2017 03:57 PM, Rafael J. Wysocki wrote:
>> On Thu, Jun 22, 2017 at 12:48 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 06/21/2017 02:59 PM, Rafael J. Wysocki wrote:
>>>> On Wed, Jun 21, 2017 at 11:16 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> On 06/09/2017 03:53 PM, Rafael J. Wysocki wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Jun 9, 2017 at 5:20 PM, Mason <slash.tmp@free.fr> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I read the "Sleep States" documentation:
>>>>>>> https://www.kernel.org/doc/Documentation/power/states.txt
>>>>>>>
>>>>>>> It mentions /sys/power/mem_sleep but I don't have that in 4.9
>>>>>>> # ll /sys/power/
>>>>>>> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_async
>>>>>>> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_freeze_timeout
>>>>>>> -rw-r--r--    1 root     root          4096 Jan  1 00:31 state
>>>>>>> -rw-r--r--    1 root     root          4096 Jan  1 00:31 wakeup_count
>>>>>>>
>>>>>>> # cat /sys/power/state
>>>>>>> freeze mem
>>>>>>>
>>>>>>> Currently my platform's "mem" is a true suspend-to-RAM trigger,
>>>>>>> where drivers are supposed to save their state (register values
>>>>>>> will be lost), then Linux hands control over to firmware which
>>>>>>> enables RAM self-refresh and powers the chip down. When the system
>>>>>>> resumes, drivers restore their state from their copy in memory.
>>>>>>>
>>>>>>> One driver is responsible for loading/unloading microcode running
>>>>>>> on the DSPs. This operation is required only when powering down
>>>>>>> the chip, but it should be avoided for "low-latency" sleeps.
>>>>>>>
>>>>>>> The problem is that, if I understand correctly, drivers have no way
>>>>>>> of knowing which sleep state is being entered/exited?
>>>>>>>
>>>>>>> How can I have the microcode driver take different decisions
>>>>>>> based on the sleep state?
>>>>>>
>>>>>> The cleanest way would be to run that code from one of the platform
>>>>>> suspend hooks that receive information on what sleep state is to be
>>>>>> entered.
>>>>>
>>>>> I am not sure this would be cleaner, because that would create a tighter
>>>>> dependency between different drivers, each of them having their
>>>>> suspend/resume routings and the driver that implements the
>>>>> platform_suspend_ops, that could also create some nice layering
>>>>> violations and some difficult to solve dependencies.
>>>>>
>>>>>>
>>>>>> Alternatively, those hooks can set/clear flags that can be accessed by
>>>>>> drivers, but that of course may your drivers depend on the platform
>>>>>> (still, in the microcode case the driver seems to be
>>>>>> platform-dependent anyway).
>>>>>
>>>>> It may be platform dependent, but the actual system-wide suspend/resume
>>>>> implementations can vary a lot. For example you may have started with
>>>>> some particular CPU architecture on your platforms, with one driver
>>>>> implementing an instance of platform_suspend_ops, and then as you moved
>>>>> to another CPU architecture, some of that could be managed by a generic
>>>>> driver (e.g: ARM SCPI, ACPI etc. etc.).
>>>>>
>>>>> The same HW blocks are likely to be present on these different SoCs, and
>>>>> have the same requirements where they need to see a slightly different
>>>>> path taken on suspend/resume. If we have to patch both the "legacy"
>>>>> platform_suspend_ops, and the "new" platform_suspend_ops that does not
>>>>> really scale.
>>>>>
>>>>> Would it be that much of a stretch if we reflected e.g:
>>>>> PM_SUSPEND_STANDBY, PM_SUSPEND_MEM into the pm_message_t that is
>>>>> communicated to platform_driver::suspend and platform_driver::resume?
>>>>
>>>> I'm not sure what you mean, really.
>>>>
>>>> The ->suspend callback in struct platform_driver has been long deprecated.
>>>
>>> What I mean is that we could take advantage of the pm_message_t argument
>>> passed to platform_driver::resume and platform_driver::resume to
>>> communicate the system sleep state we are about to enter (and conversely
>>> exit).
>>
>> So the ->suspend and ->resume callbacks in struct platform_driver
>> (which I think is what you are referring to) are legacy.
>>
>> The majority of drivers I know about use struct dev_pm_ops and the
>> callbacks in there do not take the pm_message_t argument.
>>
>> Moreover, even if they did take it, the exact meaning of
>> PM_SUSPEND_STANDBY and PM_SUSPEND_MEM is platform-specific and drivers
>> would need to find out what they actually mean for the given platform
>> somehow anyway.
>>
>>> This would allow drivers to take a different path whether e.g:
>>> pm_message_t == PM_SUSPEND_STANDBY or PM_SUSPEND_MEM.
>>>
>>> If these are deprecated, then should we introduce a global getter
>>> function that reflects which suspend state we are about to enter?  This
>>> would allow drivers do to something like (pseudo code):
>>>
>>> static int drv_suspend(struct device d)
>>> {
>>>         suspend_state_t state = suspend_get_state();
>>>
>>>         switch (state) {
>>>         case PM_SUSPEND_STANDBY:
>>>                 return 0;
>>>         case PM_SUSPEND_MEM:
>>>                 /* save HW context */
>>> }
>>
>> That is conceivable, but again, the meaning of STANDBY and MEM is
>> platform-specific.  Actions to be taken for, say, STANDBY, may differ
>> from one platform to another.
>
> True, though I would only expect drivers for that particular platform to
> care about that information and these drivers would only make sense on
> that particular platform so the meaning of STANDBY and MEM would be
> clear for those drivers. The intent is really to keep the "distributed"
> model where individual drivers manage their particular piece of HW,
> while utilizing a global piece of information that is platform specific.

Well, but in that case, why don't you have a "target_state" variable
somewhere in the platform code and make your drivers look at it?

ACPI has acpi_target_system_state() for this very purpose, for example.

> If this seems acceptable to you along with proper documentation to
> illustrate the platform specific meaning of these states, I will got
> ahead and cook a patch.

I wouldn't like platform-specific things to pretend that they are generic.

Thanks,
Rafael
