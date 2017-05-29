From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v3 2/3] thermal: broadcom: ns-thermal: default on iProc
 SoCs
Date: Mon, 29 May 2017 09:21:51 -0700
Message-ID: <f2544b8e-59fe-8cbc-5598-bd2a2b325a39@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
 <6628a958-087d-1221-7717-c07eeaec3cce@broadcom.com>
 <CAC3K-4oDnL2oiUDo29dLofHX3hQe2-d1xs=Cduwm==BjLH1djQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35491 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdE2QV6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 12:21:58 -0400
Received: by mail-wm0-f53.google.com with SMTP id b84so61858977wmh.0
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2017 09:21:58 -0700 (PDT)
In-Reply-To: <CAC3K-4oDnL2oiUDo29dLofHX3hQe2-d1xs=Cduwm==BjLH1djQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

Hi Jon,


On 17-04-28 01:50 PM, Jon Mason wrote:
> On Fri, Apr 28, 2017 at 4:36 PM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>>
>> On 17-04-28 01:11 PM, Jon Mason wrote:
>>> Tweak the Kconfig description to mention support for NSP and make the
>>> default on for iProc based platforms.
>>>
>>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>>> ---
>>>   drivers/thermal/broadcom/Kconfig | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/thermal/broadcom/Kconfig
>>> b/drivers/thermal/broadcom/Kconfig
>>> index f0dea8a..b6f4b85 100644
>>> --- a/drivers/thermal/broadcom/Kconfig
>>> +++ b/drivers/thermal/broadcom/Kconfig
>>> @@ -1,8 +1,9 @@
>>>   config BCM_NS_THERMAL
>>>          tristate "Northstar thermal driver"
>>>          depends on ARCH_BCM_IPROC || COMPILE_TEST
>> If this driver is used on these SoCs then it:
>> depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
>> ?
> The code referenced is outside of this patch, as that code was already
> existing from when the driver was submitted.
>
> I did some checking and NS2 and Cygnus do not have the registers in
> use by this driver.  So, you are correct in that this driver will
> never be used for them.  So, this is slightly over-permissive in
> allowing a driver to be selected that could not ever be used on
> non-NS/NSP hardware.  But barring an incorrect DT string, it would
> only result in an slightly larger kernel than necessary.
>
> I'll do a follow-on patch to correct this with your suggestion above,
> and push it separately (unless a v4 is needed on this series).

Please submit the follow on patch.

>
> Thanks,
> Jon
Thanks,
  Scott
