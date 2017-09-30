From: Otavio Salvador <otavio.salvador@ossystems.com.br>
Subject: Re: [PATCH v2] cpufreq: imx6q: Move speed grading check to cpufreq driver
Date: Sat, 30 Sep 2017 11:36:06 -0300
Message-ID: <CAP9ODKpYB5gL4Ve==wcV=ApwdftjxpiXeFK3chO6q9Tm2wRweg@mail.gmail.com>
References: <1506773581-1226-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34001 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdI3OgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2017 10:36:10 -0400
Received: by mail-yw0-f193.google.com with SMTP id v72so1298458ywa.1
        for <linux-pm@vger.kernel.org>; Sat, 30 Sep 2017 07:36:10 -0700 (PDT)
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id q68sm2723453ywe.24.2017.09.30.07.36.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 07:36:08 -0700 (PDT)
Received: by mail-oi0-f42.google.com with SMTP id m198so1358999oig.13
        for <linux-pm@vger.kernel.org>; Sat, 30 Sep 2017 07:36:08 -0700 (PDT)
In-Reply-To: <1506773581-1226-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: vireshk@kernel.org, Nishanth Menon <nm@ti.com>, anson.huang@nxp.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, rjw@rjwysocki.net, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, shawnguo@kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Sep 30, 2017 at 9:13 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> On some i.MX6 SoCs (like i.MX6UL, i.MX6SX and i.MX6UL) that do not have

                                                    two UL ?

