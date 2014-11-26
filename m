From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/7] cpufreq-dt: pass 'policy->related_cpus' to
 of_cpufreq_cooling_register()
Date: Wed, 26 Nov 2014 13:55:32 -0400
Message-ID: <20141126175531.GB1826@developer>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
 <4a62588b693c1ab0de09c59da38c03c7ae9c4c06.1416980448.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:45783 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaKZRzm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:55:42 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so2429397qcy.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 09:55:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4a62588b693c1ab0de09c59da38c03c7ae9c4c06.1416980448.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 11:22:57AM +0530, Viresh Kumar wrote:
> The second parameter of of_cpufreq_cooling_register() should be the CPUs =
to
> which the frequency constraint will apply. As the cpufreq-dt driver now s=
upports
> platforms with multiple 'struct cpufreq_policy' instances (i.e. > 1 clock
> domains for CPUs), passing 'cpu_present_mask' isn't correct anymore. As e=
very
> policy will have a set of CPUs and that may not be equal to 'cpu_present_=
mask'
> always.
>=20
> So, pass only mask of CPUs which are controlled by current policy.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8cba13d..7374fc4 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -274,7 +274,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	 * thermal DT code takes care of matching them.
>  	 */
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		cdev =3D of_cpufreq_cooling_register(np, cpu_present_mask);
> +		cdev =3D of_cpufreq_cooling_register(np, policy->related_cpus);
>  		if (IS_ERR(cdev))
>  			dev_err(cpu_dev,
>  				"running cpufreq without cooling device: %ld\n",
> --=20
> 2.0.3.693.g996b0fd
>=20

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdhQKAAoJEMLUO4d9pOJWw9QH/3K01dR9mgtn4Ijv4wAxY6nH
MlPorO9kznqJr1SCkQrW8RwW1pSV9YYlnOebNBWltjQ/MxnpY6OjJSvfDFKmFGX1
1GdWmUdP7lmmBLGg5zgz9XJoYlUmUsNllAxAwH6P8m11R6AIg/6CJZEwokSbtO5Z
VZCEJAy09Aq/F8H2higFDACuOnJJPtUH0W99F6sDfDndnG0mm7zo4ChSn1EUnUWp
kMbQaSMjfeIe/VdKajSv+CtiiMIeKq7cbJ21KJgyV3YFSwiUicGtOYPSgOSZFI9V
y0DH5cb7mZkLQzNckHJos/jWFWSJOY/FCggbYhr7Gs3/Ebwtn6VRX1IZWwc34dA=
=RSdk
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
