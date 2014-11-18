From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide
 number of non critical trip points
Date: Tue, 18 Nov 2014 21:25:08 +0100
Message-ID: <20141118212508.3667d9c3@jawa>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-4-git-send-email-l.majewski@samsung.com>
 <20141107014152.GD10180@developer>
 <20141107110551.5316836f@amdc2363>
 <20141107160630.GA23549@developer>
 <20141112104241.50f644a4@amdc2363>
 <20141118152024.GA18674@developer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3598352287063753410=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141118152024.GA18674@developer>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

--===============3598352287063753410==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/=E.VHG9Fj/rEqhFm4AG6dI6"; protocol="application/pgp-signature"

--Sig_/=E.VHG9Fj/rEqhFm4AG6dI6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2014 11:20:26 -0400
Eduardo Valentin <edubezval@gmail.com> wrote:

> Hello Lukasz,
>=20
> On Wed, Nov 12, 2014 at 10:42:41AM +0100, Lukasz Majewski wrote:
> > Hi Eduardo,
> >=20
> > >=20
> > > Hello Lukasz,
> > >=20
> > > On Fri, Nov 07, 2014 at 11:05:51AM +0100, Lukasz Majewski wrote:
> > > > Hi Eduardo,
> > > >=20
> > > > > On Thu, Oct 09, 2014 at 06:38:39PM +0200, Lukasz Majewski
> > > > > wrote:
> > > > > > This patch extends the of-thermal.c to provide information
> > > > > > about number of available non critical (i.e. non HW) trip
> > > > > > points in the system.
> > > > > >=20
> > > > > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > > > > ---
> > > > > >  drivers/thermal/of-thermal.c   | 12 ++++++++++++
> > > > > >  drivers/thermal/thermal_core.h |  5 +++++
> > > > > >  2 files changed, 17 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/thermal/of-thermal.c
> > > > > > b/drivers/thermal/of-thermal.c index 23c8d6c..cd74e64 100644
> > > > > > --- a/drivers/thermal/of-thermal.c
> > > > > > +++ b/drivers/thermal/of-thermal.c
> > > > > > @@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct
> > > > > > thermal_zone_device *tz, int trip) return 1;
> > > > > >  }
> > > > > > =20
> > > > > > +int of_thermal_get_non_crit_ntrips(struct
> > > > > > thermal_zone_device *tz) +{
> > > > > > +	struct __thermal_zone *data =3D tz->devdata;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	for (i =3D 0; i < data->ntrips; i++)
> > > > > > +		if (data->trips[i].type !=3D
> > > > > > THERMAL_TRIP_CRITICAL)
> > > > > > +			continue;
> > > > > > +
> > > > > > +	return --i;
> > > > > > +}
> > > > > > +
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > I am not against this addition. But looks like we start to
> > > > > spread some specific APIs that may not be used to other
> > > > > drivers.
> > > >=20
> > > > Why do you think that this is a specific API? In the thermal OF
> > > > we can define trip point as "active", "passive", "hot" and
> > > > "critical".
> > > >=20
> > > > With the first three we can handle them and properly react. For
> > > > the last one SoC's PMU will power down the board.
> > > >=20
> > > > Do you know if any board (e.g. from TI) is NOT supposed to shut
> > > > down when "critical" temperature is passed?
> > > >=20
> > >=20
> > > So, my point is not really about the usage of trip points. It is
> > > just that the of-thermal  API will grow with in a wide way with
> > > specific functions to check some property on the trip point
> > > array. And not all drivers may be using these function, e.g. the
> > > above proposal.
> > >=20
> > > > The real problem here is the accessibility to __thermal_trip and
> > > > __thermal_bind arrays.
> > > >=20
> > > > Use case:
> > > > In the Exynos driver we do need to initialize TMU registers with
> > > > threshold temperatures.
> > > > The temperature is read via tz->ops->get_trip_temp() [1] (from
> > > > of-thermal.c).
> > > > Unfortunately, the current API is not exporting the number of
> > > > non-critical trip points to know how many times call [1].
> > > > Of course we could by hand instantiate [1] n times, but this
> > > > looks for me a bit clumsy.
> > >=20
> > >=20
> > > I understand your use case. My point was simply that this use
> > > case may be specific to your driver (or few drivers).
> > > >=20
> > > > Additionally, we now have implicit assumption about the order of
> > > > defined temperatures for trip points, but I think this is not a
> > > > big issue.
> > > >=20
> > > > > Maybe having a
> > > > > single API to provide a read-only copy the list / array of
> > > > > trips might be a better approach. I will think of a better
> > > > > way.
> > > >=20
> > > > Definitely. Exporting available trip points is crucial.
> > > >=20
> > >=20
> > > Yeah, I think it is the best thing to do. Share a read-only
> > > array / copy of the needed data, and then drivers would check
> > > what ever property they need from the array. Just make sure you
> > > document that this is a read-only array (i.e. any possible change
> > > they do, won't affect the original array).
> >=20
> > So I assume that you don't mind that I will prepare such
> > of-thermal.c modification?
>=20
> No, please, feel free to send the proposal along with your patchset.
> To me, it makes sense you do it, because you will also present a real
> use case of this required change.

Ok. I will rebase on top of your today's work.

>=20
> >=20
> > >=20
> > > > >=20
> > > > > I also request you to document it accordingly.
> > > >=20
> > > > Ok, I will do that.
> > >=20
> > > Cool!
> > >=20
> > >=20
> > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >  static int of_thermal_get_trend(struct thermal_zone_device
> > > > > > *tz, int trip, enum thermal_trend *trend)
> > > > > >  {
> > > > > > diff --git a/drivers/thermal/thermal_core.h
> > > > > > b/drivers/thermal/thermal_core.h index ed8ff05..334a7be
> > > > > > 100644 --- a/drivers/thermal/thermal_core.h
> > > > > > +++ b/drivers/thermal/thermal_core.h
> > > > > > @@ -83,6 +83,7 @@ int of_parse_thermal_zones(void);
> > > > > >  void of_thermal_destroy_zones(void);
> > > > > >  int of_thermal_get_ntrips(struct thermal_zone_device *);
> > > > > >  int of_thermal_is_trip_en(struct thermal_zone_device *,
> > > > > > int); +int of_thermal_get_non_crit_ntrips(struct
> > > > > > thermal_zone_device *); #else
> > > > > >  static inline int of_parse_thermal_zones(void) { return
> > > > > > 0; } static inline void of_thermal_destroy_zones(void) { }
> > > > > > @@ -94,6 +95,10 @@ int of_thermal_is_trip_en(struct
> > > > > > thermal_zone_device *, int) {
> > > > > >  	return 0;
> > > > > >  }
> > > > > > +int of_thermal_get_non_crit_ntrips(struct
> > > > > > thermal_zone_device *)
> > > > > here, it is supposed to be static inline.
> > > > >=20
> > > > > > +{
> > > > > > +	return 0;
> > > > > > +}
> > > > > >  #endif
> > > > > > =20
> > > > > >  #endif /* __THERMAL_CORE_H__ */
> > > > > > --=20
> > > > > > 2.0.0.rc2
> > > > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > --=20
> > > > Best regards,
> > > >=20
> > > > Lukasz Majewski
> > > >=20
> > > > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
> >=20
> >=20
> >=20
> > --=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

Best regards,
Lukasz Majewski

--Sig_/=E.VHG9Fj/rEqhFm4AG6dI6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlRrqyQACgkQf9/hG2YwgjEgVQCgo8/dmeWczCX6t539xlwcNToO
I7EAoJhgOh6MDuD8i+s5qji4dp5SEg1W
=H7Pp
-----END PGP SIGNATURE-----

--Sig_/=E.VHG9Fj/rEqhFm4AG6dI6--


--===============3598352287063753410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3598352287063753410==--
