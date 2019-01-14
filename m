From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device node with error
Date: Mon, 14 Jan 2019 15:54:32 -0800
Message-ID: <154751007298.169631.16954120258961808334@swboyd.mtv.corp.google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:04)
> Make it easier to debug devicetree definition in case of errors.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 4bfdb4a1e47d..08c3ccbdacf8 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device=
_node *np)
> =20
>         ret =3D of_property_read_u32(np, "polling-delay-passive", &prop);
>         if (ret < 0) {
> -               pr_err("missing polling-delay-passive property\n");
> +               pr_err("%pOFn: missing polling-delay-passive property\n",=
 np->name);

Not sure you've triggered this code path because it's an error, but I'd
expect it to just be np, not np->name here. It's too bad the compiler
can't catch this.
