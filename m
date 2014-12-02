From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 05/26] cpu_cooling: random comment fixups
Date: Tue, 2 Dec 2014 19:09:35 -0400
Message-ID: <20141202230933.GE3432@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <79da69f109b055b435f3703e23abf3a6415a40d9.1417167599.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:65247 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071AbaLBXJp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:09:45 -0500
Received: by mail-qg0-f44.google.com with SMTP id z60so10047041qgd.17
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:09:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <79da69f109b055b435f3703e23abf3a6415a40d9.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, rui.zhang@intel.com


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2014 at 03:13:59PM +0530, Viresh Kumar wrote:
> s/give/given
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/cpu_cooling.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1ab0018..7c2ba2e 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -122,7 +122,7 @@ enum cpufreq_cooling_property {
>  };
> =20
>  /**
> - * get_property - fetch a property of interest for a give cpu.
> + * get_property - fetch a property of interest for a given cpu.
>   * @cpu: cpu for which the property is required
>   * @input: query parameter
>   * @output: query return
> @@ -132,6 +132,7 @@ enum cpufreq_cooling_property {
>   * 1. get maximum cpu cooling states
>   * 2. translate frequency to cooling state
>   * 3. translate cooling state to frequency
> + *
>   * Note that the code may be not in good shape
>   * but it is written in this way in order to:
>   * a) reduce duplicate code as most of the code can be shared.
> @@ -212,7 +213,7 @@ static int get_property(unsigned int cpu, unsigned lo=
ng input,
>  }
> =20
>  /**
> - * cpufreq_cooling_get_level - for a give cpu, return the cooling level.
> + * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
>   * @cpu: cpu for which the level is required
>   * @freq: the frequency of interest
>   *
> --=20
> 2.0.3.693.g996b0fd
>=20

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkalAAoJEMLUO4d9pOJWNkkIAIhGiG7FNzfvWpwO6CHxEcmt
+wEreiw4PONuhjh8BBZZS4Sc6t+sDFV8IFE2LYjNpon2rWvF11FZ/xWsWvjdnGGP
cOsBvCxf59ZSsOY68snXR5yB5yJF6aQ0lCQkM8yhNdn1V6PJZs40K6ptjio1GbLw
8HETb/GSuGe7MfGPYnruxTttGc2Qo0y0XPVP/sREy7DpcSLsSFk3LOzkef+tWPLQ
RzVtowEJxVYOh+QoejLe2aBC76VWvVYXREHwdFgR1QxrycyHvhDlebRM6AZQjZP8
UQtWQUil4KcS6EK1Pe71BMSJIlBkF0JJP3UGb+npZXUly2oK1HwK3smwi/cbn4E=
=QJ9s
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
