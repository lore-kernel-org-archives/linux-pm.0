From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 08/26] cpu_cooling: Pass variable instead of its type to
 sizeof()
Date: Tue, 2 Dec 2014 19:07:32 -0400
Message-ID: <20141202230730.GC3432@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <1a0d2430eb52b55fdb8f82c4cbbb8b4038a105ec.1417167599.git.viresh.kumar@linaro.org>
 <20141202152624.GA2834@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:35145 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149AbaLBXHm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 18:07:42 -0500
Received: by mail-qa0-f45.google.com with SMTP id x12so9621625qac.18
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 15:07:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141202152624.GA2834@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 02, 2014 at 03:26:24PM +0000, Javi Merino wrote:
> Hi Viresh,
>=20
> On Fri, Nov 28, 2014 at 09:44:02AM +0000, Viresh Kumar wrote:
> > Just following coding guidelines here.
> >=20
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coolin=
g.c
> > index def0f21..59725d8 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -468,8 +468,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >  				return ERR_PTR(-EINVAL);
> >  		}
> >  	}
> > -	cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_cooling_device),
> > -			      GFP_KERNEL);
> > +	cpufreq_dev =3D kzalloc(sizeof(*cool_dev), GFP_KERNEL);
>=20
> This should be:
>=20
> +	cpufreq_dev =3D kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);

Agreed.

>=20
> Cheers,
> Javi
>=20

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfkYpAAoJEMLUO4d9pOJWsV4IAJlLff3qGJVViFAYkP4EG1t6
oLzXdxYXLmVTajOg7aALrgXyOQSHHCYgX3lWlylhluHQoOw5kiM2Vf25eT6P7d7m
8DB9pw9G0Ge7IJ3KnifFcBWkYo7nxe9OsrfDwxdfa2kMS+J+/tfsO2tigUMZvBjG
8T7lRXZdIlXtRtblfVfnnxfHv2OpvP8UeWJ7wChLhV2+eqs64GzLFQZsKboFXAeH
kkoIZutq6vi/O7zzgkmgaPC3LUFIzmWndkS928v5rRWna+NizVxskWV5zHJmSRok
V6cwqPfBP6qU4YoXXnZgQKmIo/NDL/bGTBkELJkBNHohm3vQBy9I8yJIHG7xRk4=
=AzGo
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
