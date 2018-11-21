From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
Date: Wed, 21 Nov 2018 09:24:18 +0530
Message-ID: <CAOh2x==PecS4OzoX3UagBE0RjQL-0BBC=r=MAaO3cA2MczrA=A@mail.gmail.com>
References: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: anson.huang@nxp.com
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, l.stach@pengutronix.de, linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 8:11 AM Anson Huang <anson.huang@nxp.com> wrote:

> @@ -830,8 +851,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  clk_disable:
>         clk_disable_unprepare(data->thermal_clk);
>  cpufreq_put:

While at it, rename this label as well to something like legacy_cleanup.

> -       cpufreq_cooling_unregister(data->cdev);
> -       cpufreq_cpu_put(data->policy);
> +       imx_thermal_unregister_legacy_cooling(data);
>
>         return ret;
>  }
