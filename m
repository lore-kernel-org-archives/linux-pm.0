From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Mon, 17 Nov 2014 12:40:35 +0100
Message-ID: <20141117114034.GE25699@ulmo>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415898165-27406-6-git-send-email-l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 06:02:42PM +0100, Lukasz Majewski wrote:
> When CPU freq is used as a thermal zone cooling device, one needs to wait
> until cpufreq subsystem is properly initialized.
>=20
> This code is similar to the one already available in imx_thermal.c file.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/thermal/tegra_soctherm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soc=
therm.c
> index 70f7e9e..9c5aaa4 100644
> --- a/drivers/thermal/tegra_soctherm.c
> +++ b/drivers/thermal/tegra_soctherm.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/thermal.h>
> +#include <linux/cpufreq.h>
> =20
>  #include <soc/tegra/fuse.h>
> =20
> @@ -346,6 +347,12 @@ static int tegra_soctherm_probe(struct platform_devi=
ce *pdev)
> =20
>  	const struct tegra_tsensor *tsensors =3D t124_tsensors;
> =20
> +#ifdef CONFIG_CPU_THERMAL
> +	if (!cpufreq_get_current_driver()) {
> +		dev_dbg(&pdev->dev, "no cpufreq driver!");

Shouldn't this rather be dev_err() or dev_warn() to give at least some
clue as to the cause?

Thierry

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUad6yAAoJEN0jrNd/PrOhJA8P/0ENnloNjC6BTahtRDY/neyO
Pp8jazZYQ6i1FeBqGXD6sa8ccsRzzLI0K5MuI+oaKnYyw8w3qJtUtIRs4p3lyvV0
dyCuyx5Twn8UrJHZj76q6Zv1NHUiulCyqZOxqjljNjuGtptfWBUDxjhtWNINIqFq
G4Uyr0dBIF485xi03UApagiQ5dQFeIFNjqkB6e56s29ztzf3NmHcjkjMs8pjLtef
cgOoQSDGqdE1ZqFezo0JFu6KRMUkVBUbwZyuWNM4n/2hlpRNNonsmPg8nnjYv6LC
MjP3H7cFZUC1sQDymj5as5zdBmqRpgxLlQS9Vsw+PDHCKgowKzQRTVFHPLEsZJpY
4IFKI+QvErAMJqNPC8O680WFBttzfZY5EekxsVIyE/Wse330/Lf+833wNflsLE9W
t1bSeLKxnKgYpVoDXq0/viEuChdah6eZNa+zw5q/KpvitV3rYSyFjgkwfFWm29Fi
CeYHJ7glR4TymHDFfOM7E8FuleHOzMwYN9iSO0lBzurqprSHlA+VMOlvrx6lMeDe
EVXcq/SqMPnLo47Zjk3CLvg5+Sowd47Gk075yLgyYzocWiJ1yPP8Zq24IjsI7rUT
Yv+UHj4q7+AlCefYkEmb7ftoSzgvXY8VsRomrBxlciErwme5/6OPP77wm/CODu18
P3OvVXHJVVe5aZl2OTCG
=XUiC
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
