From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1 1/7] drivers: thermal: of-thermal: Print name of device node with error
Date: Wed, 09 Jan 2019 16:15:50 -0800
Message-ID: <154707935071.15366.2171988962628121832@swboyd.mtv.corp.google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org> <52c46a3a4fd1674295d9c2577be87d73ce545044.1547078153.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52c46a3a4fd1674295d9c2577be87d73ce545044.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-01-09 16:00:50)
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 4bfdb4a1e47d..5ca2a6b370ea 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device=
_node *np)
> =20
>         ret =3D of_property_read_u32(np, "polling-delay-passive", &prop);
>         if (ret < 0) {
> -               pr_err("missing polling-delay-passive property\n");
> +               pr_err("%s: missing polling-delay-passive property\n", np=
->name);

You should use %pOFn to print node names.
