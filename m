From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 4/4] thermal: imx: update to new formula according to
 NXP AN5215
Date: Mon, 27 Nov 2017 20:41:13 +0200
Message-ID: <1511808073.20123.33.camel@nxp.com>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
         <20171121200225.23316-5-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0066.outbound.protection.outlook.com ([104.47.37.66]:2265
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753062AbdK0SlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 13:41:18 -0500
In-Reply-To: <20171121200225.23316-5-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>

On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> According to an application note from 03/2017 there is an updated formula to
> calculate the temperature that better matches reality. This is implemented here.
> 
> While updating move the magic constants from cpp defines which are far above the
> explaining formula to constants in the code just under the explaining comment.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/thermal/imx_thermal.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index b24aa6cfebbf..95116475ac98 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -70,10 +70,6 @@ enum imx_thermal_trip {
>  #define IMX_POLLING_DELAY		2000 /* millisecond */
>  #define IMX_PASSIVE_DELAY		1000
>  
> -#define FACTOR0				10000000
> -#define FACTOR1				15976
> -#define FACTOR2				4297157
> -
>  #define TEMPMON_IMX6Q			1
>  #define TEMPMON_IMX6SX			2
>  
> @@ -350,7 +346,7 @@ static struct thermal_zone_device_ops imx_tz_ops = {
>  static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> -	int t1, n1;
> +	int n1;
>  	u64 temp64;
>  
>  	if (ocotp_ana1 == 0 || ocotp_ana1 == ~0) {
> @@ -365,25 +361,25 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>  	 * To find the actual temperature T, the following formula has to be used
>  	 * when reading value n from the sensor:
>  	 *
> -	 * T = T1 + (N - N1) / (0.4297157 - 0.0015976 * N1) °C
> -	 *   = [T1 - N1 / (0.4297157 - 0.0015976 * N1) °C] + N / (0.4297157 - 0.0015976 * N1) °C
> -	 *   = [T1 + N1 / (0.0015976 * N1 - 0.4297157) °C] - N / (0.0015976 * N1 - 0.4297157) °C
> +	 * T = T1 + (N - N1) / (0.4148468 - 0.0015423 * N1) °C + 3.580661 °C
> +	 *   = [T1' - N1 / (0.4148468 - 0.0015423 * N1) °C] + N / (0.4148468 - 0.0015423 * N1) °C
> +	 *   = [T1' + N1 / (0.0015423 * N1 - 0.4148468) °C] - N / (0.0015423 * N1 - 0.4148468) °C
>  	 *   = c2 - c1 * N
>  	 *
>  	 * with
>  	 *
> -	 *   c1 = 1 / (0.0015976 * N1 - 0.4297157) °C
> -	 *   c2 = T1 + N1 / (0.0015976 * N1 - 0.4297157) °C
> -	 *      = T1 + N1 * C1
> +	 *  T1' = 28.580661 °C
> +	 *   c1 = 1 / (0.0015423 * N1 - 0.4297157) °C
> +	 *   c2 = T1' + N1 / (0.0015423 * N1 - 0.4148468) °C
> +	 *      = T1' + N1 * c1
>  	 */
>  	n1 = ocotp_ana1 >> 20;
> -	t1 = 25; /* °C */
>  
> -	temp64 = FACTOR0; /* 10^7 for FACTOR1 and FACTOR2 */
> +	temp64 = 10000000; /* use 10^7 as fixed point constant for values in formula */
>  	temp64 *= 1000; /* to get result in °mC */
> -	do_div(temp64, FACTOR1 * n1 - FACTOR2);
> +	do_div(temp64, 15423 * n1 - 4148468);
>  	data->c1 = temp64;
> -	data->c2 = n1 * data->c1 + 1000 * t1;
> +	data->c2 = n1 * data->c1 + 28581;

The freescale tree contains a slightly modified version of this driver
which already includes the new formula. Source here:

http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/tree/drivers/thermal/imx_thermal.c?h=imx_4.9.11_1.0.0_ga#n540

Your code looks different (and nicer!) but the math seems the same.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
