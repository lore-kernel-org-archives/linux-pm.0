From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Thu, 19 Jun 2014 00:03:44 +0200
Message-ID: <20140618220343.GD26514@mithrandir>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <53A069B6.6070902@wwwdotorg.org> <53A1CB23.5090307@collabora.com>
 <53A1D089.8010605@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0681148240=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53A1D089.8010605@wwwdotorg.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0681148240==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2014 at 11:46:49AM -0600, Stephen Warren wrote:
> On 06/18/2014 11:23 AM, Tomeu Vizoso wrote:
> > On 06/17/2014 06:15 PM, Stephen Warren wrote:
> >> On 06/17/2014 06:16 AM, Tomeu Vizoso wrote:
> >>> On 06/16/2014 10:02 PM, Stephen Warren wrote:
> >>>> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> >>>>> +#ifdef CONFIG_TEGRA124_EMC
> >>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
> >>>>> long rate);
> >>>>> +void tegra124_emc_set_floor(unsigned long freq);
> >>>>> +void tegra124_emc_set_ceiling(unsigned long freq);
> >>>>> +#else
> >>>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
> >>>>> long rate)
> >>>>> +{ return -ENODEV; }
> >>>>> +void tegra124_emc_set_floor(unsigned long freq)
> >>>>> +{ return; }
> >>>>> +void tegra124_emc_set_ceiling(unsigned long freq)
> >>>>> +{ return; }
> >>>>> +#endif
> >>>>
> >>>> I'll repeat what I said off-list so that we can have the whole
> >>>> conversation on the list:
> >>>>
> >>>> That looks like a custom Tegra-specific API. I think it'd be much
> >>>> better
> >>>> to integrate this into the common clock framework as a standard clock
> >>>> constraints API. There are other use-cases for clock constraints
> >>>> besides
> >>>> EMC scaling (e.g. some in audio on Tegra, and I'm sure many on other
> >>>> SoCs too).
> >>>
> >>> Yes, I wrote a bit in the cover letter about our requirements and how
> >>> they map to the CCF. Could you please comment on that?
> >>
> >> My comments remain the same. I believe this is something that belongs =
in
> >> the clock driver, or at the least, some API that takes a struct clock =
as
> >> its parameter, so that drivers can use the existing DT clock lookup
> >> mechanism.
> >=20
> > Ok, let me put this strawman here to see if I have gotten close to what
> > you have in mind:
> >=20
> > * add per-client accounting (Rabin's patches referenced before)
> >=20
> > * add clk_set_floor, to be used by cpufreq, load stats, etc.
> >=20
> > * add clk_set_ceiling, to be used by battery drivers, thermal, etc.
>=20
> Yes. I'd expect those to be maintained per-client, and so the clock core
> (or whatever higher level code implements clk_set_floor/ceiling)
> performs the logic that "blends" together all the different requests
> from different clients.
>=20
> As an aside, for audio usage, I would expect clk_set_rate to be a
> per-client (rather than per HW clock) operation too, and to error out if
> one client says it wants to set pll_a to the rate needed for
> 44.1KHz-based audio and a different client wants the rate for
> 48KHz-based audio.

=46rom what I remember, Mike was fairly strongly opposing the idea of
virtual clocks, but what you're proposing here sounds like it would
assume the existence of virtual clocks. clk_set_rate() per client
doesn't work with the current API as I understand it.

Or perhaps what you're proposing isn't about the individual clocks at
all but rather about a mechanism to express constraints for a set of
clocks?

Thierry

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTogy/AAoJEN0jrNd/PrOh/qsP/iihmTM7Im+DJRajK2T4CIkE
UUr0AulmfauENoP3jT5jD0QrnD2dETMJIAqxsSOCuK+R9bSMYM/ZPPeZI3940BbT
l1sLHBBAPV9aEaD/8tCiDWYbWrDEK8c05JA0Ca6oCHg2yGygUMrkEAAsb0bv3T0u
84rx950jgdoOknFkgi5S5FEgxoiMfRJQ7woOsxWn3uBtwHAZj0VI55TdUOhEkrnu
MJ/v57SWx7u4WLv2yImVV3F2qMLev5JMSCjdwjZFTQ4H+RMEQHuY0LPcXnlerHPw
ZcMzq2ADgolVAvUoq4dq/BQ8kwkonD4roaFzILKkDha3NudFsjWO6/9k6SFClCtT
6jMkNKkQqHbNxpucxYfVoG/I5empt9FXYC7TQqJTrqfj1ZF9P6D569ks+AoHtVe8
ijme8ppvxV6nDHkIstPxoLtuaUPAyRZ5BXLGge+h3r4RCs4IdnRosMLcc30hR4lJ
rKFc+ldbtiDI88jt961ynRsSpW5bHd5r0DQkA9uP/Z1AE0hmiqB9fPN8cNcLVV3x
+sxL0R2lurAvrIhbOY7MnlAhaRZRcHGE1k6hbHc7PtKK8S/9l9Ppft9w7K3K1Uxs
CYe1LjCOhjI3UTJE6nBt3Z4N3emaNyepzHYXp4G+DoEIZE3MV9ZKF+YTi+ohqERw
/Dw50svlL3q8f8tmpK3P
=xszF
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--

--===============0681148240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0681148240==--
