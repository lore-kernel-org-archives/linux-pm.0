From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Tue, 27 Feb 2018 09:44:40 +0100
Message-ID: <1519721080.3402.6.camel@pengutronix.de>
References: <1517595466-23465-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1517595466-23465-1-git-send-email-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, rui.zhang@intel.com
Cc: edubezval@gmail.com, mikhail.lappo@esrlabs.com, linux-pm@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-02-02 at 16:17 -0200, Fabio Estevam wrote:
> From: Mikhail Lappo <mikhail.lappo@esrlabs.com>
> 
> When device boots with T > T_trip_1 and requests interrupt,
> the race condition takes place. The interrupt comes before
> THERMAL_DEVICE_ENABLED is set. This leads to an attempt to
> reading sensor value from irq and disabling the sensor, based on
> the data->mode field, which expected to be THERMAL_DEVICE_ENABLED,
> but still stays as THERMAL_DEVICE_DISABLED. Afher this issue
> sensor is never re-enabled, as the driver state is wrong.
> 
> Fix this problem by setting the 'data' members prior to
> requesting the interrupts.
> 
> Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm interrupt handling")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
