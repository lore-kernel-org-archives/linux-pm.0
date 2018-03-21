From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
Date: Wed, 21 Mar 2018 18:55:09 +0100
Message-ID: <20180321175509.jkemst242vv7d4qv@kozik-lap>
References: <CGME20180321094523eucas1p1a87d146d65d4191ccdb37f1723977011@eucas1p1.samsung.com>
 <20180321094505.25494-1-m.szyprowski@samsung.com>
 <3225655.FLAaRANmer@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3225655.FLAaRANmer@aspire.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 21, 2018 at 02:49:52PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 21, 2018 10:45:05 AM CET Marek Szyprowski wrote:
> > Since commit 04c8b0f82c7d ("irqchip/gic: Make locking a BL_SWITCHER only
> > feature") coupled CPU idle freezes from time to time on Exynos4210. Later
> > commit 313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
> > changed the context in which the CPU idle code is executed, what results
> > in fully reproducible freeze all the time. However, almost the same coupled
> > CPU idle code works fine on Exynos3250 regarless of the changes made in
> > the mentioned commits.
> > 
> > It turned out that the IPI call used on Exynos4210 is conflicting with the
> > change done in the first mentioned commit in GIC. Fix this by using the
> > same code path as for Exynos3250, instead of the IPI call for
> > synchronization with second CPU core, call dsb_sev() directly.
> > 
> > Tested on Exynos4210-based Trats and Origen boards.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > CC: stable@vger.kernel.org # v4.13+
> > ---
> >  arch/arm/mach-exynos/pm.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index dc4346ecf16d..a1055a2b8d54 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -271,11 +271,7 @@ static int exynos_cpu0_enter_aftr(void)
> >  				goto fail;
> >  
> >  			call_firmware_op(cpu_boot, 1);
> > -
> > -			if (soc_is_exynos3250())
> > -				dsb_sev();
> > -			else
> > -				arch_send_wakeup_ipi_mask(cpumask_of(1));
> > +			dsb_sev();
> >  		}
> >  	}
> >  fail:
> > 
> 
> That will be -stable material I believe?

Yes, it is CC-stable.

Marek,
Thanks, applied (with adjustment of stable address - I believe if some
text follows it, it makes more readable to put <>).

Best regards,
Krzysztof
