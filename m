From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 11/26] cpu_cooling: propagate error returned by
 idr_alloc()
Date: Tue, 2 Dec 2014 19:03:59 -0400
Message-ID: <20141202230357.GA3432@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:65509 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071AbaLBXEF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:04:05 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so10414219qcx.30
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:04:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Viresh,

On Fri, Nov 28, 2014 at 03:14:05PM +0530, Viresh Kumar wrote:
> We aren't supposed to return our own error type here. Return what we got.
>=20

OK..

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index bb11dd4..964586f 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -477,7 +477,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	ret =3D get_idr(&cpufreq_idr, &cpufreq_dev->id);
>  	if (ret) {
>  		kfree(cpufreq_dev);
> -		return ERR_PTR(-EINVAL);
> +		return ERR_PTR(cpufreq_dev->id);

cpufreq_dev is an invalid object here. Maybe you want to use ret in your
patch?
>  	}
> =20
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
> --=20
> 2.0.3.693.g996b0fd
>=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkVUAAoJEMLUO4d9pOJW2HMH/ird0j3qIh0vyBdShoq93DIb
NCXeoz7gzaLiBgers0cBWP9/VKjpGoZm7LwyH6SApqp2gllNQFBekI4n/y7vdWAq
rDXT9xCpF5jj6Wxx8DTP0c3dnI2NJF+Jhu32YxPvpklAZgV9rMLTxneSuCHjfivm
fl6jzSV9B9BnFLLjFiAaG9l8oBWchEWdC0hJkvJe3t+UMUuoQ8cu4Ne2fGFTUj1a
YfC7sqMu4mp06lZM+ZoKkIkrr+egpqtOGKyMNPMYgPWEzi5KADeMBA44dp9iovWr
FlzhsXB/FQjRmCKfEvlSGXeYJqUUWDqnzj5gNS6kzjhIhgmuyk4NbLhHIaYb0/E=
=GM0d
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
