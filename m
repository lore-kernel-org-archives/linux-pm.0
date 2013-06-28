From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Sat, 29 Jun 2013 00:47:09 +0200
Message-ID: <2055030.cNBSJEZ4PB@flatron>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <2484012.IH9WOi4iIR@amdc1032> <51CE0485.8020109@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:35831 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab3F1WrP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2013 18:47:15 -0400
In-Reply-To: <51CE0485.8020109@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com

On Friday 28 of June 2013 23:47:49 Daniel Lezcano wrote:
> On 06/28/2013 06:27 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Friday, June 28, 2013 01:20:09 PM Daniel Lezcano wrote:
> >> On 06/28/2013 12:11 PM, Tomasz Figa wrote:
> >>> Hi Daniel,
> >>> 
> >>> I've been fighting with this whole AFTR state as well, before
> >>> Bartlomiej. Let me share my thoughts on this.
> 
> [ ... ]
> 
> >>> If you don't unplug all the CPUs >0 the state is obviously never
> >>> reached. Otherwise the whole system hangs after it tries to enter
> >>> this mode without any reaction for external events, other than
> >>> reset.
> >> 
> >> Need investigation.
> >> 
> >> What is the exynos board version where that occurs ?
> > 
> > Could you please tell me what exactly do you mean by that?
> > 
> > I already wrote that we can reproduce the problem on EXYNOS4210 rev0
> > and rev1.1 (we don't have rev1.0). Tomek has also reproduced the
> > problem on some later SoCs (I hope that he can give you exact
> > revisions).
> > 
> > In our testing we didn't encounter the board on which the problem
> > doesn't occur. Our current working theory is that the problem may be
> > u-boot (or first stage bootloader) related.
> 
> Ok, the status for what I know:
> 
> Origen Exynos4210, board ver A: works for me
> Arndale Exynos5250: works for me but only if u-boot does not enable the
> hypervisor mode.
> Chromebook Exynos5250: works for me
> 
> I found the following drivers:
> 
> https://github.com/AndreiLux/Perseus-UNIVERSAL5410/blob/samsung/arch/arm
> /mach-exynos/cpuidle.c
> 
> https://github.com/CyanogenMod/hardkernel-kernel-4412/blob/cm-10.1/arch/
> arm/mach-exynos/cpuidle-exynos4.c
> 
> Sounds like the num cpus > 1 is still there.

As far as I know (and I can read from the documentation), AFTR is a state 
in which program execution context (e.g. PC, CPU registers, etc.) is lost. 
This is like sleep mode, but with much more state saved (all the 
peripherals and L2 cache), which lets you resume much faster.

Based on that, the execution flow is as following:
 - kernel stops all secondary cores,
 - kernel configures PMU to enter AFTR mode,
 - WFI is executed on boot CPU, which lets PMU enter the requested low 
power mode,
 - the system stays with all CPU cores powered off until a wake-up event 
happens,
 - a wake-up event causes a wake-up reset of the boot CPU, which resumes 
operation from reset vector (usually IROM),
 - here exactly the same procedure is used as on wake-up from sleep mode, 
with the exception that some assumptions can be made about kept state, 
like BL1 being still in IRAM/SYSRAM, without the need to reload it from 
boot device,
 - after going through all the boot code, it finally jumps to the resume 
handler saved by kernel in one of those INFORM registers or somewhere in 
SYSRAM,
 - resume handler reinitializes boot CPU, restores things like MMU, 
coprocessors, etc. and finally boots secondary cores again,
 - the system is operating normally again.

This is simplified a lot, with all things happened internally in PMU and 
boot code skipped, but should give the general picture. See all the 
analogies to normal sleep mode, which (IMHO) makes it understandable that 
this mode can't be entered with more than one core active. 

However, with something like coupled cpuidle, when possible, this mode can 
be entered by powering down remaining cores automatically, so this is not 
a problem with this mode itself, but rather with current approach of 
entering it.

Best regards,
Tomasz

> 
> [ ... ]
> 
> >> The kernel is not a playground where you can upstream code and then
> >> remove it because a feature seems broken and you don't have an idea
> >> of why.> 
> > Neither me or Tomek did upstream this code and we couldn't react in
> > time because we haven't noticed that it is completely unusable for us
> > as EXYNOS cpuidle driver is not even used by default on EXYNOS (it is
> > not enabled either in defconfig or Kconfig).
> > 
> > Moreover the feature we are talking about (AFTR mode) is also not used
> > by default (except EXYNOS4210 rev0 on which it lockups system for us)
> > even with EXYNOS cpuidle driver being enabled (because this specific
> > feature depends on CPU hot-unplug which is not done automatically
> > right
> > now).
> > 
> > Such things like unused/broken code removal is not something very
> > unusual in the upstream kernel (I'm speaking from the experience here
> > having maintained large subsystem for a couple of years). In this
> > particular case we are talking about ~130 lines of code which can
> > be trivially brought back later when/if needed.
> > 
> > Anyway if the code removal is controversial for you we can just
> > disable
> > AFTR mode by default and enable it only when special command line
> > option is given (i.e. "aftr"). This would fix all the broken
> > configuration while still allowing the feature to be enabled on
> > systems that had it working previously (since you claim that it works
> > on some chipset/u-boot configurations).
> 
> Actually, there are several reasons I am not in favor for the moment to
> remove this code:
> 
> 1) code can't be pushed upstream and then removed so easily
> 2) I asked several times what was this cpu1 hack, I had no answer
> 3) I tried to make both cpus entering the AFTR state, but the cpu1 never
> wakes up, I asked but no answer.
> 
> I would like to have some answers :)
> 
> Before taking the decision to remove this state (btw you can remove the
> driver directly, no ? the default idle function is WFI), IMO it is worth
> to investigate and to spend some time to clarify what is happening.
> Then we can take a decision.
> 
> I am willing to help.
> 
> >> I asked several times the reasons of why the AFTR state couldn't work
> >> with multiple CPUs and I had no answer.
> > 
> > Unfortunately I don't know the answer for your question.
> > 
> > The AFTR mode doesn't work for us *at*all* (even with *one* CPU).
> > 
> >> Frankly speaking I have a couple of hypothesis:
> >> 
> >> 1. something is not correctly setup and the PMU does not wake up the
> >> CPU1 2. there is a silicon bug and no one wants to tell it is the
> >> case
> >> 
> >> In any case, this must be investigated and identified. And then we
> >> can
> >> take a decision about this state.
> > 
> > I don't have good idea currently how to investigate it further.
> > 
> > I also don't have any prove that the actual work is worth it
> > (and this work can easily take some weeks).
> > 
> > One of main responsibilities of the maintainer it to make sure that
> > the code does indeed work and that regressions (like these caused by
> > AFTR mode feature) are fixed in the timely manner, not let the code
> > sit in the limbo state for large periods of time.  It is already very
> > bad situation that the regression we are hitting was present since
> > v3.4 and we are in v3.10 now, I would like to have it fixed ASAP so
> > we may actually consider enabling cpuidle in our exynos_defconfig.
> 
> I agree.
> 
> Thanks
>   -- Daniel
