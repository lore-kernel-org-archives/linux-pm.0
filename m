From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH 1/2] thermal: broadcom: Allow for NSP to use ns-thermal driver
Date: Fri, 28 Apr 2017 14:04:08 -0400
Message-ID: <CAC3K-4pnewSS4WkE28jscEAQWeENz6Fsbvs25ADr21O=k0O+jA@mail.gmail.com>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
 <1493153351-12698-2-git-send-email-jon.mason@broadcom.com>
 <20170427163658.GC18276@localhost.localdomain> <CAC3K-4pr4LY-9unHNxMDN9YmCYHKekUo66813OUdiKkQH4QzVw@mail.gmail.com>
 <20170428130659.GA28546@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170428130659.GA28546@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 28, 2017 at 9:07 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Thu, Apr 27, 2017 at 01:42:25PM -0400, Jon Mason wrote:
>> On Thu, Apr 27, 2017 at 12:37 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> > Hey Jason,
>>
>> It's Jon :)
>
> Apologies. I think I either read too fast, or my fingers were faster
> than my brain. Sorry.

NP,  That exact error happens more frequently that you would think :)

>>
>> >
>> > On Tue, Apr 25, 2017 at 04:49:10PM -0400, Jon Mason wrote:
>> >> Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
>> >> the ns-thermal driver to be selected via menuconfig.  Also, change the
>> >> ns-thermal driver to work on any iProc based SoC.  Finally, tweak the
>> >> Kconfig description to mention support for NSP and make the default on
>> >> for iProc based platforms.
>> >
>> >
>> > Thanks for the patch, but..
>> >>
>> >> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> >> ---
>> >>  arch/arm/mach-bcm/Kconfig        | 2 ++
>> >>  drivers/thermal/broadcom/Kconfig | 9 +++++----
>> >>  2 files changed, 7 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> >> index a0e66d8..da2bfeb 100644
>> >> --- a/arch/arm/mach-bcm/Kconfig
>> >> +++ b/arch/arm/mach-bcm/Kconfig
>> >> @@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
>> >>       select GPIOLIB
>> >>       select ARM_AMBA
>> >>       select PINCTRL
>> >> +     select THERMAL
>> >> +     select THERMAL_OF
>> >>       help
>> >>         This enables support for systems based on Broadcom IPROC architected SoCs.
>> >>         The IPROC complex contains one or more ARM CPUs along with common
>> >
>> > It would be better if this is split and sent through your arch tree, to
>> > avoid conflicts. I could also pick it if you get an ack from one of your
>> > maintainers. Still, first option is preferable.
>>
>> Sure, I'll be happy to split this off.  I should've thought to split
>> it up before sending.  Thanks for the suggestion.
>
> Cool!
>
>>
>> >
>> >> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
>> >> index f0dea8a..26d706c 100644
>> >> --- a/drivers/thermal/broadcom/Kconfig
>> >> +++ b/drivers/thermal/broadcom/Kconfig
>> >> @@ -1,8 +1,9 @@
>> >>  config BCM_NS_THERMAL
>> >>       tristate "Northstar thermal driver"
>> >>       depends on ARCH_BCM_IPROC || COMPILE_TEST
>> >> +     default ARCH_BCM_IPROC
>> >
>> > Not sure if this is really what you wanted. Based on your commit log
>> > message, you meant the following, perhaps?
>> >
>> >  +      default y if ARCH_BCM_IPROC
>>
>> IIUC, my original default works, as we have used it frequently in
>> other places in the kernel.
>> grep -rI "default ARCH_BCM_IPROC" * | wc -l
>> 15
>
> Yeah... Are you sure they are all correct?
>
>>
>> However, if the above is preferred (or the other 15 massively broken),
>> I'll be happy to do it that way.
>
> Your construction is syntactically correct. Maybe might still work (did
> not check myself) for the purpose you describe, but the construction
> mentioned in Documentation/kbuild/kconfig-language.txt is:
>  +      default y if BAR
>
> So, please fix it.

Oh, thanks for the info.  I was unaware of this, and we should
definitely follow the documentation..  I'll make the relevant changes
and do follow-on patches to correct the other places.

>
>>
>>
>> >>       help
>> >> -       Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
>> >> -       BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
>> >> -       with a thermal sensor that allows checking CPU temperature. This
>> >> -       driver provides support for it.
>> >> +       Support for the Northstar and Northstar Plus family of SoCs (e.g.
>> >> +       BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
>> >
>> > Did we look BCM47094 somehow on this patch?
>>
>> Naa, just trying to be more concise, while adding the NSP products to
>> the list..  BCM47094 is a type of BCM4709.  So, it is still there :)
>>
>> >
>> >> +       Management Unit) block with a thermal sensor that allows checking CPU
>> >> +       temperature.
>> >> --
>> >> 2.7.4
>> >>
