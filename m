From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Fri, 28 Jun 2013 12:13:33 +0100
Message-ID: <20130628111333.GA30603@e102568-lin.cambridge.arm.com>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
 <11082993.ysZegLgQAY@amdc1032>
 <51CD5E05.3000307@linaro.org>
 <19893620.AhWB5HomTT@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <19893620.AhWB5HomTT@amdc1227>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "jc.lee@samsung.com" <jc.lee@samsung.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 28, 2013 at 11:11:24AM +0100, Tomasz Figa wrote:
> Hi Daniel,
> 
> I've been fighting with this whole AFTR state as well, before Bartlomiej.
> Let me share my thoughts on this.
> 
> On Friday 28 of June 2013 11:57:25 Daniel Lezcano wrote:
> > On 06/27/2013 08:10 PM, Bartlomiej Zolnierkiewicz wrote:
> > > On Wednesday, June 26, 2013 12:36:12 PM Daniel Lezcano wrote:
> > >> On 06/26/2013 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
> > >>> AFTR mode support was introduced by commit 67173ca ("ARM: EXYNOS: Add
> > >>> support AFTR mode on EXYNOS4210") in v3.4 kernel.  Unfortunately even
> > >>> in v3.4 kernel it hasn't worked as supposed and this is still the
> > >>> case
> > >>> with v3.10-rc6 (it probably wasn't noticed because CONFIG_CPU_IDLE is
> > >>> not turned on by default):
> > >>>
> > >>> - on revision 0 of Exynos4210 (Universal C210 board) it causes lockup
> > >>>
> > >>>   (on this revision only one core is usable so entry to AFTR mode is
> > >>>   always attempted because the code tries to go into AFTR mode when
> > >>>   all
> > >>>   other CPUs except CPU0 are offlined)
> > >>>
> > >>> - on revision 1.1 of Exynos4210 (Trats board) it causes a lockup when
> > >>>
> > >>>   CPU1 is offlined (i.e. echo 0 >
> > >>>   /sys/devices/system/cpu/cpu1/online)
> > >>>
> > >>> - on later Exynos4/5 SoCs wrong registers may be accessed when all
> > >>> CPUs
> > >>>
> > >>>   except CPU0 are offlined resulting in panic/lockup
> > >>>   (REG_DIRECTGO_ADDR
> > >>>   and REG_DIRECTGO_FLAG register selections was implemented only for
> > >>>   Exynos4210)
> > >>>
> > >>> Just remove AFTR mode support for now.
> > >>
> > >> Ok, I will jump on the opportunity to talk about this state.
> > >>
> > >> 1. I tried different ways to make the AFTR state to be entered with
> > >> *both* cpu online. It goes successfully to this state. The CPU0 is
> > >> correctly woken up but the CPU1 is never woken up, why is it happening
> > >> ?
> > >>
> > >> https://bugs.launchpad.net/linaro-landing-team-samsung/+bug/1171518
> > >
> > > No idea here, AFTR doesn't work for me with upstream kernels even if
> > > only one CPU is online.
> >
> > What do you mean by "AFTR doesn't work" ? Is the kernel hanging ? The
> > state is never reached ?
> 
> If you don't unplug all the CPUs >0 the state is obviously never reached.
> Otherwise the whole system hangs after it tries to enter this mode without
> any reaction for external events, other than reset.
> 
> > > Also the documentation says that before entering system-level
> > > power-down
> > > mode (such as AFTR) when multiple CPUs cores are used all other CPU
> > > cores should stop interrupt service so I'm not sure how the way
> > > attempted by you should work.
> >
> > The cpu enters the idle mode with the interrupts disabled.
> 
> Hmm? What is supposed to wake it up then? AFAIK the whole idea of any idle
> or sleep is to sit in such low power mode until some interrupt fires (and so
> the name of the WFI, wait for interrupt, instruction).

WFI completes upon IRQ even if irqs are disabled for a CPU, unless the
GIC CPU interface is disabled for that CPU as well. How the power
controller wakes up the CPUs from shutdown is strictly related to the
power controller behaviour. The problem here I think is completely different
and it is related to how the power controller behaves on Exynos.
I think the issues are a combination of power controller/boot firmware that
prevents CPU1 to go into idle independently of CPU0, but I might be mistaken.

If you want to get to the bottom of this you need to get detailed information
on how the firmware and power controller behave, trial and error won't work.

> > >> 2. The CPU1 hotplug bug should been fixed and if I am not wrong there
> > >> is
> > >> a patch somewhere fixing this.
> > >>
> > >> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171382
> > >
> > > Unfortunately none of the patches there helps with my issues.
> > >
> > >> 3. What is the fix for Exynos5 ?
> > >>
> > >> https://bugs.launchpad.net/linaro-power-kernel/+bug/1171253
> > >>
> > >> It sounds like depending on Hypervisor mode is enabled or not, the
> > >> AFTR
> > >> does not work correctly.
> > >
> > > Sorry no idea here either.  On any SoCs later than EXYNOS4210 the
> > > registers used for s3c_cpu_resume address and 0xFCBA0D10 magic number
> > > may be different than EXYNOS4210 defaults (at least on EXYNOS4412 they
> > > indeed are different, unfortunately I lack any info needed for EXYNOS5
> > > support). You are lucky that it even works in some cases on EXYNOS5250.
> > >
> > >> In other words, instead of removing the AFTR state I suggest to fix
> > >> it:
> > >> both core being online, split driver for exynos4 and 5.
> > >
> > > My main problem is that with the upstream kernel even on EXYNOS4210
> > > rev0 (only one core useable due to hardware issues) the kernel goes
> > > into AFTR state for the first few times during boot and then it just
> > > lockups (after going into cpu_do_idle() which is really
> > > cpu_v7_do_idle()
> > > and which does wfi call) and doesn't wake up CPU0. I have currently
> > > no idea how to fix or debug it further.
> >
> > I have an Origen 4210 board Ver A. and it works without problem with the
> > AFTR mode (cpu1 unplugged).
> 
> Great!
> 
> Since benefits of this feature are rather questionable, especially when you
> consider all the maintenance burden caused by it, could you do some
> measurements to check if power saving thanks to this mode is of any
> significance?

Questionable ? Questionable is the way this code has been put on the
backburner without upstreaming it properly.

> > > The issue happens with every upstream kernel version tried (from v3.4
> > > to v3.10-rc6).  Lockups also happen on EXYNOS4210 rev1.1 when CPU1 is
> > > offlined by hand and then cpuidle driver tries to go into AFTR mode
> > > (because by default it doesn't go into AFTR mode on any SoC except
> > > EXYNOS4210 rev0).
> > >
> > > I don't have EXYNOS4210 rev1.0 but it seems that in the upstream AFTR
> > > mode has never worked (even on hardware that it was originally
> > > developed
> > > on) since its introduction in v3.4 (which was released on 20th May
> > > 2012).
> > >
> > > IOW for over the year nobody cared to make it work and I have currently
> > > no fix at hand so the corrent upstream resolution is to just remove the
> > > known non-working code and re-introduce it later when/if needed (I can
> > > just disable it with a small fix but we don't keep such long-term
> > > broken
> > > code as placeholder in the upstream kernel).  If left as it is people
> > > can hit the known issues and waste time debugging them, just like this
> > > happenend for me [1].
> > >
> > > If you have AFTR mode working (especially on EXYNOS4210) in Linaro
> > > kernels please get fixes upstream ASAP. However I still wonder whether
> > > the maintanance nightmare (bugs for different cases in your launchpad)
> > > is worth gains over standard idle mode as the rumor around here is that
> > > they are not that great (unfortunately no numbers were provided during
> > > original feature addition).
> >
> > It works forme with a vanilla kernel 3.10.0-rc7.
> 
> As Bartek already said, I haven't worked on any of our Exynos 4210 based
> boards since it got introduced in Linux 3.4, with exactly the same effect we
> described.
> 
> > Removing a feature because it seems not working is not a good solution.
> > The right way is to investigate what is happening and why.
> 
> I can agree only partially. Keeping a feature that is broken and without
> any significant benefits does not make sense for me. Neither does putting
> efforts into fixing it, only to find that it is of no use.

Well, either power management HW works on these boards, so there are
significant benefits in fixing the code, or it does not and you are right
then.

If power management HW works there are benefits and they are significant for
manifold reasons (first and foremost, since these are dev boards, to show
how power management backends must be written, but honestly this driver
fails in that respect). It is absolutely worth putting effort in fixing the
behaviour, the problem is finding people who can answer questions on
how the power controller and firmware are *supposed* to be working,
otherwise we will never get to the bottom of this.

I understand that these bits of information are hard to come by, and for
that reason we might be forced to drop this code, but this does not mean
that these features are not useful.

> However this is purely a speculation. Could you test on your Origen, on
> which it is supposed to work, if this feature is of any use ?

If power management HW works properly on these boards, and I hope it
does (but the only way to check it is by measuring power drawn), this feature
is useful, now the question is to understand how and who is going to fix it,
if we can manage to do that.

Thanks,
Lorenzo
