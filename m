From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
Date: Tue, 20 Nov 2018 16:18:43 +0530
Message-ID: <CAOh2x=kwGUto-TMsQORtx0CkgZSDsq6Mg1e=QKL=LeDPWJ=NPQ@mail.gmail.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: anson.huang@nxp.com
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

While I am aligned with the fact that we need to carry this code for backward
compatibility, there are few things I would suggest to improve.

On Wed, Oct 24, 2018 at 12:10 PM Anson Huang <anson.huang@nxp.com> wrote:
>  static int imx_thermal_probe(struct platform_device *pdev)
>  {
> @@ -743,6 +745,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>         regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
>                      data->socdata->power_down_mask);
>
> +#ifdef CONFIG_CPU_FREQ
>         data->policy = cpufreq_cpu_get(0);
>         if (!data->policy) {
>                 pr_debug("%s: CPUFreq policy not found\n", __func__);
> @@ -755,6 +758,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>                         "failed to register cpufreq cooling device: %d\n", ret);
>                 return ret;
>         }
> +#endif
>
>         data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(data->thermal_clk)) {

You missed the error handling code which unregisters cooling/cpufreq stuff.

And it would be better to write things in a somewhat better way, like this:

#ifdef CONFIG_CPU_FREQ

static int imx_thermal_register_legacy_cooling(...)
{
        ... current function body
}

static void imx_thermal_unregister_legacy_cooling(...)
{
        new routine body to unregister things
}

#else
static inline  int imx_thermal_register_legacy_cooling(...)
{
        return 0;
}

static void imx_thermal_unregister_legacy_cooling(...) { }

#endif


And then you can get rid of ifdef hackery in the middle of probe().
