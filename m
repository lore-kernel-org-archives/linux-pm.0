From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
Date: Mon, 17 Mar 2014 12:10:26 -0700
Message-ID: <CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
	<1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
	<20140316070917.GA3094@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57554 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaCQTK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Mar 2014 15:10:27 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so2684347wiv.9
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2014 12:10:26 -0700 (PDT)
In-Reply-To: <20140316070917.GA3094@arch.cereza>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <jonathan.austin@arm.com>, Victor Kamensky <victor.kamensky@linaro.org>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Laura Abbott <lauraa@codeaurora.org>, Sricharan R <r.sricharan@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Russ Dill <Russ.Dill@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On 16 March 2014 00:09, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Mar 05, Sebastian Capella wrote:
> [..]
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index 1f8fed9..83707702 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -611,6 +611,11 @@ config CPU_USE_DOMAINS
>>  config IO_36
>>       bool
>>
>> +config ARCH_HIBERNATION_POSSIBLE
...
>> +     default y if CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || CPU_XSCALE || CPU_XSC3 || CPU_V6 || CPU_V6K || CPU_V7
...
> Is there any reason why CPU_FEROCEON is not listed here? FWIW, I've just built
> (but not really tested) a Kirkwood kernel with CONFIG_HIBERNATION=y.
No reason; I did not change this from the original patch I'd received.
 I didn't try to get a comprehensive list of supported hardware.  To
my understanding, the goal is to get the infrastructure in so that
people can start working on their platforms and add support for them.

> And is there any reason to put this config in arch/arm/mm/Kconfig, instead of
> in arch/arm/Kconfig, below ARCH_SUSPEND_POSSIBLE?
I don't have a reason.  Anyone else have a comment on this?
Otherwise, I'll move it.. thanks!

> I'm also puzzled about having two separate options for suspend and hibernate,
> maybe someone can explain me why a given CPU would support the former but not
> the latter?
It's part of having the generic hibernation implemented and available
but with architecture specific dependencies.  Where an architecture
may not have support for hibernation, it will prevent compilation of
the generic hibernation support.  For example, at the moment, ARM does
not support hibernation.  As a result, hibernation is not presented as
an option in menuconfig.  If you were to artificially enable it (by
hacking ARCH_HIBERNATION_POSSIBLE=y, and then turning
CONFIG_HIBERNATION=y) then you'd get linker errors due to the missing
architecture hibernation functions.  (basically what is being added by
this patch for ARM).  It's like this for other architectures as well
(mips, sh, etc..)

Thanks,

Sebastian
