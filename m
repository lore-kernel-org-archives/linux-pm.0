From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/5] PM / devfreq: make event/exynos-ppmu
 DEVFREQ_EVENT_EXYNOS_PPMU tristate
Date: Mon, 27 Jun 2016 11:29:31 +0900
Message-ID: <57708F8B.4090103@samsung.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
 <CGME20160625184441epcas1p25817568c27e8c8bee8dee44a973e4176@epcas1p2.samsung.com>
 <20160625184351.5045-6-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20160625184351.5045-6-paul.gortmaker@windriver.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Paul,

On 2016=EB=85=84 06=EC=9B=94 26=EC=9D=BC 03:43, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> config DEVFREQ_EVENT_EXYNOS_PPMU
>   bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ ev=
ent Driver"
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
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/devfreq/event/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kc=
onfig
> index 96ea29d1ede5..eb6f74a2b6b9 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -22,7 +22,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>  	  (Network on Chip) Probe counters to measure the bandwidth of AXI =
bus.
> =20
>  config DEVFREQ_EVENT_EXYNOS_PPMU
> -	bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ ev=
ent Driver"
> +	tristate "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFRE=
Q event Driver"
>  	depends on ARCH_EXYNOS
>  	select PM_OPP
>  	help
>=20

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi
