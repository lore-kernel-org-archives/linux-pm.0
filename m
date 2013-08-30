From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: Check cpuidle driver before add refcount
Date: Fri, 30 Aug 2013 21:51:35 +0200
Message-ID: <5922282.AsA87j7ngC@vostro.rjw.lan>
References: <1377863302-22465-1-git-send-email-danifu@nvidia.com> <1725801.dn2z0gQifB@vostro.rjw.lan> <D9A2FA38A1E15B4E832469E5FE40C7ABFB583335A4@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45556 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab3H3Tkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2013 15:40:52 -0400
In-Reply-To: <D9A2FA38A1E15B4E832469E5FE40C7ABFB583335A4@HKMAIL01.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Fu <danifu@nvidia.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johnny Qiu <joqiu@nvidia.com>

On Friday, August 30, 2013 09:39:27 PM Daniel Fu wrote:
> Yes, I saw it.=20
> Thanks. found one case when  Find PM domain and connect cpuidle to it=
 , in when Kernel booting ,opening early prink testing
> pm_genpd_name_attach_cpuidle()->cpuidle_driver_ref().

I see. OK, I'll queue it up for the second part of the 3.12 merge windo=
w.

Thanks,
Rafael


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl]=20
> Sent: 2013=E5=B9=B48=E6=9C=8830=E6=97=A5 21:26
> To: Daniel Fu
> Cc: daniel.lezcano@linaro.org; linux-pm@vger.kernel.org; linux-kernel=
@vger.kernel.org; Johnny Qiu
> Subject: Re: [PATCH] cpuidle: Check cpuidle driver before add refcoun=
t
>=20
> On Friday, August 30, 2013 08:26:34 PM Daniel Fu wrote:
> > X-NVConfidentiality: public
> >=20
> > In SMP, When doing the cpuidle driver registration. There maybe onl=
y 1=20
> > cpu have register cpuidle(CPU0), but In the process of registration=
=20
> > cpuidle driver, the scheduler maybe schedule the process to the oth=
er=20
> > CPU (eg. CPU0 have heay load, migrate to CPU1)
> > cpuidle_get_driver() --> get_cpu() , will get CPU1, if CPU1 didn't =
register cpuidle driver, Will get NULL.
> >=20
> > I know we should prevent the registration migrate to the other CPU,=
 but we should check drv before add refcount to prevent kernel panic at=
 least, Right?
>=20
> Well, cpuidle_driver_ref() has only one caller, which is not the regi=
stration.
>=20
> However, the caller apparently assumes that that function may return =
NULL and
> cpuidle_driver_unref() check drv against NULL too, so cpuidle_driver_=
ref() should do that either.
>=20
> Did you see that problem in testing or just through code inspection?
>=20
> Rafael
>=20
>=20
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > Sent: 2013=E5=B9=B48=E6=9C=8830=E6=97=A5 20:01
> > To: Daniel Fu
> > Cc: daniel.lezcano@linaro.org; linux-pm@vger.kernel.org;=20
> > linux-kernel@vger.kernel.org; Johnny Qiu
> > Subject: Re: [PATCH] cpuidle: Check cpuidle driver before add refco=
unt
> >=20
> > On Friday, August 30, 2013 07:48:22 PM Daniel Fu wrote:
> > > If the current CPU has no cpuidle driver, drv will be NULL.
> > > Check if we get drv successfully before add refount to prevent=20
> > > Kernel panic.
> >=20
> > What is the actual scenario that may lead to this panic?
> >=20
> > Rafael
> >=20
> >=20
> > > Signed-off-by: Daniel Fu <danifu@nvidia.com>
> > > ---
> > >  drivers/cpuidle/driver.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c=20
> > > index
> > > 3ac499d..6e11701 100644
> > > --- a/drivers/cpuidle/driver.c
> > > +++ b/drivers/cpuidle/driver.c
> > > @@ -331,7 +331,8 @@ struct cpuidle_driver *cpuidle_driver_ref(voi=
d)
> > >  	spin_lock(&cpuidle_driver_lock);
> > > =20
> > >  	drv =3D cpuidle_get_driver();
> > > -	drv->refcnt++;
> > > +	if (drv)
> > > +		drv->refcnt++;
> > > =20
> > >  	spin_unlock(&cpuidle_driver_lock);
> > >  	return drv;
> > >=20
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> >=20
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
