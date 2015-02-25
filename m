From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] drivers: cpuidle: add driver/device checks in
 cpuidle_enter_freeze()
Date: Wed, 25 Feb 2015 14:47:37 +0000
Message-ID: <20150225144737.GD20214@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1424800730-32059-3-git-send-email-lorenzo.pieralisi@arm.com>
 <54EDDC99.40208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54EDDC99.40208@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 25, 2015 at 02:30:49PM +0000, Daniel Lezcano wrote:
> On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> > The changes in commit:
> >
> > 381063133246 ("PM / sleep: Re-implement suspend-to-idle handling")
> >
> > let suspend-to-idle code bypass the cpuidle_select() function to
> > enter the deepest idle state. The sanity checks carried out in
> > cpuidle_select() are bypassed too and this can cause breakage
> > on systems that try to suspend-to-idle with no registered cpuidle
> > driver.
> >
> > This patch factors out a function cpuidle_device_disabled() that
> > is used to carry out sanity checks (ie CPUidle is disabled on the
> > cpu executing the code) in both cpuidle_select() and cpuidle_enter_=
freeze()
> > so that the checks are unified and carried out in both control path=
s.
> >
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >   drivers/cpuidle/cpuidle.c | 18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index f47edc6c..344fe6c 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -44,6 +44,12 @@ void disable_cpuidle(void)
> >   	off =3D 1;
> >   }
> >
> > +static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
> > +				    struct cpuidle_device *dev)
> > +{
> > +	return (off || !initialized || !drv || !dev || !dev->enabled);
> > +}
>=20
> This is getting a bit fuzzy IMO. What means disabled ? :)

Well, that's just the current checks in cpuidle_select() (that by
the way is supposed to return an index) merged together with a function
name, to reuse the same checks in cpuidle_enter_freeze().
I have no problem leaving the checks as they are at the moment and
replicate them in cpuidle_enter_freeze() but given your remark below,
we should do something different in there.

>=20
> >   /**
> >    * cpuidle_play_dead - cpu off-lining
> >    *
> > @@ -124,6 +130,11 @@ void cpuidle_enter_freeze(void)
> >   	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> >   	int index;
>=20
> I think this is exploding before because of dev =3D=3D NULL in the li=
ne above.

Yes, good point so my attempt at consolidating the sanity checks above
is not valid, but something has to be done regardless.

Lorenzo

> > +	if (cpuidle_device_disabled(drv, dev)) {
> > +		arch_cpu_idle();
> > +		return;
> > +	}
> > +
> >   	/*
> >   	 * Find the deepest state with ->enter_freeze present, which gua=
rantees
> >   	 * that interrupts won't be enabled when it exits and allows the=
 tick to
> > @@ -202,11 +213,8 @@ int cpuidle_enter_state(struct cpuidle_device =
*dev, struct cpuidle_driver *drv,
> >    */
> >   int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_dev=
ice *dev)
> >   {
> > -	if (off || !initialized)
> > -		return -ENODEV;
> > -
> > -	if (!drv || !dev || !dev->enabled)
> > -		return -EBUSY;
> > +	if (cpuidle_device_disabled(drv, dev))
> > +		return -1;
> >
> >   	return cpuidle_curr_governor->select(drv, dev);
> >   }
> >
>=20
>=20
> --=20
>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
>=20
