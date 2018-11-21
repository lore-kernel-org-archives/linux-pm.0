From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/2] thermal: imx: fix for dependency on cpu-freq
Date: Wed, 21 Nov 2018 11:23:15 +0530
Message-ID: <20181121055315.cq5svzmddaavw3su@vireshk-i7>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 05:49, Anson Huang wrote:
> The thermal driver is a standalone driver for monitoring SoC temperature
> by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
> is NOT set. So remove the dependency with CPU_THERMAL.
> 
> Introduce dummy function of legacy cooling register/unregister to make
> thermal driver probe successfully when CONFIG_CPU_FREQ is NOT set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/Kconfig       |  2 +-
>  drivers/thermal/imx_thermal.c | 47 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 36 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
