From: Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 5/7] bus: vexpress-config: add missing of_node_put after
 calling of_parse_phandle
Date: Mon, 11 Jul 2016 10:02:23 +0100
Message-ID: <20160711090223.GJ8609@e106497-lin.cambridge.arm.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51498 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbcGKJCZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jul 2016 05:02:25 -0400
Content-Disposition: inline
In-Reply-To: <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>

On Fri, Jul 01, 2016 at 05:41:59PM +0800, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>=20
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> ---
>  drivers/bus/vexpress-config.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-con=
fig.c
> index c3cb76b..9efdf1d 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -178,6 +178,7 @@ static int vexpress_config_populate(struct device=
_node *node)
> =20
>  	parent =3D class_find_device(vexpress_config_class, NULL, bridge,
>  			vexpress_config_node_match);
> +	of_node_put(bridge);
>  	if (WARN_ON(!parent))
>  		return -ENODEV;
> =20
> --=20
> 1.9.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
