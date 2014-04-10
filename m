From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: offer Samsung thermal support only when
 ARCH_EXYNOS is defined
Date: Thu, 10 Apr 2014 14:29:35 +0200
Message-ID: <12703899.ZIfn6gkXfr@amdc1032>
References: <2958660.aJeCDrTTOe@amdc1032>
 <CADGdYn4YQL9-8WCDNWP8x9Gec9sMV09q3OsYPz3tTdMxDGnyvg@mail.gmail.com>
 <5294A097.3070903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5294A097.3070903@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org


Hi,

Zhang, could you please pick this patch up to your tree?

[ Eduardos's tree hasn't been updated for over 4 months and
  seems to be dead.. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Tuesday, November 26, 2013 09:22:31 AM Eduardo Valentin wrote:
> On 26-11-2013 02:07, Amit Kachhap wrote:
> > On 10/4/13, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> >> Menu for Samsung thermal support is visible on all Samsung
> >> platforms while thermal drivers are currently available only
> >> for EXYNOS SoCs. Fix it by replacing PLAT_SAMSUNG dependency
> >> with ARCH_EXYNOS one.
> >>
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Looks good, so
> > Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> I will be queuing this one in my tree.
> 
> Thanks Bartlomiej.
> 
> > 
> >> ---
> >>  drivers/thermal/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index a709c63..05cf95c 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -198,7 +198,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
> >>  endmenu
> >>
> >>  menu "Samsung thermal drivers"
> >> -depends on PLAT_SAMSUNG
> >> +depends on ARCH_EXYNOS
> >>  source "drivers/thermal/samsung/Kconfig"
> >>  endmenu
> >>
> >> --
> >> 1.8.2.3
