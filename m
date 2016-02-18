From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: exynos: Document number of supported
 trip-points
Date: Thu, 18 Feb 2016 14:21:32 +0900
Message-ID: <56C554DC.1040104@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
 <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1455772460-20684-2-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 02=EC=9B=94 18=EC=9D=BC 14:14, Krzysztof Kozlowski wro=
te:
> Document the number of configurable temperature thresholds (for
> trip-points in interrupt-driven mode).
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 +++=
+++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal=
=2Etxt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index 34315d7fbfde..faa62059b5c5 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -44,6 +44,14 @@
>  - vtmu-supply: This entry is optional and provides the regulator nod=
e supplying
>  		voltage to TMU. If needed this entry can be placed inside
>  		board/platform specific dts file.
> +
> +The Exynos TMU supports generating interrupts when reaching given
> +temperature thresholds. Number of supported thermal trip points depe=
nds
> +on the SoC (only first trip points defined in DT will be configured)=
:
> + - most of SoC: 4
> + - samsung,exynos5433-tmu: 8
> + - samsung,exynos7-tmu: 8
> +
>  Following properties are mandatory (depending on SoC):
>  - samsung,tmu_gain: Gain value for internal TMU operation.
>  - samsung,tmu_reference_voltage: Value of TMU IP block's reference v=
oltage
>=20

Exynos5433 has the 8 interrupt for thermal. Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best Regards,
Chanwoo Choi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
