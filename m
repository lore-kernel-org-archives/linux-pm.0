From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Fri, 28 Jun 2013 19:31:05 +0200
Message-ID: <1721255.XMYjiW81jp@amdc1227>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
 <19893620.AhWB5HomTT@amdc1227> <51CD7169.6010905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <51CD7169.6010905@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On Friday 28 of June 2013 13:20:09 Daniel Lezcano wrote:
> On 06/28/2013 12:11 PM, Tomasz Figa wrote:
> > Hi Daniel,
> > 
> > I've been fighting with this whole AFTR state as well, before
> > Bartlomiej. Let me share my thoughts on this.
> > 
> > On Friday 28 of June 2013 11:57:25 Daniel Lezcano wrote:
> >> On 06/27/2013 08:10 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> On Wednesday, June 26, 2013 12:36:12 PM Daniel Lezcano wrote:
> >>>> On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
> >>>>> AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS:
> >>>>> Add
> >>>>> support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately
> >>>>> even
> >>>>> in v3.4 kernel it hasn't worked as supposed and this is still the
> >>>>> case
> >>>>> with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDLE
> >>>>> is
> >>>>> not turned on by default):
> >>>>> 
> >>>>> - on revision 0 of Exynos4210 (Universal C210 board) it causes
> >>>>> lockup
> >>>>> 
> >>>>>   (on this revision only one core is usable so entry to AFTR mode
> >>>>>   is
> >>>>>   always attempted because the code tries to go into AFTR mode when
> >>>>>   all
> >>>>>   other CPUs except CPU0 are offlined)
> >>>>> 
> >>>>> - on revision 1.1 of Exynos4210 (Trats board) it causes a lockup
> >>>>> when
> >>>>> 
> >>>>>   CPU1 is offlined (i.e. echo 0 >
> >>>>>   /sys/devices/system/cpu/cpu1/online)
> >>>>> 
> >>>>> - on later Exynos4/5 SoCs wrong registers may be accessed when all
> >>>>> CPUs
> >>>>> 
> >>>>>   except CPU0 are offlined resulting in panic/lockup
> >>>>>   (REG_DIRECTGO_ADDR
> >>>>>   and REG_DIRECTGO_FLAG register selections was implemented only
> >>>>>   for
> >>>>>   Exynos4210)
> >>>>> 
> >>>>> Just remove AFTR mode support for now.
> >>>> 
> >>>> Ok, I will jump on the opportunity to talk about this state.
> >>>> 
> >>>> 1. I tried different ways to make the AFTR state to be entered with
> >>>> *both* cpu online. It goes successfully to this state. The CPU0 is
> >>>> correctly woken up but the CPU1 is never woken up, why is it
> >>>> happening
> >>>> ?
> >>>> 
> >>>> https://bugs.launchpad.net/linaro-landing-team-samsung/+bug/1171518
> >>> 
> >>> No idea here, AFTR doesn't work for me with upstream kernels even if
> >>> only one CPU is online.
> >> 
> >> What do you mean by "AFTR doesn't work" ? Is the kernel hanging ? The
> >> state is never reached ?
> > 
> > If you don't unplug all the CPUs >0 the state is obviously never
> > reached. Otherwise the whole system hangs after it tries to enter this
> > mode without any reaction for external events, other than reset.
> 
> Need investigation.

Not necessarily. If this feature is worth it, then sure, but otherwise it 
would be just wasted effort.

> What is the exynos board version where that occurs ?

If this is what you are asking about:
 - Universal C210 with Exynos 4210 rev 0.0,
 - Trats with Exynos 4210 rev. 1.1.

> >>> Also the documentation says that before entering system-level
> >>> power-down
> >>> mode (such as AFTR) when multiple CPUs cores are used all other CPU
> >>> cores should stop interrupt service so I'm not sure how the way
> >>> attempted by you should work.
> >> 
> >> The cpu enters the idle mode with the interrupts disabled.
> > 
> > Hmm? What is supposed to wake it up then? AFAIK the whole idea of any
> > idle or sleep is to sit in such low power mode until some interrupt
> > fires (and so the name of the WFI, wait for interrupt, instruction).
> 
> It is handled by the hardware, for the exynos it should be the PMU. The
> CPU stays clock/power gated and when an interrupt occurs the PMU wakes
> up the CPU. This one continue its instructions after cpu_do_idle and
> right after enables the local interrupts leading to the interrupt
> handling.

OK. I misunderstood you previously then, taking interrupts disabled as 
interrupts signals masked in the controller.

