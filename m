From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 1/6] Thermal: armada_thermal: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 08:31:57 -0300
Message-ID: <20130503113156.GC2291@localhost>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39787 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3ECLcR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 07:32:17 -0400
Content-Disposition: inline
In-Reply-To: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org

On Fri, May 03, 2013 at 03:27:08PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armad=
a_thermal.c
> index 5b4d75f..0d02d4e 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -210,7 +210,6 @@ static int armada_thermal_exit(struct platform_de=
vice *pdev)
>  		platform_get_drvdata(pdev);
> =20
>  	thermal_zone_device_unregister(armada_thermal);
> -	platform_set_drvdata(pdev, NULL);
> =20
>  	return 0;
>  }

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