> speed grading check, opp table will not be created in platform code,
> so cpufreq driver prints the following error message:
>
> cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
>
> However, this is not really an error in this case because the
> imx6q-cpufreq driver first calls dev_pm_opp_get_opp_count()
> and if it fails, it means that platform code does not provide
> OPP and then dev_pm_opp_of_add_table() will be called.
>
> In order to avoid such confusing error message, move the speed grading
> check from platform code to the imx6q-cpufreq driver.
>
> This way the imx6q-cpufreq no longer has to check whether OPP table
> is supplied by platform code.
>
> Tested on a i.MX6Q and i.MX6UL based boards.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Previous discussion on this topic:
> https://patchwork.kernel.org/patch/9295059/
>
> Changes since v1:
> - Remove unneeded has_speed_grading() function.
>
>  arch/arm/mach-imx/mach-imx6q.c  | 88 +----------------------------------------
>  drivers/cpufreq/imx6q-cpufreq.c | 85 +++++++++++++++++++++++++++++----------
>  2 files changed, 67 insertions(+), 106 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 45801b2..b5f89fd 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -286,88 +286,6 @@ static void __init imx6q_init_machine(void)
>         imx6q_axi_init();
>  }
>
> -#define OCOTP_CFG3                     0x440
> -#define OCOTP_CFG3_SPEED_SHIFT         16
> -#define OCOTP_CFG3_SPEED_1P2GHZ                0x3
> -#define OCOTP_CFG3_SPEED_996MHZ                0x2
> -#define OCOTP_CFG3_SPEED_852MHZ                0x1
> -
> -static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
> -{
> -       struct device_node *np;
> -       void __iomem *base;
> -       u32 val;
> -
> -       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> -       if (!np) {
> -               pr_warn("failed to find ocotp node\n");
> -               return;
> -       }
> -
> -       base = of_iomap(np, 0);
> -       if (!base) {
> -               pr_warn("failed to map ocotp\n");
> -               goto put_node;
> -       }
> -
> -       /*
> -        * SPEED_GRADING[1:0] defines the max speed of ARM:
> -        * 2b'11: 1200000000Hz;
> -        * 2b'10: 996000000Hz;
> -        * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
> -        * 2b'00: 792000000Hz;
> -        * We need to set the max speed of ARM according to fuse map.
> -        */
> -       val = readl_relaxed(base + OCOTP_CFG3);
> -       val >>= OCOTP_CFG3_SPEED_SHIFT;
> -       val &= 0x3;
> -
> -       if ((val != OCOTP_CFG3_SPEED_1P2GHZ) && cpu_is_imx6q())
> -               if (dev_pm_opp_disable(cpu_dev, 1200000000))
> -                       pr_warn("failed to disable 1.2 GHz OPP\n");
> -       if (val < OCOTP_CFG3_SPEED_996MHZ)
> -               if (dev_pm_opp_disable(cpu_dev, 996000000))
> -                       pr_warn("failed to disable 996 MHz OPP\n");
> -       if (cpu_is_imx6q()) {
> -               if (val != OCOTP_CFG3_SPEED_852MHZ)
> -                       if (dev_pm_opp_disable(cpu_dev, 852000000))
> -                               pr_warn("failed to disable 852 MHz OPP\n");
> -       }
> -       iounmap(base);
> -put_node:
> -       of_node_put(np);
> -}
> -
> -static void __init imx6q_opp_init(void)
> -{
> -       struct device_node *np;
> -       struct device *cpu_dev = get_cpu_device(0);
> -
> -       if (!cpu_dev) {
> -               pr_warn("failed to get cpu0 device\n");
> -               return;
> -       }
> -       np = of_node_get(cpu_dev->of_node);
> -       if (!np) {
> -               pr_warn("failed to find cpu0 node\n");
> -               return;
> -       }
> -
> -       if (dev_pm_opp_of_add_table(cpu_dev)) {
> -               pr_warn("failed to init OPP table\n");
> -               goto put_node;
> -       }
> -
> -       imx6q_opp_check_speed_grading(cpu_dev);
> -
> -put_node:
> -       of_node_put(np);
> -}
> -
> -static struct platform_device imx6q_cpufreq_pdev = {
> -       .name = "imx6q-cpufreq",
> -};
> -
>  static void __init imx6q_init_late(void)
>  {
>         /*
> @@ -377,10 +295,8 @@ static void __init imx6q_init_late(void)
>         if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
>                 imx6q_cpuidle_init();
>
> -       if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
> -               imx6q_opp_init();
> -               platform_device_register(&imx6q_cpufreq_pdev);
> -       }
> +       if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> +               platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
>  }
>
>  static void __init imx6q_map_io(void)
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 14466a9..45d90e6 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> @@ -191,6 +192,57 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>         .suspend = cpufreq_generic_suspend,
>  };
>
> +#define OCOTP_CFG3                     0x440
> +#define OCOTP_CFG3_SPEED_SHIFT         16
> +#define OCOTP_CFG3_SPEED_1P2GHZ                0x3
> +#define OCOTP_CFG3_SPEED_996MHZ                0x2
> +#define OCOTP_CFG3_SPEED_852MHZ                0x1
> +
> +static void __init imx6q_opp_check_speed_grading(struct device *dev)
> +{
> +       struct device_node *np;
> +       void __iomem *base;
> +       u32 val;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> +       if (!np)
> +               return;
> +
> +       base = of_iomap(np, 0);
> +       if (!base) {
> +               dev_err(dev, "failed to map ocotp\n");
> +               goto put_node;
> +       }
> +
> +       /*
> +        * SPEED_GRADING[1:0] defines the max speed of ARM:
> +        * 2b'11: 1200000000Hz;
> +        * 2b'10: 996000000Hz;
> +        * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
> +        * 2b'00: 792000000Hz;
> +        * We need to set the max speed of ARM according to fuse map.
> +        */
> +       val = readl_relaxed(base + OCOTP_CFG3);
> +       val >>= OCOTP_CFG3_SPEED_SHIFT;
> +       val &= 0x3;
> +
> +       if ((val != OCOTP_CFG3_SPEED_1P2GHZ) &&
> +            of_machine_is_compatible("fsl,imx6q"))
> +               if (dev_pm_opp_disable(dev, 1200000000))
> +                       dev_warn(dev, "failed to disable 1.2GHz OPP\n");
> +       if (val < OCOTP_CFG3_SPEED_996MHZ)
> +               if (dev_pm_opp_disable(dev, 996000000))
> +                       dev_warn(dev, "failed to disable 996MHz OPP\n");
> +       if (of_machine_is_compatible("fsl,imx6q")) {
> +               if (val != OCOTP_CFG3_SPEED_852MHZ)
> +                       if (dev_pm_opp_disable(dev, 852000000))
> +                               dev_warn(dev, "failed to disable 852MHz OPP\n");
> +       }
> +       iounmap(base);
> +put_node:
> +       of_node_put(np);
> +}
> +
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  {
>         struct device_node *np;
> @@ -252,28 +304,21 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>                 goto put_reg;
>         }
>
> -       /*
> -        * We expect an OPP table supplied by platform.
> -        * Just, incase the platform did not supply the OPP
> -        * table, it will try to get it.
> -        */
> -       num = dev_pm_opp_get_opp_count(cpu_dev);
> -       if (num < 0) {
> -               ret = dev_pm_opp_of_add_table(cpu_dev);
> -               if (ret < 0) {
> -                       dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -                       goto put_reg;
> -               }
> +       ret = dev_pm_opp_of_add_table(cpu_dev);
> +       if (ret < 0) {
> +               dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> +               goto put_reg;
> +       }
>
> -               /* Because we have added the OPPs here, we must free them */
> -               free_opp = true;
> +       imx6q_opp_check_speed_grading(cpu_dev);
>
> -               num = dev_pm_opp_get_opp_count(cpu_dev);
> -               if (num < 0) {
> -                       ret = num;
> -                       dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> -                       goto out_free_opp;
> -               }
> +       /* Because we have added the OPPs here, we must free them */
> +       free_opp = true;
> +       num = dev_pm_opp_get_opp_count(cpu_dev);
> +       if (num < 0) {
> +               ret = num;
> +               dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> +               goto out_free_opp;
>         }
>
>         ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
