From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND][PATCH 1/3] PM / devfreq: exynos4_bus: Fix missing mutex_unlock if opp_find_freq_floor fails
Date: Fri, 12 Apr 2013 14:04:50 +0200
Message-ID: <5977939.Q0WPVmYRk9@vostro.rjw.lan>
References: <15500134.204421365767518757.JavaMail.weblogic@epv6ml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56994 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3DLL5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 07:57:02 -0400
In-Reply-To: <15500134.204421365767518757.JavaMail.weblogic@epv6ml01>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Axel Lin <axel.lin@ingics.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?utf-8?B?6rmA6rWt7KeE?= <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, April 12, 2013 11:52:01 AM =ED=95=A8=EB=AA=85=EC=A3=BC wrote=
:
> > On Friday, April 12, 2013 01:54:18 PM Axel Lin wrote:
> > > We need to call mutex_unlock() in the error path.
> > >=20
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> >=20
> > All three patches applied to linux-pm.git/linux-next.
> >=20
> > Exynos maintainers, if you have any objections, please holler.
> >=20
> > Thanks,
> > Rafael
>=20
> This patch was included in the last pull-request patchset
> though the path was updated. (its precedessor patch moved
> exynos drivers to /drivers/devfreq/exynos/* after adding
> Exynos common driver files)

OK, so do you want me to drop it?

What about the remaining two?

Do you have any more devfreq patches for me to take into v3.10?  If so,
please send a pull request ASAP.

Thanks,
Rafael


> >=20
> > > ---
> > >  drivers/devfreq/exynos4_bus.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/devfreq/exynos4_bus.c b/drivers/devfreq/exyn=
os4_bus.c
> > > index 1deee09..54b9615 100644
> > > --- a/drivers/devfreq/exynos4_bus.c
> > > +++ b/drivers/devfreq/exynos4_bus.c
> > > @@ -974,7 +974,8 @@ static int exynos4_busfreq_pm_notifier_event(=
struct notifier_block *this,
> > >  			rcu_read_unlock();
> > >  			dev_err(data->dev, "%s: unable to find a min freq\n",
> > >  				__func__);
> > > -			return PTR_ERR(opp);
> > > +			err =3D PTR_ERR(opp);
> > > +			goto unlock;
> > >  		}
> > >  		new_oppinfo.rate =3D opp_get_freq(opp);
> > >  		new_oppinfo.volt =3D opp_get_voltage(opp);
> > >=20
> > --=20
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> >=20
> >=20
> >=20
> >       =20
> >  =20
> >         =20
> >=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
