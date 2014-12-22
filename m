From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6] Thermal: introduce INT3406 thermal driver
Date: Mon, 22 Dec 2014 09:53:44 +0000
Message-ID: <20141222095344.GE4525@x1>
References: <54868CF6.6020505@intel.com>
 <CAOesGMirF-_H2ZzFR-VpwkEErZE2uQJSYx5EuePArQsEh=r_Kw@mail.gmail.com>
 <20141211010226.GA26253@aaronlu.sh.intel.com>
 <CAOesGMj_uObbxLdpobEhP=nRPsFUJNCtq01RH7ZSECd5=1Ti6Q@mail.gmail.com>
 <1418265472.12435.68.camel@rzhang1-toshiba>
 <548934D0.8000502@intel.com>
 <1418286781.12435.73.camel@rzhang1-toshiba>
 <54895821.3050902@intel.com>
 <1419217761.19619.2.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419217761.19619.2.camel@rzhang1-toshiba>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Olof Johansson <olof@lixom.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jg1.han@samsung.com
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Dec 2014, Zhang Rui wrote:

> On Thu, 2014-12-11 at 16:38 +0800, Aaron Lu wrote:
> > INT3406 ACPI device object resembles an ACPI video output device, b=
ut its
> > _BCM is said to be deprecated and should not be used. So we will ma=
ke
> > use of the raw interface to do the actual cooling. Due to this, the
> > backlight core has some modifications. Also, to re-use some of the =
ACPI
> > video module's code, one function has been exported.
> >=20
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>=20
> Jingoo and Lee,
>=20
> are you okay with the changes in drivers/video/backlight/backlight.c =
and
> include/linux/backlight.h?

NB: Jingoo still needs to review the crux of the patch.

> > ---
> > v6: Fix an issue that wrongly set error path return value as report=
ed
> > by Olof Johansson.
> >=20
> >  drivers/acpi/video.c                              |  77 ++++----
> >  drivers/thermal/Kconfig                           |  26 +--
> >  drivers/thermal/int340x_thermal/Kconfig           |  41 ++++
> >  drivers/thermal/int340x_thermal/Makefile          |   1 +
> >  drivers/thermal/int340x_thermal/int3406_thermal.c | 229 ++++++++++=
++++++++++++
> >  drivers/video/backlight/backlight.c               |  44 +++--
> >  include/acpi/video.h                              |  20 ++
> >  include/linux/backlight.h                         |   2 +
> >  8 files changed, 366 insertions(+), 74 deletions(-)
> >  create mode 100644 drivers/thermal/int340x_thermal/Kconfig
> >  create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal=
=2Ec

I gather by the message at the top that you're looking for an Ack so
this can be routed through another subsystem.  Not going to happen.

So you're on v6 already and a) no one has mentioned that introducing a
new driver AND making core framework changes (in a different subsystem
to boot) in one patch is bad and b) this is the first time you've
Cc'ed the maintainers of the aforementioned subsystem?

Moving forward you should split this patch into component parts and
resend -- only this time ensure you Cc all maintainers in the first
instance, rather than as as afterthought.

> > -config INT340X_THERMAL
> > -	tristate "ACPI INT340X thermal drivers"
> > -	depends on X86 && ACPI
> > -	select THERMAL_GOV_USER_SPACE
> > -	select ACPI_THERMAL_REL
> > -	select ACPI_FAN

This patch also relies on backlight as well, no?

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
