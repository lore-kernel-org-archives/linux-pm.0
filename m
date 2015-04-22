From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [patch] thermal: rockchip: fix an error code
Date: Wed, 22 Apr 2015 11:07:44 +0800
Message-ID: <55371080.4090307@rock-chips.com>
References: <20150421093410.GE12098@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.4]:49008 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbDVDII (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 23:08:08 -0400
In-Reply-To: <20150421093410.GE12098@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Zhang Rui <rui.zhang@intel.com>, Caesar Wang <caesar.wang@rock-chips.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org



=E5=9C=A8 2015=E5=B9=B404=E6=9C=8821=E6=97=A5 17:34, Dan Carpenter =E5=86=
=99=E9=81=93:
> There is a copy and paste bug, "->clk" vs "->pclk", so we return the
> wrong error code here.
>
> Fixes: cbac8f639437 ('thermal: rockchip: add driver for thermal')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/roc=
kchip_thermal.c
> index 3aa46ac..cd8f5f93 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -529,7 +529,7 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
>  =20
>   	thermal->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
>   	if (IS_ERR(thermal->pclk)) {
> -		error =3D PTR_ERR(thermal->clk);
> +		error =3D PTR_ERR(thermal->pclk);
Yeah, you are right.
Reviewed-by: Caesar Wang <wxt@rock-chips.com>

Thanks.

Caesar
>   		dev_err(&pdev->dev, "failed to get apb_pclk clock: %d\n",
>   			error);
>   		return error;
>
>
>

--=20
***********************************************************************=
***************
=E7=8E=8B=E6=99=93=E8=85=BE    Caesar Wang
Product R&D Dept.III
=46uzhou Rockchip Electronics Co.Ltd
Addr=EF=BC=9A  NO.18 Building, A District, Fuzhou Software Park,Gulou D=
istrict,Fuzhou, Fujian,China(Fuzhou Headquarters)
               21F,Malata Building,Kejizhongyi Avenue,Nanshan District,=
Shenzhen  (Shenzhen Office)
Tel=EF=BC=9A+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt@rock-chips.com
***********************************************************************=
****************
***********************************************************************=
****************
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., L=
td .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from=
 disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any=
 disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the send=
er as soon as possible and destroy the material
in its entirety in any format. Thank you.
***********************************************************************=
****************


