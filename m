From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Wed, 10 Dec 2014 12:13:31 +0000
Message-ID: <20141210121331.GD23481@x1>
References: <1418126634-4781-1-git-send-email-beomho.seo@samsung.com>
 <1418126634-4781-2-git-send-email-beomho.seo@samsung.com>
 <20141209140102.GZ3951@x1>
 <54882255.9060303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54882255.9060303-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, geunsik.lim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Dec 2014, Beomho Seo wrote:

> On 12/09/2014 11:01 PM, Lee Jones wrote:
> > On Tue, 09 Dec 2014, Beomho Seo wrote:
> >=20
> >> This patch adds a new driver for Richtek RT5033 driver.
> >> RT5033 is a Multifunction device which includes battery charger, f=
uel gauge,
> >> flash LED current source, LDO and synchronous Buck converter. It i=
s interfaced
> >> to host controller using I2C interface.
> >>
> >> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> Cc: Lee Jones <lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> ---
> >>  drivers/mfd/Kconfig                |   12 ++
> >>  drivers/mfd/Makefile               |    1 +
> >>  drivers/mfd/rt5033.c               |  142 ++++++++++++++++++++
> >>  include/linux/mfd/rt5033-private.h |  260 +++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/mfd/rt5033.h         |   62 +++++++++
> >>  5 files changed, 477 insertions(+)
> >>  create mode 100644 drivers/mfd/rt5033.c
> >>  create mode 100644 include/linux/mfd/rt5033-private.h
> >>  create mode 100644 include/linux/mfd/rt5033.h
> >=20
> > Much better.
> >=20
> > For my own reference:
> >=20
> > Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >=20
> > So what's the plan with this set?
> >=20
>=20
> This patch have been made on for-next-mfd branch of your git reposito=
ry.
> So I hope this patch to be merged at your git repository.
> Another patch set(RT5033 regulator driver) have been merged on for-ne=
xt branch of regulator git repository.
>=20
> https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/co=
mmit/?h=3Dfor-next&id=3Db1917578fd5d8efa67afa05a0d6d7e323f2802da
>=20
> Other patches(about charger, fuelgague and devicetree doc) will be re=
-sent to each maintainers.

Okay, so all patches are indipendant/othognal of each other for sure?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
