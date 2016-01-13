From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: use %d to print S32 parameters
Date: Wed, 13 Jan 2016 09:22:16 +0000
Message-ID: <20160113092216.GB2594@e104805>
References: <1452674036-14907-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452674036-14907-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 13, 2016 at 04:33:56PM +0800, Leo Yan wrote:
> Power allocator's parameters are S32 type, so use %d to print them.

Indeed.  The name of the macro is create_s32_tzp_attr(), it's
explicitly saying that the parameter is signed!

> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Javi Merino <javi.merino@arm.com>

Cheers,
Javi

> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9e525c..1335df2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -931,7 +931,7 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
>  									\
>  	if (tz->tzp)							\
> -		return sprintf(buf, "%u\n", tz->tzp->name);		\
> +		return sprintf(buf, "%d\n", tz->tzp->name);		\
>  	else								\
>  		return -EIO;						\
>  	}								\
> -- 
> 1.9.1
> 
