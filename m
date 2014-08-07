From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix module license spec
Date: Thu, 7 Aug 2014 17:29:34 +0200
Message-ID: <20140807152934.GT1933@pengutronix.de>
References: <mvmmwbqateb.fsf@hawking.suse.de>
 <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <mvmiom48knf.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37335 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaHGP3j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Aug 2014 11:29:39 -0400
Content-Disposition: inline
In-Reply-To: <mvmiom48knf.fsf@hawking.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 07, 2014 at 04:00:20PM +0200, Andreas Schwab wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > Having no license specification in a module taints the kernel durin=
g load
> > with:
> >
> > 	arm_big_little: module license 'unspecified' taints kernel.
> >
> > and also the linker doesn't allow it to make use of GPL-exported sy=
mbols
> > which in this case also results in errors like:
> >
> > 	arm_big_little: Unknown symbol cpufreq_register_driver (err 0)
> >
> > . The header of the driver specifies a GPL v2 license, so note that
> > accordingly. While at it also add a description and an author and f=
ix
> > the license in a companion file to explicit v2.
> >
> > Reported-by: Andreas Schwab <schwab@suse.de>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > ---
> >  drivers/cpufreq/arm_big_little.c    | 4 ++++
> >  drivers/cpufreq/arm_big_little_dt.c | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm=
_big_little.c
> > index 1f4d4e315057..b600f3107bef 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -593,3 +593,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_b=
L_ops *ops)
> >  	arm_bL_ops =3D NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
> > +
> > +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> > +MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> > +MODULE_LICENSE("GPL v2");
>=20
> drivers/cpufreq/arm_big_little.c:613:15: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>                ^
> drivers/cpufreq/arm_big_little.c:614:20: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
>  MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
>                     ^
> drivers/cpufreq/arm_big_little.c:615:16: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
>  MODULE_LICENSE("GPL v2");
>                 ^
>=20
Does adding

	#include <linux/module.h>

in that file fix the problem?

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
