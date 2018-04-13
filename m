From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 10:50:43 +0200
Message-ID: <3639670.ds6gqUTXoT@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413040901epcas4p1c3c515567fb6ab613c018cd7229c4bd4@epcas4p1.samsung.com>
        <20180413040855.GA29826@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180413040855.GA29826@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org


On Thursday, April 12, 2018 09:08:57 PM Eduardo Valentin wrote:
> Hello,

Hi,

> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > could you please illustrate me what the kconfig & warning is?
> > 
> > Just "make allmodconfig" and the warning is about a uninitialized variable.
> > 
> > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell history
> > is to be believed.
> > 
> >                 Linus
> 
> Yeah, this has also passed my local compilation error. Somehow my gcc4.9
> is not catching it. Using an older gcc (gcc4.6) does catch it.
> 
> Anyways, given that the conversion functions are written to cover
> for unexpected cal_type, the right way of fixing this is to rewrite
> the conversion functions to allow for returning error codes and
> adjusting the callers as expected.
> 
> Rui, bzolnier, please consider the following fix:
> 
> From 2aaf94f80c0021a21b4122c9f4197acff08ea398 Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <edubezval@gmail.com>
> Date: Thu, 12 Apr 2018 21:00:48 -0700
> Subject: [PATCH 1/1] thermal: exynos: fix compilation warning around
>  conversion functions
> 
> In order to fix the warns:
> drivers/thermal/samsung/exynos_tmu.c:931:37: warning: 'temp' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/thermal/samsung/exynos_tmu.c:304:9: warning: 'temp_code' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> the conversion functions should allow return error codes
> and the not mix the converted value with error code.
> 
> This patch change the conversion functions to return
> error code or success and adjusts the callers accordingly.
> 
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 120 ++++++++++++++++++++++++-----------
>  1 file changed, 84 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2ec8548..b3f0704 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -282,52 +282,54 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
>   * TMU treats temperature as a mapped temperature code.
>   * The temperature is converted differently depending on the calibration type.
>   */
> -static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
> +static int temp_to_code(struct exynos_tmu_data *data, u8 temp, int *temp_code)
>  {
> -	int temp_code;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
> +		*temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
>  			(data->temp_error2 - data->temp_error1) /
>  			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
>  			data->temp_error1;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> +		*temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:

Since this condition cannot happen (the driver makes sure of this during
probe) I would prefer much simpler fix from Arnd:

https://patchwork.kernel.org/patch/10313313/

(I've already ACKed it two weeks ago).

>  		WARN_ON(1);
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -	return temp_code;
> +	return ret;
>  }
>  
>  /*
>   * Calculate a temperature value from a temperature code.
>   * The unit of the temperature is degree Celsius.
>   */
> -static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> +static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code, int *temp)
>  {
> -	int temp;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp = (temp_code - data->temp_error1) *
> +		*temp = (temp_code - data->temp_error1) *
>  			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
>  			(data->temp_error2 - data->temp_error1) +
>  			EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> +		*temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:
>  		WARN_ON(1);
> +		ret = -EINVAL;

ditto

>  		break;
>  	}
>  
> -	return temp;
> +	return ret;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
