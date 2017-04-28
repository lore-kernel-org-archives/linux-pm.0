From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH v2 1/3] ARM: BCM: Enable thermal support for iProc SoCs
Date: Fri, 28 Apr 2017 14:05:48 -0400
Message-ID: <CAC3K-4omn1A5ddPhkhhROLmtcEDJjHg7boa0B=c9OUuAHV6NyQ@mail.gmail.com>
References: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
 <1493328194-1766-2-git-send-email-jon.mason@broadcom.com> <bceb9b66-c769-faf3-9288-26581b5d5dc6@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36727 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S642241AbdD1SFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 14:05:49 -0400
Received: by mail-it0-f41.google.com with SMTP id g66so48230726ite.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Apr 2017 11:05:49 -0700 (PDT)
In-Reply-To: <bceb9b66-c769-faf3-9288-26581b5d5dc6@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

On Thu, Apr 27, 2017 at 7:10 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
>
>
> On 17-04-27 02:23 PM, Jon Mason wrote:
>>
>> Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
>> the ns-thermal driver to be selected via menuconfig.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  arch/arm/mach-bcm/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index a0e66d8..da2bfeb 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
>>         select GPIOLIB
>>         select ARM_AMBA
>>         select PINCTRL
>> +       select THERMAL
>> +       select THERMAL_OF
>
> This is NSP specific at this point.  Also, If it increases code size in any
> way it shouldn't be selected for all IPROC SoCS.  I'd rather this was just
> selected via defconfig

This isn't selectable via menuconfig without being in the kconfig.
I'll move it to the NSP portion of the kconfig, as to not increase the
size of other's kernels.

Thanks,
Jon

>
>>         help
>>           This enables support for systems based on Broadcom IPROC
>> architected SoCs.
>>           The IPROC complex contains one or more ARM CPUs along with
>> common
>>
>
