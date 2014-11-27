From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 27 Nov 2014 10:44:23 +0200
Message-ID: <1417077863.10282.3.camel@mm-sol.com>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
	 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,=20

On Wed, 2014-11-26 at 22:24 -0700, Lina Iyer wrote:
>=20

>  - compatible:
> @@ -14,10 +23,13 @@ PROPERTIES
>         Value type: <string>
>         Definition: shall contain "qcom,saw2". A more specific value =
should be
>                                                 one of:

Which driver is supposed to handle this property?

> -                               "qcom,saw2-v1"
> -                               "qcom,saw2-v1.1"
> -                               "qcom,saw2-v2"
> -                               "qcom,saw2-v2.1"
> +                       "qcom,saw2-v1"
> +                       "qcom,saw2-v1.1"
> +                       "qcom,saw2-v2"
> +                       "qcom,saw2-v2.1"

Doesn't seems to be used or supported?

> +                       "qcom,apq8064-saw2-v1.1-cpu"
> +                       "qcom,msm8974-saw2-v2.1-cpu"
> +                       "qcom,apq8084-saw2-v2.1-cpu"
>=20

<snip>

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator@2099000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power-controller@2099000 {
>                 compatible =3D "qcom,saw2";
>                 reg =3D <0x02099000 0x1000>, <0x02009000 0x1000>;
> +               regulator;
>=20

<snip>

> +static const struct of_device_id spm_match_table[] =3D {
> +       { .compatible =3D "qcom,msm8974-saw2-v2.1-cpu",
> +                       .data =3D &spm_reg_8974_8084_cpu },
> +       { .compatible =3D "qcom,apq8084-saw2-v2.1-cpu",
> +                       .data =3D &spm_reg_8974_8084_cpu },
> +       { .compatible =3D "qcom,apq8064-saw2-v1.1-cpu",
> +                       .data =3D &spm_reg_8064_cpu },
> +       { },
> +};
> +

Regards,
Ivan
