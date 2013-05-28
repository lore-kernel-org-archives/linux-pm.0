From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 14:42:55 +0200
Message-ID: <5938372.bcA6BTeOGP@vostro.rjw.lan>
References: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org> <1578834.dvFIpyCvrt@vostro.rjw.lan> <51A4A1A4.1070008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53259 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758659Ab3E1MeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 May 2013 08:34:04 -0400
In-Reply-To: <51A4A1A4.1070008@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday, May 28, 2013 02:23:00 PM Daniel Lezcano wrote:
> On 05/28/2013 01:46 PM, Rafael J. Wysocki wrote:
> > On Monday, May 27, 2013 11:00:58 PM Daniel Lezcano wrote:
> >> Each governor is suitable for different kernel configurations: the menu
> >> governor suits better for a tickless system, while the ladder governor fits
> >> better for a periodic timer tick system.
> >>
> >> The Kconfig does not allow to [un]select a governor, thus both are compiled in
> >> the kernel but the init order makes the menu governor to be the last one to be
> >> registered, so becoming the default. The only way to switch back to the ladder
> >> governor is to enable the sysfs governor switch in the kernel command line.
> >>
> >> Because it seems nobody complained about this, the menu governor is used by
> >> default most of the time on the system, having both governors is not really
> >> necessary on a tickless system but there isn't a config option to disable one
> >> or another governor.
> >>
> >> Create a submenu for cpuidle and add a label for each governor, so we can see
> >> the option in the menu config and enable/disable it.
> >>
> >> The governors will be enabled depending on the CONFIG_NO_HZ option:
> >>  - If CONFIG_NO_HZ is set, then the menu governor is selected and the ladder
> >>    governor is optional, defaulting to 'no'
> > 
> > Why not defaulting to 'yes'?  That'd be backwards compatible, wouldn't it?
> 
> Yes, that wouldn't be backward compatible but who wants the ladder
> governor which is less efficient with a tickless system ?

I don't know and this isn't the right question to ask I think.

You need to ask who uses the ladder governor with CONFIG_NO_HZ and you need to
avoid making changes that aren't backwards compatible if you don't know the
answer (which I'm pretty sure is the case).

I'd prefer to default to 'yes' to start with and then to change the
default to 'no' after a couple of cycles, possibly.

> >>  - If CONFIG_NO_HZ is not set, then the ladder governor is selected and the
> >>    menu governor is optional, defaulting to 'no'
> > 
> > Are you sure this is not going to introduce regressions with CONFIG_NO_HZ
> > unset?
> 
> Yes, a system configured with a periodic tick will use the ladder
> instead of the menu governor (which is less efficient on this
> configuration).

Well, "less efficient" meaning what exactly?  Less power-efficient or less
efficient performance-wise?

> Currently the default is the menu governor with a periodic tick system
> because both governors are compiled in and the init order makes the menu
> governor to be enabled instead of the 'ladder'.

I understand that.

> We can set both to 'yes' by default but in this case, I suggest to add
> in the code a 'preferred' governor depending on tickless or not, so the
> right governor is chosen at boot time depending on CONFIG_NO_HZ.
> 
> Otherwise, I am not sure people running servers (with a periodic tick)
> will change their kernel command line option to enable the sysfs
> governor switch to change the governor to ladder, neither they are aware
> ladder is better for their system.
> 
> I am open to any suggestion.

I think the change to make the governor preference depend on CONFIG_NO_HZ
kind of makes sense.  However, I'd default to 'yes' for both governors in both
configurations to start with (which basically means that the ordering will now
depend on CONFIG_NO_HZ).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
