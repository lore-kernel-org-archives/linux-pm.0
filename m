From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 3/6] cpufreq: governor: Drop min_sampling_rate
Date: Sun, 2 Jul 2017 09:23:50 +0200
Message-ID: <20170702072350.GB24454@light.dominikbrodowski.net>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
 <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
 <20170629180123.GA2443@light.dominikbrodowski.net>
 <20170630033425.GU29665@vireshk-i7>
 <20170630045306.GA8069@light.dominikbrodowski.net>
 <20170630054033.GZ29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630054033.GZ29665@vireshk-i7>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 11:10:33AM +0530, Viresh Kumar wrote:
> On 30-06-17, 06:53, Dominik Brodowski wrote:
> > On Fri, Jun 30, 2017 at 09:04:25AM +0530, Viresh Kumar wrote:
> > > On 29-06-17, 20:01, Dominik Brodowski wrote:
> > > > On Thu, Jun 29, 2017 at 04:29:06PM +0530, Viresh Kumar wrote:
> > > > > The cpufreq core and governors aren't supposed to set a limit on =
how
> > > > > fast we want to try changing the frequency. This is currently don=
e for
> > > > > the legacy governors with help of min_sampling_rate.
> > > > >=20
> > > > > At worst, we may end up setting the sampling rate to a value lowe=
r than
> > > > > the rate at which frequency can be changed and then one of the CP=
Us in
> > > > > the policy will be only changing frequency for ever.
> > > >=20
> > > > Is it safe to issue requests to change the CPU frequency so frequen=
tly,
> > >=20
> > > Well, I assumed so. I am not sure the hardware would break though.
> > > Overheating ?
> > >=20
> > > > even
> > > > on historic hardware such as speedstep-{ich,smi,centrino}? In the p=
ast,
>=20
> speedstep-smi is the only one which sets transition_latency to
> CPUFREQ_ETERNAL and the others are putting some meaningful values. So
> yes, they should be doing DVFS dynamically.
>=20
> > > > these checks more or less disallowed the running of dynamic frequen=
cy
> > > > scaling at least on speedstep-smi[*],
> > >=20
> > > We must by doing dynamic freq scaling even without this patch. I don't
> > > see why you say the above then.
> > >=20
> > > All we do here is that we get rid of the limit on how soon we can
> > > change the freq again.
> >=20
> > Well, as I understand it, first generation "speedstep" was designed mor=
e or
> > less to switch frequencies only when AC power was lost or restored.
> >=20
> > The Linux implementation merely said: "no on-the-fly changes", but swit=
ch
> > frequencies whenever a user explicitly requested such a change (presuma=
bly
> > only every once in an unspecified while).
> >=20
> > This same reasoning may be present in other drivers using CPUFREQ_ETERN=
AL.
>=20
> Thanks for the explanation here and I am convinced that this series
> has at least done one thing wrong. And that is removal of
> max_transition_latency from governors and allowing ondemand to run on
> such platforms (which may end up breaking them).
>=20
> So I will actually modify that patch and set max_transition_latency to
> CPUFREQ_ETERNAL for ondemand/conservative instead of 10ms. Also we
> should do the same for schedutil as well, so that will also use the
> max_transition_latency field.
>=20
> But I hope, this patch will still be fine. Right ?

Indeed, I have no comments otherwise. Thanks!

Best
	Dominik

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAllYn3sACgkQmpdgiUyN
ow0etRAAtQHgq1kN5qmw22w+zDaphoUDb4EgGDGZQg5+43u6znamZAG1bbiy8aKn
dzvvnfv0StRqk91ch8cdKeYxeouLyrpu27Wnfkt3AClugsp5lM5UplG+pFrTQFYR
4oPbvBMVh1jjApkkwGlqabQXqIWO9eQ+Oc5dBbokUGtVUgktOMX/iQH0fJ5n0UIf
QrEP146aldKXuBXQZObIF2kC3/gqSnAqEOTZvKGfmmAGPG2SRN/lnnjuCRDj3xy2
FOIZFCouH0LTTTYxpVuKHdPo40HtezZ9BuKiV1Ej1l8OAgTBwiMZsh0flfKCxP1v
fa4jP495SUsXNnZ58HRIaLrpokGU1De1wGQurAD6ViNVNPlZjfjueWSloO2m9xzo
DsLuQ2LXx2av6cICUUPN/GWz856DuMLmi3oI8CCJL2voSSmxbSpveC06E5sjOBEc
nUKsyYlc36+2n8PdBSluzxXqXdVqLnGK6glcgCLjUPneLldE4Kq/B1HujL683yUC
aopepE8+iUmrAYtmjxNozZhczqLxY7ME6ViCTPrudvGn5VHdxwzN6ohJK/V7F0Fc
k/nOGvwxVNbbBz1JzQ6RuNFZXllutOROgWwOo4hE352F8PpNfpQxYyfZVsZS33J6
kIUMGMlCdPYPBQkBciZjptw36DG2OkmYsuljULKSQ9AcoDLZ/bE=
=CMCa
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
