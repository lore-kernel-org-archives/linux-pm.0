From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v7 11/11] clk: rockchip: add restart handler
Date: Wed, 03 Sep 2014 12:05:42 -0700
Message-ID: <20140903190542.11368.20755@quantum>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-12-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1408495538-27480-12-git-send-email-linux@roeck-us.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, Jonas Jensen <jonas.jensen@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Quoting Guenter Roeck (2014-08-19 17:45:38)
> From: Heiko St=C3=BCbner <heiko@sntech.de>
>=20
> Add infrastructure to write the correct value to the restart register=
 and
> register the restart notifier for both rk3188 (including rk3066) and =
rk3288.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> v7: Added patch to series.
>=20
>  drivers/clk/rockchip/clk-rk3188.c |  2 ++
>  drivers/clk/rockchip/clk-rk3288.c |  2 ++
>  drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  4 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip=
/clk-rk3188.c
> index a83a6d8..71b661a 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -631,6 +631,8 @@ static void __init rk3188_common_clk_init(struct =
device_node *np)
> =20
>         rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CO=
N(0),
>                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +       rockchip_register_restart_notifier(RK2928_GLB_SRST_FST);
>  }
> =20
>  static void __init rk3066a_clk_init(struct device_node *np)
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip=
/clk-rk3288.c
> index 0d8c6c5..b604217 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -713,5 +713,7 @@ static void __init rk3288_clk_init(struct device_=
node *np)
> =20
>         rockchip_register_softrst(np, 9, reg_base + RK3288_SOFTRST_CO=
N(0),
>                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +       rockchip_register_restart_notifier(RK3288_GLB_SRST_FST);
>  }
>  CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 278cf9d..aa41433 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -25,6 +25,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/reboot.h>
>  #include "clk.h"
> =20
>  /**
> @@ -242,3 +243,27 @@ void __init rockchip_clk_register_branches(
>                 rockchip_clk_add_lookup(clk, list->id);
>         }
>  }
> +
> +static unsigned int reg_restart;
> +static int rockchip_restart_notify(struct notifier_block *this,
> +                                  unsigned long mode, void *cmd)
> +{
> +       writel(0xfdb9, reg_base + reg_restart);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rockchip_restart_handler =3D {
> +       .notifier_call =3D rockchip_restart_notify,
> +       .priority =3D 128,
> +};
> +
> +void __init rockchip_register_restart_notifier(unsigned int reg)
> +{
> +       int ret;
> +
> +       reg_restart =3D reg;
> +       ret =3D register_restart_handler(&rockchip_restart_handler);
> +       if (ret)
> +               pr_err("%s: cannot register restart handler, %d\n",
> +                      __func__, ret);
> +}
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 887cbde..0b5eab5 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -329,6 +329,7 @@ void rockchip_clk_register_branches(struct rockch=
ip_clk_branch *clk_list,
>                                     unsigned int nr_clk);
>  void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
>                                 unsigned int nr_pll, int grf_lock_off=
set);
> +void rockchip_register_restart_notifier(unsigned int reg);
> =20
>  #define ROCKCHIP_SOFTRST_HIWORD_MASK   BIT(0)
> =20
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
