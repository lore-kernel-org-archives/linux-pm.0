From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2] thermal: allow building dove_thermal with mvebu
Date: Tue, 01 Jul 2014 10:50:56 +0200
Message-ID: <53B27670.4000702@gmail.com>
References: <1401452899-13952-1-git-send-email-riku.voipio@linaro.org> <1401537027-32291-1-git-send-email-riku.voipio@linaro.org> <5389D110.8020606@gmail.com> <CAAqcGHkcnm_JjyzWewEcdGuGyyBwtDT_6EWxFzKSqS7NEUaerA@mail.gmail.com> <1404180277.8366.14.camel@rzhang1-toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:44868 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524AbaGAIvC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 04:51:02 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so9378576wes.27
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2014 01:51:00 -0700 (PDT)
In-Reply-To: <1404180277.8366.14.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Riku Voipio <riku.voipio@linaro.org>, andrew@lunn.ch
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On 07/01/2014 04:04 AM, Zhang Rui wrote:
> On Mon, 2014-06-02 at 09:14 +0300, Riku Voipio wrote:
>>
>> On 31 May 2014 15:54, Sebastian Hesselbarth
>> <sebastian.hesselbarth@gmail.com> wrote:
>>> Riku,
>>
>>> looking through my mails, the corresponding patch should have
>>> already been applied [1].
>>
>>> If not, you get my
>>
>>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>
>> I don't see that patch applied in 3.15-rc8 or linux-next:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/thermal/Kconfig#n152
>>
>> I'd like to be sure it gets in 3.16.
>>
> Sorry, I missed Sebastian' patch...
> Now I've seen three versions of patches that do the similar thing.
> This one, the one from Sebastian and the one in
> https://patchwork.kernel.org/patch/4445141/ from Andrew.
>
> Can anybody tell me the relationship between ARCH_DOVE and MARC_DOVE,
> and which one should be the proper fix please?

Rui,

ARCH_DOVE represents legacy, non-DT arch/arm/mach-dove while
MACH_DOVE is DT-only Dove in arch/arm/mach-mvebu.

The idea was to have both, legacy and DT-only Dove, for some
cycles to allow us to finalize the DT transition.

Due to a justified request of Russell, we will keep legacy
mach-dove for a while longer.

The correct patch is the one below, adding both MACH_DOVE and ARCH_DOVE
to DOVE_THERMAL.

Sebastian

> Eduardo,
> I would queue the proper patch for next rc, what's your opinion?
>
>>> [1] https://lkml.kernel.org/r/1395295065.3571.10.camel@rzhang1-mobl4
>>>
>>>> v2: non-ascii char creeped in somehow
>>>>
>>>> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>>>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>>> Cc: linux-pm@vger.kernel.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> ---
>>>>   drivers/thermal/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>> index 2d51912..5783c72 100644
>>>> --- a/drivers/thermal/Kconfig
>>>> +++ b/drivers/thermal/Kconfig
>>>> @@ -151,7 +151,7 @@ config KIRKWOOD_THERMAL
>>>>
>>>>   config DOVE_THERMAL
>>>>        tristate "Temperature sensor on Marvell Dove SoCs"
>>>> -     depends on ARCH_DOVE
>>>> +     depends on ARCH_DOVE || MACH_DOVE
>>>>        depends on OF
>>>>        help
>>>>          Support for the Dove thermal sensor driver in the Linux
>> thermal
>>>>
>>>
>
>

