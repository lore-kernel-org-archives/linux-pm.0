From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] drivers: thermal: Mark function as static in
 x86_pkg_temp_thermal.c
Date: Thu, 02 Jan 2014 10:35:03 +0800
Message-ID: <1388630103.3739.71.camel@rzhang1-mobl4>
References: <20131218174602.GA27918@rashika> <20131218184014.GD24229@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131218184014.GD24229@cloud>
Sender: linux-kernel-owner@vger.kernel.org
To: josh@joshtriplett.org
Cc: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-12-18 at 10:40 -0800, josh@joshtriplett.org wrote:
> On Wed, Dec 18, 2013 at 11:16:02PM +0530, Rashika Kheria wrote:
> > Mark function sys_set_trip_temp() as static in x86_pkg_temp_thermal=
=2Ec
> > because it is not used outside this file.
> >=20
> > This eliminates the following warning in x86_pkg_temp_thermal.c:
> > drivers/thermal/x86_pkg_temp_thermal.c:218:5: warning: no previous =
prototype for =E2=80=98sys_set_trip_temp=E2=80=99 [-Wmissing-prototypes=
]
> >=20
> > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
>=20
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
>=20
applied.

thanks,
rui
> >  drivers/thermal/x86_pkg_temp_thermal.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/therm=
al/x86_pkg_temp_thermal.c
> > index 7722cb9..972e1c7 100644
> > --- a/drivers/thermal/x86_pkg_temp_thermal.c
> > +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> > @@ -215,7 +215,7 @@ static int sys_get_trip_temp(struct thermal_zon=
e_device *tzd,
> >  	return 0;
> >  }
> > =20
> > -int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
> > +static int sys_set_trip_temp(struct thermal_zone_device *tzd, int =
trip,
> >  							unsigned long temp)
> >  {
> >  	u32 l, h;
> > --=20
> > 1.7.9.5
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
