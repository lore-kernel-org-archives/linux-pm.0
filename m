From: Mark Brown <broonie@kernel.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 13:14:14 +0100
Message-ID: <20141007121414.GD4609@sirena.org.uk>
References: <20141007114844.GT4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8ylJtLa18RSEDYA"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141007114844.GT4609@sirena.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--k8ylJtLa18RSEDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 12:48:44PM +0100, Mark Brown wrote:
> Hi,
>=20
> The power management team at Linaro has had a look at the cpufreq
> updates since the v3.10 LTS and identified a few patches that look
> like they should be in there.  The most recent of these is from v3.12 so
> they won't apply to any of the more recent stable kernels.

CCing in the actual stable list rather than the nonexistant linux-stable.

>  - 59a6342203a7a cpufreq: Fix governor start/stop race condition
>=20
>    This looks like a straight race condition fix.
>=20
>  - 19c763031acb8 cpufreq: serialize calls to __cpufreq_governor()
>=20
>    The commit message here outlines a scenario where this change fixes a
>    crash which seems like stable material to me.  There is a context
>    change that needs a fixup but it's fairly trivial:
>=20
> diff --cc drivers/cpufreq/cpufreq.c
> index c34d4423f298,7e6baa58a7f2..000000000000
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@@ -1586,8 -1692,10 +1586,9 @@@ static int __cpufreq_governor(struct cp
>   						policy->cpu, event);
>  =20
>   	mutex_lock(&cpufreq_governor_lock);
> - 	if ((!policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_STOP)) ||
>  -	if (policy->governor_busy
>  -	    || (policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
>  -	    || (!policy->governor_enabled
>  -	    && (event =3D=3D CPUFREQ_GOV_LIMITS || event =3D=3D CPUFREQ_GOV_ST=
OP))) {
> ++	if (policy->governor_busy ||
> ++	    (!policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_STOP)) ||
>  +	    (policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_START))) {
>   		mutex_unlock(&cpufreq_governor_lock);
>   		return -EBUSY;
>   	}
>=20
>  - a857c0b9e24e3 cpufreq: Fix wrong time unit conversion
>=20
>    As noted in the changelog this is a bugfix for non-tick based
>    systems like full dynticks ones.
>=20
> There's also this:
>=20
>  - dfa5bb622555d cpufreq: ondemand: Change the calculation of target freq=
uency
>=20
>    This is a small patch which delivers a useful performance improvement
>    but it's not a bug fix and it does touch the cpufreq core so it
>    doesn't seem to really fit.  On the other hand I've got user reports
>    that it fixes problems with some multicluster systems that can scale
>    cluster frequencies independently (the additional stability in the
>    frequencies selected avoids poor interaction with scheduler as cpufreq
>    ramps the frequency while the scheduler moves load away from the
>    cluster), it's simple and it's quite well isolated so I wanted to
>    mention it.
>=20
> Thanks,
> Mark



--k8ylJtLa18RSEDYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9kWAAoJECTWi3JdVIfQa2EH/iD6394bs1u/pFD66944zoTH
YS2eBz3Liuyf/yC0qao9ke2B0joxp+5nIme22SrFq3OT7zns2xJPouc2QUqAOyfA
uCg9tc/sIyf8XVKekZMPxuwG3bjNnm3T5e4Mg89kWCZansGPUrY/WbYAiG3CNBm8
WkK6Kaa84I0Bv3eH2pscsDsICGBWz+rKc3wGBRtCm8AmPD7nKu/W6MVTFc6yy7LK
ymLtkvFSES+isj1v6r7G45KcvjkFyAu+hLwm2+HtojCxK0zoXSqJbNtaE+jOmRU6
QdhAWkxE2kjIB8PLOFpjYQCzW10ZA7mO1B7Zz2yKaLB7u965fVKhF7tJzmnSNec=
=O1Xe
-----END PGP SIGNATURE-----

--k8ylJtLa18RSEDYA--
