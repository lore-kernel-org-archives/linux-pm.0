From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v5 2/2] thermal: add brcmstb AVS TMON driver
Date: Tue, 26 Sep 2017 15:17:40 -0700
Message-ID: <5245cf8e-d35f-c1fd-b7ea-e3a58c468688@broadcom.com>
References: <20170926212800.4879-1-code@mmayer.net>
 <20170926212800.4879-3-code@mmayer.net>
 <4cb98266-6936-7668-fc88-199ac907b437@broadcom.com>
 <CANEuBv7pij+szVQZHZxNr4kXcCT0miTsYzG7g28zOmF9MqXKJQ@mail.gmail.com>
 <9bdd9959-da47-9adb-e550-31bf06254310@broadcom.com>
 <9587b134-9727-d7cb-7a46-6df5ee4a0494@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:49682 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969684AbdIZWRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 18:17:48 -0400
Received: by mail-wm0-f48.google.com with SMTP id r74so12284622wme.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2017 15:17:47 -0700 (PDT)
In-Reply-To: <9587b134-9727-d7cb-7a46-6df5ee4a0494@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Markus Mayer <code@mmayer.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Doug Berger <opendmb@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>



On 17-09-26 03:14 PM, Florian Fainelli wrote:
> On 09/26/2017 03:08 PM, Scott Branden wrote:
>>
>> On 17-09-26 02:38 PM, Markus Mayer wrote:
>>> On 26 September 2017 at 14:32, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>> Hi Markus,
>>>>
>>>>
>>>> On 17-09-26 02:27 PM, Markus Mayer wrote:
>>>>> From: Brian Norris <computersforpeace@gmail.com>
>>>>>
>>>>> The AVS TMON core provides temperature readings, a pair of configurable
>>>>> high- and low-temperature threshold interrupts, and an emergency
>>>>> over-temperature chip reset. The driver utilizes the first two to
>>>>> provide temperature readings and high-temperature notifications to
>>>>> applications. The over-temperature reset is not exposed to
>>>>> applications; this reset threshold is critical to the system and should
>>>>> be set with care within the bootloader.
>>>>>
>>>>> Applications may choose to utilize the notification mechanism, the
>>>>> temperature reading mechanism (e.g., through polling), or both.
>>>>>
>>>>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>>> ---
>>>>>     drivers/thermal/Kconfig                    |   2 +-
>>>>>     drivers/thermal/broadcom/Kconfig           |   7 +
>>>>>     drivers/thermal/broadcom/Makefile          |   1 +
>>>>>     drivers/thermal/broadcom/brcmstb_thermal.c | 387
>>>>> +++++++++++++++++++++++++++++
>>>>>     4 files changed, 396 insertions(+), 1 deletion(-)
>>>>>     create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
>>>>>
>>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>>> index 07002df..96774a7 100644
>>>>> --- a/drivers/thermal/Kconfig
>>>>> +++ b/drivers/thermal/Kconfig
>>>>> @@ -408,7 +408,7 @@ config MTK_THERMAL
>>>>>             controller present in Mediatek SoCs
>>>>>       menu "Broadcom thermal drivers"
>>>>> -depends on ARCH_BCM || COMPILE_TEST
>>>>> +depends on ARCH_BCM || ARCH_BRCMSTB || COMPILE_TEST
>>>> No need for this additional depends.  ARCH_BCM is always defined before
>>>> ARCH_BRCMSTB can be selected.
>>> ARCH_BCM does not exist in arch/arm64/configs/defconfig. ARCH_BRCMSTB
>>> does. So, we do need both or the driver won't be built on ARM64.
>>> (After internal discussions we went with that approach rather than
>>> defining ARCH_BCM on ARM64.)
>> Got it.  Looking at our internal iproc tree I see we've done exactly the
>> same with ARCH_BCM_IPROC needing to be added.  We haven't upstreamed
>> the thermal driver needing it yet.
>>
>> Perhaps we should add ARCH_BCM to ARM64....
> If it is just added to satisfy dependencies, I don't see much value in
> doing that. It does make sense in the ARM v7 multiplatform context, but
> outside of that, not so sur.
OK - we'll just continue to add ARCH_BCM_IPROC || ARCH_BRCMSTB 
everywhere as needed.
