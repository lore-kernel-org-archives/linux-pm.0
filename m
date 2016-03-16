From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Tue, 15 Mar 2016 20:55:21 -0400
Message-ID: <1458089721.8898.25.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	 <1458007395.8898.19.camel@redhat.com> <2600831.Qfymhh5Hpv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zypiiLBiP7XSvW9Tg81F"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbcCPAzY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Mar 2016 20:55:24 -0400
In-Reply-To: <2600831.Qfymhh5Hpv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-zypiiLBiP7XSvW9Tg81F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-03-16 at 01:32 +0100, Rafael J. Wysocki wrote:
>=C2=A0
> =C2=A0		=C2=A0* We want to default to C1 (hlt), not to busy
> polling
> -		=C2=A0* unless the timer is happening really really soon.
> +		=C2=A0* unless the timer is happening really really
> soon.=C2=A0=C2=A0Still, if
> +		=C2=A0* the exit latency of C1 is too high, we need to
> poll anyway.
> =C2=A0		=C2=A0*/
> -		if (interactivity_req > 20 &&
> +		if (data->next_timer_us > 20 &&
> +		=C2=A0=C2=A0=C2=A0=C2=A0drv-
> >states[CPUIDLE_DRIVER_STATE_START].exit_latency <=3D 2 &&
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0!drv-

I wonder if replacing these two tests with
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data->next_timer_us
>=C2=A0states[CPUIDLE_DRIVER_STATE_START].exit_latency
would do the right thing?

That way any time we do not know for sure we are waking
up before the HLT exit latency has gone, we will poll.

Any time we suspect we will wake up sooner (data->predicted_us
is smaller than the HLT exit latency) we will still pick HLT,
anyway.

This makes the behaviour consistent between CPUs.

> >states[CPUIDLE_DRIVER_STATE_START].disabled &&
> -			dev-
> >states_usage[CPUIDLE_DRIVER_STATE_START].disable =3D=3D 0)
> +		=C2=A0=C2=A0=C2=A0=C2=A0!dev-
> >states_usage[CPUIDLE_DRIVER_STATE_START].disable)
> =C2=A0			data->last_state_idx =3D
> CPUIDLE_DRIVER_STATE_START;
> =C2=A0	} else {
> =C2=A0		data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START;
--=20
All Rights Reversed.


--=-zypiiLBiP7XSvW9Tg81F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJW6K75AAoJEM553pKExN6D+kcH/0o4hnbkWsSdR5YvAApANb+L
CnV1iYQ+2HqrgBIbz47tER4rpsGrUPyF9hwo+2jA8CXTfAzHBm1vFvE8oeJVMsbb
58buUDs/uHC0AtXikzQwNPU4uUl8LTYRPYu+F0HT8WQOEvJWjmYxfroWPdXpyzfr
EjMESx2mHjAAVPb5Kkw2XicRixh2S7L//wBRdPq1h0tN5CKDjjAeM6LKOmO6GcyA
6cO+2hnMsX2THeQ/zvsRhJ8fl58XMRlPkWTjipKix4UXEYX8tFDkPraD/OWXG4l1
Nkyng6rjteI2yRzdMpSfFLZ+BdHatxtlmwkut/RwL823S/EWKuTXwY0QcaXzGVE=
=J6vY
-----END PGP SIGNATURE-----

--=-zypiiLBiP7XSvW9Tg81F--

