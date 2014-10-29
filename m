From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH V2 3/5] cpuidle: idle: menu: Don't reflect when a state selection failed
Date: Wed, 29 Oct 2014 09:54:43 -0700
Message-ID: <7h8ujybyuk.fsf@deeprootsystems.com>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
	<1414054881-17713-3-git-send-email-daniel.lezcano@linaro.org>
	<CAM4v1pO9e7r10KX=D=9aVTV_ecvPa-aJOoB6PAwR5jxMS3eg4w@mail.gmail.com>
	<544FE032.5050900@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53373 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934482AbaJ2Qyr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 12:54:47 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so3536751pad.11
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 09:54:47 -0700 (PDT)
In-Reply-To: <544FE032.5050900@linaro.org> (Daniel Lezcano's message of "Tue,
	28 Oct 2014 19:28:02 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 10/28/2014 08:01 AM, Preeti Murthy wrote:
>> On Thu, Oct 23, 2014 at 2:31 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> In the current code, the check to reflect or not the outcoming state is done
>>> against the idle state which has been chosen and its value.
>>>
>>> Instead of doing a check in each of the reflect functions, just don't call reflect
>>> if something went wrong in the idle path.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Acked-by: Nicolas Pitre <nico@linaro.org>
>>> ---
>>>   drivers/cpuidle/governors/ladder.c | 3 +--
>>>   drivers/cpuidle/governors/menu.c   | 4 +---
>>>   kernel/sched/idle.c                | 3 ++-
>>>   3 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
>>> index fb396d6..c0b36a8 100644
>>> --- a/drivers/cpuidle/governors/ladder.c
>>> +++ b/drivers/cpuidle/governors/ladder.c
>>> @@ -165,8 +165,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
>>>   static void ladder_reflect(struct cpuidle_device *dev, int index)
>>>   {
>>>          struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
>>> -       if (index > 0)
>>> -               ldev->last_state_idx = index;
>>> +       ldev->last_state_idx = index;
>>>   }
>>>
>>>   static struct cpuidle_governor ladder_governor = {
>>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>>> index a17515f..3907301 100644
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -365,9 +365,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>   static void menu_reflect(struct cpuidle_device *dev, int index)
>>>   {
>>>          struct menu_device *data = &__get_cpu_var(menu_devices);
>>> -       data->last_state_idx = index;
>>> -       if (index >= 0)
>>> -               data->needs_update = 1;
>>> +       data->needs_update = 1;
>>
>> Why is the last_state_idx not getting updated ?
>
> Oups, right. This is missing.
>
> Thanks for pointing this out.
>
> By the way, I don't think a back end driver is changing the selected
> state currently and I am not sure this is desirable since we want to
> trust the state we are going (as a best effort). 

FYI, the OMAP3 backend driver can does not always obey the selected
state, and will return a different state than the one requested.

Kevin
