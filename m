From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] thermal: exynos: fix register read in TMU
Date: Fri, 02 Oct 2015 09:03:32 +0900
Message-ID: <560DC9D4.2000301@samsung.com>
References: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59943 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJBADf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 20:03:35 -0400
In-reply-to: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015=EB=85=84 10=EC=9B=94 01=EC=9D=BC 20:39, Sudip Mukherjee wrote:
> The value of emul_con was getting overwritten if the selected soc is
> SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wron=
g
> register in the case of SOC_ARCH_EXYNOS5260.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/s=
amsung/exynos_tmu.c
> index 0bae8cc..ca920b0 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -932,7 +932,7 @@ static void exynos4412_tmu_set_emulation(struct e=
xynos_tmu_data *data,
> =20
>  	if (data->soc =3D=3D SOC_ARCH_EXYNOS5260)
>  		emul_con =3D EXYNOS5260_EMUL_CON;
> -	if (data->soc =3D=3D SOC_ARCH_EXYNOS5433)
> +	else if (data->soc =3D=3D SOC_ARCH_EXYNOS5433)
>  		emul_con =3D EXYNOS5433_TMU_EMUL_CON;
>  	else if (data->soc =3D=3D SOC_ARCH_EXYNOS7)
>  		emul_con =3D EXYNOS7_TMU_REG_EMUL_CON;
>=20

Thanks for your point out. Looks good to me.=20

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
