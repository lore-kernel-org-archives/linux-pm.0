From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 3/6] cpufreq: governor: Drop min_sampling_rate
Date: Fri, 30 Jun 2017 06:53:06 +0200
Message-ID: <20170630045306.GA8069@light.dominikbrodowski.net>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
 <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
 <20170629180123.GA2443@light.dominikbrodowski.net>
 <20170630033425.GU29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630033425.GU29665@vireshk-i7>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 09:04:25AM +0530, Viresh Kumar wrote:
> On 29-06-17, 20:01, Dominik Brodowski wrote:
> > On Thu, Jun 29, 2017 at 04:29:06PM +0530, Viresh Kumar wrote:
> > > The cpufreq core and governors aren't supposed to set a limit on how
> > > fast we want to try changing the frequency. This is currently done for
> > > the legacy governors with help of min_sampling_rate.
> > >=20
> > > At worst, we may end up setting the sampling rate to a value lower th=
an
> > > the rate at which frequency can be changed and then one of the CPUs in
> > > the policy will be only changing frequency for ever.
> >=20
> > Is it safe to issue requests to change the CPU frequency so frequently,
>=20
> Well, I assumed so. I am not sure the hardware would break though.
> Overheating ?
>=20
> > even
> > on historic hardware such as speedstep-{ich,smi,centrino}? In the past,
> > these checks more or less disallowed the running of dynamic frequency
> > scaling at least on speedstep-smi[*],
>=20
> We must by doing dynamic freq scaling even without this patch. I don't
> see why you say the above then.
>=20
> All we do here is that we get rid of the limit on how soon we can
> change the freq again.

Well, as I understand it, first generation "speedstep" was designed more or
less to switch frequencies only when AC power was lost or restored.

The Linux implementation merely said: "no on-the-fly changes", but switch
frequencies whenever a user explicitly requested such a change (presumably
only every once in an unspecified while).

This same reasoning may be present in other drivers using CPUFREQ_ETERNAL.

> > but maybe on a few other platforms as
> > well. That's why I am curious on whether this may break systems potenti=
ally
> > on a hardware level if the hardware was not designed to do dynamic freq=
uency
> > scaling (and not just frequency switches on battery/AC).
>=20
> Honestly I am not sure if any hardware can break or not, just because
> of this commit.

I am not *sure* either, I am just worried of the consequences of doing
things out-of-spec...

Best
	Dominik

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAllV2S0ACgkQmpdgiUyN
ow0hXQ//WsP2rUcRmARvrLmtgNHGw+4wj2uJp1Lyk3x3zq/zLm/iNhxZ9qTXGoSR
cFLJuB6VIvDTytANa90eRkWiqRTP2jm3GtbY1JLUSAc2N5WAOTXr8DngG0y93k5w
qWYStVpNzs3r8/ys3EUMSQXyUQx/lkCP+9p+vprE8D+8UwAojitAPD2uDfxPI17q
MfHOqjhJVKN7rtffOCuhwuiirguk4Cz5H4l5/osmeXJnRfBKPCzQYsafnT2gZGjl
95V25LfDP+FTG3YL7KrSMIVg5M/8m1z6D8X/OoDE8pqJXpx7U/7p03QIKxtN+zRZ
IHzF/88O7n+aUz9aIEwgzpCvd6rnIEJqdhbUgZQqDPQWzmky+dzFW39cn+PpId96
WJ5qofDyQlkK+CJiRaTQXuaWoMRYJpsG8YIzLc6YAy2Ipr1x3TRTET07F5Yq3S08
CyQ3MdoQTuC7lO8W3cAL7OjcvhbkY008W1VDLAwVXCglwD+Rs0JfS0e9fhzxaKNC
wWfxQuhqHZFD0CQN4A9m8iqs3s+6vif0muSVlFYh6NKZBaffy6rYq8zSoakj8Mie
m8CUs92wVdtnCJwg/RBQVmGxe8yu4QJdPS4Ar+WWo4iRmITk30W24uYqFReTg+OG
8QcKKNrlJwC+jmtlvgUw/xQMBfiP0xfJsLigJHKq5iu3iP9qvEE=
=9FBp
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
