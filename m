From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Sun, 18 Jan 2015 17:47:50 +0000
Message-ID: <20150118174750.GG3574@x1>
References: <20150107212328.GA3440@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150107212328.GA3440-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Todd E Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

So now I have this odd looking front cover letter randomly in my
inbox.

Please sent patch-sets threaded, so that they cling together.

> X-Power AXP288 PMIC Fuel Gauge Driver
>=20
>  new power_supply driver at driver/power
>  interfaces with the axp20x mfd driver as a cell
>  provides battery info and monitors for changes
>  generates alerts on temperature and capacity issues

Use the full 76 chars for full sentences, or if this is a
bullet-pointed list, use actual bullet points.

> (1/3) mfd/axp20x.c: change the battery cell name to fuel_gauge
> (2/3) mfd/axp20x.h: add the register defs and platform struct for fue=
l gauge
> (3/3) power/axp288_fuel_gauge.c: axp288 fuel gauge driver

Don't hand-roll your own cover letters, use --cover-letter when
creating your patch-sets instead.

> Signed-off-by: Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ----
>  drivers/mfd/axp20x.c              |   10 +-
>  drivers/power/Kconfig             |    9 +
>  drivers/power/Makefile            |    1 +
>  drivers/power/axp288_fuel_gauge.c | 1108 +++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h        |   43 ++-
>  5 files changed, 1164 insertions(+), 7 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
