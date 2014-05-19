From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/10] thermal: exynos: various cleanups
Date: Mon, 19 May 2014 13:05:24 +0200
Message-ID: <4899668.1WyrreGo3H@amdc1032>
References: <1399288539-1793-1-git-send-email-b.zolnierkie@samsung.com>
 <1400144805.2273.34.camel@rzhang1-toshiba>
 <CADGdYn5S67Sd8ON5YHiUvqiw7ypXqV3n4VURheEJsStWinR85w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CADGdYn5S67Sd8ON5YHiUvqiw7ypXqV3n4VURheEJsStWinR85w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, May 19, 2014 11:46:10 AM Amit Kachhap wrote:
> On 5/15/14, Zhang Rui <rui.zhang@intel.com> wrote:
> > On =E4=B8=80, 2014-05-05 at 13:15 +0200, Bartlomiej Zolnierkiewicz =
wrote:
> >> Hi,
> >>
> >> This patch series contains various cleanups for EXYNOS thermal
> >> driver.  Overall it decreases driver's LOC by 13%.  It is based
> >> on next-20140428 kernel.  It should not cause any functionality
> >> changes.
> >>
> > Amit,
> >
> > what do you think of this patch set?
> >
> > thanks,
> > rui
>=20
> I agreed to many of the cleanups in the patch but tmu controller
> features should be retained as they will allow adding quick soc
> support and also avoid unnecessary churning of code in the future.

The general rule in the kernel code is not to keep the dead code as
it has a maintainance cost and makes further changes usually more
difficult, not easier.  There is no guarantee that the future SoCs
support will use the dead code (i.e. TYPE_TWO_POINT_TRIMMING support
has been introudced more than 2.5 years but no users of it has been
ever added) and in the meantime all other code changes has to take
the dead code into account.  I also have more Exynos thermal driver
changes in the work and it would be much easier to do them without
the need to support unused SoC features.  Please consider this in
your opinion.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks,
> Amit
>=20
> >> Best regards,
> >> --
> >> Bartlomiej Zolnierkiewicz
> >> Samsung R&D Institute Poland
> >> Samsung Electronics
> >>
> >>
> >> Bartlomiej Zolnierkiewicz (10):
> >>   thermal: exynos: remove unused struct exynos_tmu_registers entri=
es
> >>   thermal: exynos: remove unused defines
> >>   thermal: exynos: remove dead code for HW_MODE calibration
> >>   thermal: exynos: remove dead code for TYPE_TWO_POINT_TRIMMING
> >>     calibration
> >>   thermal: exynos: remove redundant pdata checks from
> >>     exynos_tmu_initialize()
> >>   thermal: exynos: remove redundant threshold_code checks from
> >>     exynos_tmu_initialize()
> >>   thermal: exynos: simplify temp_to_code() and code_to_temp()
> >>   thermal: exynos: cache non_hw_trigger_levels in pdata
> >>   thermal: exynos: remove redundant pdata checks from
> >>     exynos_tmu_control()
> >>   thermal: exynos: remove identical values from exynos*_tmu_regist=
ers
> >>     structures
> >>
> >>  drivers/thermal/samsung/exynos_thermal_common.h |   1 -
> >>  drivers/thermal/samsung/exynos_tmu.c            | 181
> >> ++++--------------------
> >>  drivers/thermal/samsung/exynos_tmu.h            |  86 +----------
> >>  drivers/thermal/samsung/exynos_tmu_data.c       |  40 +-----
> >>  drivers/thermal/samsung/exynos_tmu_data.h       |  32 +----
> >>  5 files changed, 37 insertions(+), 303 deletions(-)
