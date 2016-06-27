From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/5] PM / devfreq: make exynos-bus ARM_EXYNOS_BUS_DEVFREQ
 tristate
Date: Mon, 27 Jun 2016 11:28:37 +0900
Message-ID: <57708F55.709@samsung.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
 <CGME20160625184439epcas1p20feca9e044f2d818a82098917f9b8b4c@epcas1p2.samsung.com>
 <20160625184351.5045-4-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53496 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbcF0C2k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2016 22:28:40 -0400
In-reply-to: <20160625184351.5045-4-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi Paul,

On 2016=EB=85=84 06=EC=9B=94 26=EC=9D=BC 03:43, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> devfreq/Kconfig:config ARM_EXYNOS_BUS_DEVFREQ
> devfreq/Kconfig:        bool "ARM EXYNOS Generic Memory Bus DEVFREQ D=
river"
>=20
> ...meaning that it currently is not being built as a module by anyone=
=2E
>=20
> Rather than rip out the existing modular code, Chanwoo indicated
> that he'd rather see the driver offered as tristate.
>=20
> I don't have the hardware for runtime validation, so this change
> is only validated for compile and modpost.
>=20
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/devfreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 78dac0e9da11..a5be56ec57f2 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -75,7 +75,7 @@ config DEVFREQ_GOV_PASSIVE
>  comment "DEVFREQ Drivers"
> =20
>  config ARM_EXYNOS_BUS_DEVFREQ
> -	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
> +	tristate "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
>  	depends on ARCH_EXYNOS
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_PASSIVE
>=20

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi

