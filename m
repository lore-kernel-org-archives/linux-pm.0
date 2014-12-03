From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 25/26] cpu_cooling: Use cpufreq_dev->freq_table for
 finding level/freq
Date: Wed, 3 Dec 2014 09:32:02 -0400
Message-ID: <20141203133159.GB4194@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <8c0412592bfd5524e638252a42edaf08f81f0976.1417167599.git.viresh.kumar@linaro.org>
 <20141202233626.GA3969@developer>
 <CAKohponQ0vr7QXFun3GmPsMCGj6VOd3P0of6Hd5p4ZBG-_PxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:59354 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaLCNcK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 08:32:10 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so10475602qae.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 05:32:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohponQ0vr7QXFun3GmPsMCGj6VOd3P0of6Hd5p4ZBG-_PxdQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 10:40:11AM +0530, Viresh Kumar wrote:
> On 3 December 2014 at 05:06, Eduardo Valentin <edubezval@gmail.com> wrote:
> >> -     ret =3D get_property(cpufreq_device, state, &clip_freq, GET_FREQ=
);
> >> -     if (ret)
> >> -             return ret;
> >> -
> >> +     clip_freq =3D cpufreq_device->freq_table[state];
> >
> > There should be some check for valid state here..
>=20
> What about this ??

Sounds good to me.

>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 6bd95bc..6e76417 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -228,6 +228,10 @@ static int cpufreq_set_cur_state(struct
> thermal_cooling_device *cdev,
>         unsigned int cpu =3D cpumask_any(&cpufreq_device->allowed_cpus);
>         unsigned int clip_freq;
>=20
> +       /* Request state should be less than max_level */
> +       if (WARN_ON(state > cpufreq_device->max_level))
> +               return -EINVAL;
> +
>         /* Check if the old cooling action is same as new cooling action =
*/
>         if (cpufreq_device->cpufreq_state =3D=3D state)
>                 return 0;

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfxDHAAoJEMLUO4d9pOJWUoQH/0YwsHwVH5RlHvsS89OyVQd2
695YJycMCE7odM7chtMP18pxwBBhS6FQ8Vic+SoCYmF+nY8dc+R3BQDAkEGKUTpl
5JaurRjSA2w1mXUBlmlz22vJY0bPvM6WstgIXl0vf8tpQuRmetsUXrmwrf+8L3x8
lF/eC+iMHC/aZHgz4HsbTGi8IeOCFi2BVpOoo3K4ACjUBksyZoWJm/4lb0Q+gRlu
gMuNbKrBUUexxkcrSCmLjz//twzzhFKZ/XepUMVy9H1Oyoqa94+9Fe+3HYI7sB2+
rth9gayQtD3uAxIWUEoGcFGqQLxOEpaUeaF+/2Wq1UjsPQf6kKaQDgvpSYna14g=
=yU29
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
