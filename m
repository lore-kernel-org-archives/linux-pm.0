From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Document compatible for Exynos5433 TMU
Date: Thu, 18 Feb 2016 14:20:12 +0900
Message-ID: <56C5548C.7090305@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 02=EC=9B=94 18=EC=9D=BC 14:14, Krzysztof Kozlowski wro=
te:
> Commit 488c7455d74c ("thermal: exynos: Add the support for Exynos5433
> TMU") added new compatible but forgot to update documentation.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal=
=2Etxt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index 695150a4136b..34315d7fbfde 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -11,6 +11,7 @@
>  	       "samsung,exynos5420-tmu" for TMU channel 0, 1 on Exynos5420
>  	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 =
and 4
>  			Exynos5420 (Must pass triminfo base and triminfo clock)
> +               "samsung,exynos5433-tmu"
>  	       "samsung,exynos5440-tmu"
>  	       "samsung,exynos7-tmu"
>  - interrupt-parent : The phandle for the interrupt controller
>=20

I was implementing the Exynos5433's thermal driver. Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
