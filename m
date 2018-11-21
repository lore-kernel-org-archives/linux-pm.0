From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Date: Wed, 21 Nov 2018 10:53:18 +0530
Message-ID: <20181121052318.ctenjncvdtvneynl@vireshk-i7>
References: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 05:08, Anson Huang wrote:
> +static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
> +{
> +	cpufreq_cooling_unregister(data->cdev);
> +	cpufreq_cpu_put(data->policy);
> +}
> +#else
> +static inline int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
> +{
> +	return 0;
> +}

And now that you are going to send V5, please add a blank line before
and after #else here.

-- 
viresh
