From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH v3 2/3] thermal: broadcom: ns-thermal: default on iProc SoCs
Date: Fri, 28 Apr 2017 16:50:08 -0400
Message-ID: <CAC3K-4oDnL2oiUDo29dLofHX3hQe2-d1xs=Cduwm==BjLH1djQ@mail.gmail.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-3-git-send-email-jon.mason@broadcom.com> <6628a958-087d-1221-7717-c07eeaec3cce@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33149 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422881AbdD1UuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 16:50:10 -0400
Received: by mail-io0-f172.google.com with SMTP id k87so78025283ioi.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Apr 2017 13:50:10 -0700 (PDT)
In-Reply-To: <6628a958-087d-1221-7717-c07eeaec3cce@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

On Fri, Apr 28, 2017 at 4:36 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
>
>
> On 17-04-28 01:11 PM, Jon Mason wrote:
>>
>> Tweak the Kconfig description to mention support for NSP and make the
>> default on for iProc based platforms.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  drivers/thermal/broadcom/Kconfig | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/broadcom/Kconfig
>> b/drivers/thermal/broadcom/Kconfig
>> index f0dea8a..b6f4b85 100644
>> --- a/drivers/thermal/broadcom/Kconfig
>> +++ b/drivers/thermal/broadcom/Kconfig
>> @@ -1,8 +1,9 @@
>>  config BCM_NS_THERMAL
>>         tristate "Northstar thermal driver"
>>         depends on ARCH_BCM_IPROC || COMPILE_TEST
>
> If this driver is used on these SoCs then it:
> depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
> ?

The code referenced is outside of this patch, as that code was already
existing from when the driver was submitted.

I did some checking and NS2 and Cygnus do not have the registers in
use by this driver.  So, you are correct in that this driver will
never be used for them.  So, this is slightly over-permissive in
allowing a driver to be selected that could not ever be used on
non-NS/NSP hardware.  But barring an incorrect DT string, it would
only result in an slightly larger kernel than necessary.

I'll do a follow-on patch to correct this with your suggestion above,
and push it separately (unless a v4 is needed on this series).

Thanks,
Jon


>> +       default y if ARCH_BCM_IPROC
>>         help
>> -         Northstar is a family of SoCs that includes e.g. BCM4708,
>> BCM47081,
>> -         BCM4709 and BCM47094. It contains DMU (Device Management Unit)
>> block
>> -         with a thermal sensor that allows checking CPU temperature. This
>> -         driver provides support for it.
>> +         Support for the Northstar and Northstar Plus family of SoCs
>> (e.g.
>> +         BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU
>> (Device
>> +         Management Unit) block with a thermal sensor that allows
>> checking CPU
>> +         temperature.
>>
>