> >>>> 2. The CPU1 hotplug bug should been fixed and if I am not wrong
> >>>> there
> >>>> is
> >>>> a patch somewhere fixing this.
> >>>> 
> >>>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171382
> >>> 
> >>> Unfortunately none of the patches there helps with my issues.
> >>> 
> >>>> 3. What is the fix for Exynos5 ?
> >>>> 
> >>>> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171253
> >>>> 
> >>>> It sounds like depending on Hypervisor mode is enabled or not, the
> >>>> AFTR
> >>>> does not work correctly.
> >>> 
> >>> Sorry no idea here either.  On any SoCs later than EXYNOS4210 the
> >>> registers used for s3c_cpu_resume address and 0xFCBA0D10 magic number
> >>> may be different than EXYNOS4210 defaults (at least on EXYNOS4412
> >>> they
> >>> indeed are different, unfortunately I lack any info needed for
> >>> EXYNOS5
> >>> support). You are lucky that it even works in some cases on
> >>> EXYNOS5250.
> >>> 
> >>>> In other words, instead of removing the AFTR state I suggest to fix
> >>>> it:
> >>>> both core being online, split driver for exynos4 and 5.
> >>> 
> >>> My main problem is that with the upstream kernel even on EXYNOS4210
> >>> rev0 (only one core useable due to hardware issues) the kernel goes
> >>> into AFTR state for the first few times during boot and then it just
> >>> lockups (after going into cpu_do_idle() which is really
> >>> cpu_v7_do_idle()
> >>> and which does wfi call) and doesn't wake up CPU0. I have currently
> >>> no idea how to fix or debug it further.
> >> 
> >> I have an Origen 4210 board Ver A. and it works without problem with
> >> the
> >> AFTR mode (cpu1 unplugged).
> > 
> > Great!
> > 
> > Since benefits of this feature are rather questionable, especially when
> > you consider all the maintenance burden caused by it, could you do
> > some measurements to check if power saving thanks to this mode is of
> > any significance?
> 
> No I can't, no spare time for that and furthermore this work has already
> be done by Amit Daniel when he submitted the driver.

I was unable to find any measurement results or even any other rationale. 
Would you mind pointing me to them? Thanks in advance.

> Amit Daniel is no longer a Linaro assignee but it is still part of the
> Samsung company (changed the email address to reach him).

OK, thanks.

> >>> The issue happens with every upstream kernel version tried (from v3.4
> >>> to v3.10-rc6).  Lockups also happen on EXYNOS4210 rev1.1 when CPU1 is
> >>> offlined by hand and then cpuidle driver tries to go into AFTR mode
> >>> (because by default it doesn't go into AFTR mode on any SoC except
> >>> EXYNOS4210 rev0).
> >>> 
> >>> I don't have EXYNOS4210 rev1.0 but it seems that in the upstream AFTR
> >>> mode has never worked (even on hardware that it was originally
> >>> developed
> >>> on) since its introduction in v3.4 (which was released on 20th May
> >>> 2012).
> >>> 
> >>> IOW for over the year nobody cared to make it work and I have
> >>> currently
> >>> no fix at hand so the corrent upstream resolution is to just remove
> >>> the
> >>> known non-working code and re-introduce it later when/if needed (I
> >>> can
> >>> just disable it with a small fix but we don't keep such long-term
> >>> broken
> >>> code as placeholder in the upstream kernel).  If left as it is people
> >>> can hit the known issues and waste time debugging them, just like
> >>> this
> >>> happenend for me [1].
> >>> 
> >>> If you have AFTR mode working (especially on EXYNOS4210) in Linaro
> >>> kernels please get fixes upstream ASAP. However I still wonder
> >>> whether
> >>> the maintanance nightmare (bugs for different cases in your
> >>> launchpad)
> >>> is worth gains over standard idle mode as the rumor around here is
> >>> that
> >>> they are not that great (unfortunately no numbers were provided
> >>> during
> >>> original feature addition).
> >> 
> >> It works forme with a vanilla kernel 3.10.0-rc7.
> > 
> > As Bartek already said, I haven't worked on any of our Exynos 4210
> > based
> > boards since it got introduced in Linux 3.4, with exactly the same
> > effect we described.
> > 
> >> Removing a feature because it seems not working is not a good
> >> solution.
> >> The right way is to investigate what is happening and why.
> > 
> > I can agree only partially. Keeping a feature that is broken and
> > without
> > any significant benefits does not make sense for me. Neither does
> > putting efforts into fixing it, only to find that it is of no use.
> > 
> > However this is purely a speculation. Could you test on your Origen, on
> > which it is supposed to work, if this feature is of any use?
> 
> It is useless to do that. This work is already done.

Hmm? As I said, I couldn't find any results of that work.

> The kernel is not a playground where you can upstream code and then
> remove it because a feature seems broken and you don't have an idea of
> why.

Well, first of all, it has not been upstreamed correctly: a) without any 
given rationale (or at least without any I could find) and b) without enough 
testing.

> I asked several times the reasons of why the AFTR state couldn't work
> with multiple CPUs and I had no answer.
> 
> Frankly speaking I have a couple of hypothesis:
> 
> 1. something is not correctly setup and the PMU does not wake up the CPU1
> 2. there is a silicon bug and no one wants to tell it is the case
> 
> In any case, this must be investigated and identified. And then we can
> take a decision about this state.

Well, everything you're saying is correct, assuming that this feature is 
useful, which needs confirmation. I'd still want any evidence of this 
feature being of any use first, to not waste time on something that is 
useless.

Best regards,
Tomasz
