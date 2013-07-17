From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Wed, 17 Jul 2013 16:36:26 +0200
Message-ID: <8703473.ctkuh2YRQb@amdc1032>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
 <5509794.32CckI9OQ8@amdc1032> <51E694BA.3030906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <51E694BA.3030906@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 17, 2013 02:57:30 PM Daniel Lezcano wrote:
> On 07/11/2013 03:14 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Friday, June 28, 2013 11:47:49 PM Daniel Lezcano wrote:
> >> On 06/28/2013 06:27 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> On Friday, June 28, 2013 01:20:09 PM Daniel Lezcano wrote:
> >>>> On 06/28/2013 12:11 PM, Tomasz Figa wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> I've been fighting with this whole AFTR state as well, before Bartlomiej. 
> >>>>> Let me share my thoughts on this.
> >>>>>
> >>
> >> [ ... ]
> >>
> >>>>>
> >>>>> If you don't unplug all the CPUs >0 the state is obviously never reached. 
> >>>>> Otherwise the whole system hangs after it tries to enter this mode without 
> >>>>> any reaction for external events, other than reset.
> >>>>
> >>>> Need investigation.
> >>>>
> >>>> What is the exynos board version where that occurs ?
> >>>
> >>> Could you please tell me what exactly do you mean by that?
> >>>
> >>> I already wrote that we can reproduce the problem on EXYNOS4210 rev0
> >>> and rev1.1 (we don't have rev1.0). Tomek has also reproduced the problem
> >>> on some later SoCs (I hope that he can give you exact revisions).
> >>>
> >>> In our testing we didn't encounter the board on which the problem
> >>> doesn't occur. Our current working theory is that the problem may be
> >>> u-boot (or first stage bootloader) related.
> >>
> >> Ok, the status for what I know:
> >>
> >> Origen Exynos4210, board ver A: works for me
> >> Arndale Exynos5250: works for me but only if u-boot does not enable the
> >> hypervisor mode.
> >> Chromebook Exynos5250: works for me
> > 
> > I've also done some more testing. First I tested on some Exynos4412 devices
> > (M0 and SLP_PQ) and AFTR was not working on them. Then I got my hands on
> > Origen Exynos4210 (thanks to Tomek Figa for providing it) and AFTR is working
> > just fine on it. Finally I tried Trats board again but with the upstream
> > u-boot instead of our custom modified version (thanks to help from Lukasz
> > Majewski) and I found out that after this change AFTR works fine on it! It
> > also gives quite nice power savings (~80mA less current drawn in AFTR mode
> > compared to just WFI one).
> 
> Is the 80mA power saving comparing with:
> 
>  * (cpu0/cpu1 online) vs (cpu0 AFTR and cpu1 offline)
> or
>  * (cpu0 AFTR and cpu1 offline) vs (cpu0 WFI and cpu1 offline)
> ?

The latter one and the following scenario:

 * (cpu0/cpu1 online) vs (cpu0 WFI and cpu1 offline)

gives only ~10mA saving. Maybe something is not working as it should be in
the hotplug support and the code is not doing as much as it could but these
are the actual results (using vanilla v3.10).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > With the above findings it now seems that the issue is on our side and is
> > outside the kernel. Thanks for help with narrowing down the problem and
> > sorry for wasting your time.
> 
> May be we were not working on the same tree.
> 
> I am on the linux-pm-next tree.
> 
> Now the merge window occurred, the AFTR is no longer working on my board.
> 
> After git bisecting:
> 
> commit 87107d89052bcec1fe91b309631de4ed294a5171
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Jun 19 01:36:52 2013 +0900
> 
>     ARM: EXYNOS: Remove legacy L2X0 initialization
> 
>     Since Exynos is now supporting only DT-based boot, the old L2X0
>     initialization code is not needed anymore, so exynos4_l2x0_cache_init()
>     can be greatly simplified.
> 
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>     Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>     Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> :040000 040000 79e1adfd6386256ba71b3f609592d5acf9c08222
> 9cb0026563b3b8657d906767493d26c501963269 M	arch
> 
> Reverting the patch solves the problem.
> 
> Any ideas ?
> 
> Thanks
>   -- Daniel
> 
> 
> > 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> >> I found the following drivers:
> >>
> >> https://github.com/AndreiLux/Perseus-UNIVERSAL5410/blob/samsung/arch/arm/mach-exynos/cpuidle.c
> >>
> >> https://github.com/CyanogenMod/hardkernel-kernel-4412/blob/cm-10.1/arch/arm/mach-exynos/cpuidle-exynos4.c
> >>
> >> Sounds like the num cpus > 1 is still there.
> >>
> >> [ ... ]
> >>
> >>>> The kernel is not a playground where you can upstream code and then
> >>>> remove it because a feature seems broken and you don't have an idea of why.
> >>>
> >>> Neither me or Tomek did upstream this code and we couldn't react in
> >>> time because we haven't noticed that it is completely unusable for us
> >>> as EXYNOS cpuidle driver is not even used by default on EXYNOS (it is
> >>> not enabled either in defconfig or Kconfig).
> >>>
> >>> Moreover the feature we are talking about (AFTR mode) is also not used
> >>> by default (except EXYNOS4210 rev0 on which it lockups system for us)
> >>> even with EXYNOS cpuidle driver being enabled (because this specific
> >>> feature depends on CPU hot-unplug which is not done automatically right
> >>> now).
> >>>
> >>> Such things like unused/broken code removal is not something very
> >>> unusual in the upstream kernel (I'm speaking from the experience here
> >>> having maintained large subsystem for a couple of years). In this
> >>> particular case we are talking about ~130 lines of code which can
> >>> be trivially brought back later when/if needed.
> >>>
> >>> Anyway if the code removal is controversial for you we can just disable
> >>> AFTR mode by default and enable it only when special command line option
> >>> is given (i.e. "aftr"). This would fix all the broken configuration
> >>> while still allowing the feature to be enabled on systems that had it
> >>> working previously (since you claim that it works on some chipset/u-boot
> >>> configurations).
> >>
> >> Actually, there are several reasons I am not in favor for the moment to
> >> remove this code:
> >>
> >> 1) code can't be pushed upstream and then removed so easily
> >> 2) I asked several times what was this cpu1 hack, I had no answer
> >> 3) I tried to make both cpus entering the AFTR state, but the cpu1 never
> >> wakes up, I asked but no answer.
> >>
> >> I would like to have some answers :)
> >>
> >> Before taking the decision to remove this state (btw you can remove the
> >> driver directly, no ? the default idle function is WFI), IMO it is worth
> >> to investigate and to spend some time to clarify what is happening. Then
> >> we can take a decision.
> >>
> >> I am willing to help.
> >>
> >>>> I asked several times the reasons of why the AFTR state couldn't work
> >>>> with multiple CPUs and I had no answer.
> >>>
> >>> Unfortunately I don't know the answer for your question.
> >>>
> >>> The AFTR mode doesn't work for us *at*all* (even with *one* CPU).
> >>>
> >>>> Frankly speaking I have a couple of hypothesis:
> >>>>
> >>>> 1. something is not correctly setup and the PMU does not wake up the CPU1
> >>>> 2. there is a silicon bug and no one wants to tell it is the case
> >>>>
> >>>> In any case, this must be investigated and identified. And then we can
> >>>> take a decision about this state.
> >>>
> >>> I don't have good idea currently how to investigate it further.
> >>>
> >>> I also don't have any prove that the actual work is worth it
> >>> (and this work can easily take some weeks).
> >>>
> >>> One of main responsibilities of the maintainer it to make sure that
> >>> the code does indeed work and that regressions (like these caused by
> >>> AFTR mode feature) are fixed in the timely manner, not let the code
> >>> sit in the limbo state for large periods of time.  It is already very
> >>> bad situation that the regression we are hitting was present since
> >>> v3.4 and we are in v3.10 now, I would like to have it fixed ASAP so
> >>> we may actually consider enabling cpuidle in our exynos_defconfig.
> >>
> >> I agree.
> >>
> >> Thanks
> >>   -- Daniel
