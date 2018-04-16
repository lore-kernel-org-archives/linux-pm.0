From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 14:49:55 +0200
Message-ID: <21168314.MLeXVVoknU@amdc3058>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <6993557.YT37RIp4lG@amdc3058>
        <22d7f063-9a69-78cf-e0fd-2043e187244e@linaro.org>
        <CGME20180416124956eucas1p17636602f59e7ad83088253ed369e7894@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22d7f063-9a69-78cf-e0fd-2043e187244e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Monday, April 16, 2018 02:41:48 PM Daniel Lezcano wrote:
> On 16/04/2018 14:35, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 16, 2018 02:16:56 PM Daniel Lezcano wrote:
> >> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> >>> From: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>
> >>> tmu_read() in case of Exynos4210 might return error for out of bound
> >>> values. Current code ignores such value, what leads to reporting critical
> >>> temperature value. Add proper error code propagation to exynos_get_temp()
> >>> function.
> >>
> >> For me the comment in the function exynos4210_tmu_read
> >>
> >> /* "temp_code" should range between 75 and 175 */
> >>
> >> ... is strange. I would double check this assertion before dealing with
> >> the error value.
> > 
> > static int exynos4210_tmu_read(struct exynos_tmu_data *data)
> > {
> > 	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
> > 
> > 	/* "temp_code" should range between 75 and 175 */
> > 	return (ret < 75 || ret > 175) ? -ENODATA : ret;
> > }
> > 
> 
> But I don't get why it *should* ?

Because of hardware design.

> Shouldn't be the same with the 4412, it seems having the same sensor, no?

Probably same limitations apply to all SoCs (Exynos4412 has very similar
sensor) but the driver currently lacks the needed checks for them (it is
on TODO but other things have higher priority).

> > The value returned by Exynos4210 hardware should be > 75 && < 175 and
> > it is later used as the "temp_code" parameter for code_to_temp():
> > 
> > static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> > {
> > 	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> > 		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> > 
> > 	return (temp_code - data->temp_error1) *
> > 		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> > 		(data->temp_error2 - data->temp_error1) +
> > 		EXYNOS_FIRST_POINT_TRIM;
> > }
> > 
> > so after the current fix the code finally matches the comment.
> > 
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> CC: stable@vger.kernel.org # v4.6+
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> ---
> >>>  drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
> >>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> >>> index 986cbd0..ac83f72 100644
> >>> --- a/drivers/thermal/samsung/exynos_tmu.c
> >>> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >>> @@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
> >>>  static int exynos_get_temp(void *p, int *temp)
> >>>  {
> >>>  	struct exynos_tmu_data *data = p;
> >>> +	int value, ret = 0;
> >>>  
> >>>  	if (!data || !data->tmu_read || !data->enabled)
> >>>  		return -EINVAL;
> >>> @@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
> >>>  	mutex_lock(&data->lock);
> >>>  	clk_enable(data->clk);
> >>>  
> >>> -	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
> >>> +	value = data->tmu_read(data);
> >>> +	if (value < 0)
> >>> +		ret = value;
> >>> +	else
> >>> +		*temp = code_to_temp(data, value) * MCELSIUS;
> >>>  
> >>>  	clk_disable(data->clk);
> >>>  	mutex_unlock(&data->lock);
> >>>  
> >>> -	return 0;
> >>> +	return ret;
> >>>  }
> >>>  
> >>>  #ifdef CONFIG_THERMAL_EMULATION

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
