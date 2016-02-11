From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 11 Feb 2016 11:04:57 -0600
Message-ID: <20160211170457.GA19851@rob-hp-laptop>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
 <20160204230814.GA4847@rob-hp-laptop>
 <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
 <20160205043507.GB4847@rob-hp-laptop>
 <CALAqxLUnbFHjTuJXYXSruV3W0JJ09Fxz=KBe69tZDTd_3_+rxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39445 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbcBKRFE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Feb 2016 12:05:04 -0500
Content-Disposition: inline
In-Reply-To: <CALAqxLUnbFHjTuJXYXSruV3W0JJ09Fxz=KBe69tZDTd_3_+rxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Andy Yan <andy.yan@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, Moritz Fischer <moritz.fischer@ettus.com>, Matthias Brugger <matthias.bgg@gmail.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jun Nie <jun.nie@linaro.org>, =?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>, Will Deacon <will.deacon@arm.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, mbrugger@suse.com, "linux-arm-kernel@lists.infradead.org" <linux-ar>

On Thu, Feb 04, 2016 at 09:03:44PM -0800, John Stultz wrote:
> On Thu, Feb 4, 2016 at 8:35 PM, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Feb 04, 2016 at 03:46:15PM -0800, John Stultz wrote:
> >> On Thu, Feb 4, 2016 at 3:08 PM, Rob Herring <robh@kernel.org> wrote:
> >> > On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
> >> >> +Example:
> >> >> +     reboot-mode {
> >> >> +             mode-normal = <BOOT_NORMAL>;
> >> >> +             mode-recovery = <BOOT_RECOVERY>;
> >> >> +             mode-fastboot = <BOOT_FASTBOOT>;
> >> >
> >> > I tend to agree with John on calling this mode-bootloader.
> >> >
> >> > OTOH, fastboot is more specific about what the mode is. The name in DT
> >> > and the userspace name don't necessarily have to be the same.
> >>
> >> Wait. This is a bit confusing. The utility of adding a property name
> >> and using that name be the reboot command parsed for made sense
> >> (compared to earlier versions which had command strings) as it made
> >> the dts more terse.   But it sounds here like you're suggesting we
> >> should have some logic in the driver that translates "reboot fastboot"
> >> to mode-bootloader or vice versa.
> >
> > I said early on the DT names and kernel-userspace names should not
> > necessarily be linked. They can be, but we shouldn't require that.
> 
> Sigh. Ok. It seemed it was due to earlier comments (maybe from others,
> but I thought it was you), that we moved from specifying a command
> string, to using the label. But if you think the label name and the
> commands shouldn't be linked, it seems like we should re-introduce
> that. No?
> 
> Unless your thinking we need some sort of static in-kernel mapping of
> commands to label names? But that just seems painfully indirect for
> little gain ("Its obvious! For that mode, you use this term here, and
> that different term over there!").

Tying it to a Linux ABI makes the binding Linux specific. I don't have a 
problem that the strings happen to be the same, but we should have some 
understanding that they may not be and allow for that.

> > My concern with mode-bootloader is what if you can boot into multiple
> > bootloader modes. Say USB mass storage is one option. "bootloader" is
> > not real specific.
> 
> True. But as I think we agreed below, "bootloader" and "recovery" are
> basically defacto standards, and I think it would be a bad idea to try
> to declare all the existing android tooling and docs wrong just
> because the command is vague, technically.

Okay, as long as they are clearly documented what they mean.


> >> >> +             mode-loader = <BOOT_LOADER>;
> >> >
> >> > This one needs a better name. Maybe it should be 'rockchip,mode-loader'
> >> > as it is vendor specific. Either way, loader is vague. Perhaps
> >> > rockchip,mode-bl-download?
> >>
> >> Hrm. So how what reboot command do you expect to trigger that?
> >
> > Whatever your OS has defined to map to that.
> >
> > We could just decide the kernel will strip <vendor> and 'mode-' and
> > match commands against what remains.
> 
> That part sounds sane, although I do think having vendor prefixes are
> reasonable for actual commands as well.

Well, you could still have "rockchip,mode-rockchip-bl-download"... 

We can bikeshed that when get there.

The other way random custom modes could be done is just allow the raw 
value to be passed from userspace converting the string to a number. 
Then we have no abstraction rather than half way abstracting it.

> >> I think one of the difficult things here is that there's no real
> >> standards for all bios/bootloader modes. So they are somewhat
> >> firmware/bootloader/device specific, and thus we need something that
> >> is flexible enough to allow lots of different modes to be easily
> >> specified.  That said, this does expose a userspace interface (though
> >> one could argue kernel ABI doesn't cross reboots :) so we should try
> >> to have some consistency so the same userspace can work on various
> >> devices.
> >
> > There is: UEFI. Boot mode efivars are standard. But then they are pretty
> > much PC oriented though. It is more which device to boot off of, but
> > there is network boot or boot to bios setup.
> 
> Well, there's a partial standard there.  I'm told for android on x86,
> there is no UEFI standard way to communicate rebooting to fastboot or
> recovery. Every device does its own device specific driver.

So much for standards. However, while these specific modes have not been 
standardized, there is a set of standard modes and these could have been 
added to the existing mechanism. So there at least exists some model to 
draw inspiration from.

Rob
