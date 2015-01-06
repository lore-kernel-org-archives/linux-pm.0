From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] Documentation: thermal: document
 of_cpufreq_cooling_register()
Date: Tue, 6 Jan 2015 14:39:37 -0400
Message-ID: <20150106183936.GB11119@developer>
References: <1420568065-5153-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43671 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbAFSjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 13:39:45 -0500
Content-Disposition: inline
In-Reply-To: <1420568065-5153-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 06:14:25PM +0000, Javi Merino wrote:
> Commit 39d99cff76bf ("thermal: cpu_cooling: introduce
> of_cpufreq_cooling_register") taught the cpu cooling device to register
> devices that were linked to the device tree but didn't update the
> cpu-cooling-api documentation.  Fix it.
>=20
> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>

Thanks, applied to my -fixes branch.

> ---
>  Documentation/thermal/cpu-cooling-api.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/th=
ermal/cpu-cooling-api.txt
> index fca24c931ec8..753e47cc2e20 100644
> --- a/Documentation/thermal/cpu-cooling-api.txt
> +++ b/Documentation/thermal/cpu-cooling-api.txt
> @@ -3,7 +3,7 @@ CPU cooling APIs How To
> =20
>  Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> =20
> -Updated: 12 May 2012
> +Updated: 6 Jan 2015
> =20
>  Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
> =20
> @@ -25,7 +25,18 @@ the user. The registration APIs returns the cooling de=
vice pointer.
> =20
>     clip_cpus: cpumask of cpus where the frequency constraints will happe=
n.
> =20
> -1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cde=
v)
> +1.1.2 struct thermal_cooling_device *of_cpufreq_cooling_register(
> +	struct device_node *np, const struct cpumask *clip_cpus)
> +
> +    This interface function registers the cpufreq cooling device with
> +    the name "thermal-cpufreq-%x" linking it with a device tree node, in
> +    order to bind it via the thermal DT code. This api can support multi=
ple
> +    instances of cpufreq cooling devices.
> +
> +    np: pointer to the cooling device device tree node
> +    clip_cpus: cpumask of cpus where the frequency constraints will happ=
en.
> +
> +1.1.3 void cpufreq_cooling_unregister(struct thermal_cooling_device *cde=
v)
> =20
>      This interface function unregisters the "thermal-cpufreq-%x" cooling=
 device.
> =20
> --=20
> 1.9.1
>=20

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrCvcAAoJEMLUO4d9pOJW+nYH/2qMNhtUeCaeB9JgQoXumYX1
Q3xgPbN6SONn3z0189rmcAZgx432e9Rk1WZkVmB0L8Iub9eOy876m/U92WqA7yXN
0lHZh72hjwChCxjDF6eVayfx7ts3S8nEnxyuPvv2Jv/+a15IdYEvrIfpTFvRD2ak
DRWU3+xoVLbhfWqHnkgOdYNTIUrM6rlRe4EO9Axs+F4SnC1Xrhi/rzom4Lvkuzq2
NML5+APRj0EonzHS1uNj29Kcw6mytdWHQwO5tWFKImPJnCCnjMW6hWwJ2wFF7/nY
Pr95CmGaoCsK3WDreTGuLwuHUR2FnSo90InSkTfVgyPT44I4f0y16J4xhr1IGbQ=
=zu74
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
