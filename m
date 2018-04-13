From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal/drivers/exynos_tmu: Fix warnings in
 temp_to_code / code_to_temp
Date: Fri, 13 Apr 2018 13:08:35 +0200
Message-ID: <11044079.DdDvlFD91s@amdc3058>
References: <10298074.ogKH1ypqfx@amdc3058>
        <CGME20180413110032epcas4p3e0ef781eecb771b1294b7992d2ee6e6d@epcas4p3.samsung.com>
        <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, philip.li@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 01:00:09 PM Daniel Lezcano wrote:
> The latest driver cleanup introduced a compilation warning
>=20
>  drivers/thermal/samsung/exynos_tmu.c: In function =E2=80=98exynos_ge=
t_temp=E2=80=99:
>  drivers/thermal/samsung/exynos_tmu.c:931:37: warning: =E2=80=98temp=E2=
=80=99 may be used uninitialized in this function [-Wmaybe-uninitialize=
d]
>    *temp =3D code_to_temp(data, value) * MCELSIUS;
>                                         ^
>=20
>  drivers/thermal/samsung/exynos_tmu.c: In function =E2=80=98temp_to_c=
ode=E2=80=99
>  drivers/thermal/samsung/exynos_tmu.c:304:9: warning: =E2=80=98temp_c=
ode=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninit=
ialized]
> =09=09=09=09=09  return temp_code;
> =09=09=09=09=09           ^~~~~~~~~
>=20
> The compiler gives a warning because semantically speaking the
> function has no default value. However the code path, were the
> variable is never initialized is a dead branch because the switch
> statement always choose one of the two cases as the data->cal_type is=

> initialized in the init function to one of both values.
>=20
> This is unclear as it adds a dependency on the initialization functio=
n
> and it is prone to error. Make things clearer by converting the
> functions with if ... return statements, thus showing we are expectin=
g
> the values to be correctly filled before calling this function.
>=20
> This change fixes the couple of function warnings.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel, this is much better fix.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 46 ++++++++++----------------=
----------
>  1 file changed, 12 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/s=
amsung/exynos_tmu.c
> index 2ec8548..197f267 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -284,24 +284,13 @@ static void exynos_report_trigger(struct exynos=
_tmu_data *p)
>   */
>  static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>  {
> -=09int temp_code;
> -
> -=09switch (data->cal_type) {
> -=09case TYPE_TWO_POINT_TRIMMING:
> -=09=09temp_code =3D (temp - EXYNOS_FIRST_POINT_TRIM) *
> -=09=09=09(data->temp_error2 - data->temp_error1) /
> -=09=09=09(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> -=09=09=09data->temp_error1;
> -=09=09break;
> -=09case TYPE_ONE_POINT_TRIMMING:
> -=09=09temp_code =3D temp + data->temp_error1 - EXYNOS_FIRST_POINT_TR=
IM;
> -=09=09break;
> -=09default:
> -=09=09WARN_ON(1);
> -=09=09break;
> -=09}
> +=09if (data->cal_type =3D=3D TYPE_ONE_POINT_TRIMMING)
> +=09=09return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> =20
> -=09return temp_code;
> +=09return (temp - EXYNOS_FIRST_POINT_TRIM) *
> +=09=09(data->temp_error2 - data->temp_error1) /
> +=09=09(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> +=09=09data->temp_error1;
>  }
> =20
>  /*
> @@ -310,24 +299,13 @@ static int temp_to_code(struct exynos_tmu_data =
*data, u8 temp)
>   */
>  static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)=

>  {
> -=09int temp;
> -
> -=09switch (data->cal_type) {
> -=09case TYPE_TWO_POINT_TRIMMING:
> -=09=09temp =3D (temp_code - data->temp_error1) *
> -=09=09=09(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> -=09=09=09(data->temp_error2 - data->temp_error1) +
> -=09=09=09EXYNOS_FIRST_POINT_TRIM;
> -=09=09break;
> -=09case TYPE_ONE_POINT_TRIMMING:
> -=09=09temp =3D temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TR=
IM;
> -=09=09break;
> -=09default:
> -=09=09WARN_ON(1);
> -=09=09break;
> -=09}
> +=09if (data->cal_type =3D=3D TYPE_ONE_POINT_TRIMMING)
> +=09=09return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM=
;
> =20
> -=09return temp;
> +=09return (temp_code - data->temp_error1) *
> +=09=09(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> +=09=09(data->temp_error2 - data->temp_error1) +
> +=09=09EXYNOS_FIRST_POINT_TRIM;
>  }
> =20
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 tr=
im_info)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
