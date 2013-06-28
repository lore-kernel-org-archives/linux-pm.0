From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Sat, 29 Jun 2013 01:07:13 +0200
Message-ID: <23262498.GmEHQP5Xlz@flatron>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <1721255.XMYjiW81jp@amdc1227> <51CE0DB8.5040407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <51CE0DB8.5040407@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On Saturday 29 of June 2013 00:27:04 Daniel Lezcano wrote:
> On 06/28/2013 07:31 PM, Tomasz Figa wrote:
> > On Friday 28 of June 2013 13:20:09 Daniel Lezcano wrote:
> [ ... ]
> 
> >> The kernel is not a playground where you can upstream code and then
> >> remove it because a feature seems broken and you don't have an idea
> >> of
> >> why.
> > 
> > Well, first of all, it has not been upstreamed correctly: a) without
> > any given rationale (or at least without any I could find) and b)
> > without enough testing.
> 
> +1
> 
> >> I asked several times the reasons of why the AFTR state couldn't work
> >> with multiple CPUs and I had no answer.
> >> 
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
> > Well, everything you're saying is correct, assuming that this feature
> > is useful, which needs confirmation. I'd still want any evidence of
> > this feature being of any use first, to not waste time on something
> > that is useless.
> 
> IMHO, it is useful. That's sure a highly integrated hardware with a lot
> of peripherals, the power saving is lost in the noise but with a small
> embedded device, the power saving is significant.

Be aware that we might be talking here about savings of single 
milliamperes, because the highest, dynamic, power consumption is already 
bypassed in WFI idle mode, with stopped core clock.

Our measurements have shown that static leakage is pretty low on SoCs we 
checked, that is Exynos 4210 and Exynos 4412. I don't remember exactly 
ATM, because it was some time ago, but it was something around 2 mA per 
core.

Now it depends on overall power consumption of given system, whether such 
saving is significant or ignorable - in our case it is the latter, because 
consumption caused by rest of the system (think of display, wireless 
radios, etc.) is much higher.

> What I am worried about is the different SoCs being introduced in this
> driver without investigating this cpu1 restriction and it sounds like
> the AFTR seems to work (I have an odroid-u2 with a 4412 I will test to
> check if the AFTR works on it) and nobody seems to be hurt by this and,
> as you stated, there is no rational about it. That means the Exynos will
> become really more and more power aggressive with 4/A15 or 8/A15 based
> boards if the AFTR state is not correctly supported.

See my other reply, for a bit more information about this state and CPU1 
restriction.

> AFAICT, there is also the LPA state and the DEEPSLEEP, right ? If the
> AFTR does not work, I don't see these states working too.

Yes, there are other states as well. With similar execution flow, but 
different set of preserved and lost context, requiring more or less save 
and restore on kernel side.

> The cpuidle driver is critical for the new b.L architecture. If we
> aren't able to put a cluster of big cpus in a power down state, we lose
> the benefit of all the work made up-front at the scheduler level (eg.
> small task packing, workqueue/timer migration) and more generally we
> lose the benefit of the b.L architecture (except if we do some hacks
> which are orthogonal to the generic approach).

In this case just simple power down of CPU cores is enough, which doesn't 
require entering system-wide low power state, such as AFTR and friends. 
Such low power mode is needed only when you want to power off all the 
cores, which makes you lose program execution state.

When at least one of the cores is still active, the whole system is in 
control of kernel and no special care must be taken to bring up cores that 
are down and back, just standard SMP/hotplug ops.

Best regards,
Tomasz
