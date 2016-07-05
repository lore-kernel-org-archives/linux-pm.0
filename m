From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [RESEND PATCH] thermal: helpers: Check return value of get_temp
Date: Tue, 5 Jul 2016 12:22:47 -0400
Message-ID: <7cf6dc8c-d914-d978-8550-440717bd9b77@nvidia.com>
References: <1465232019-12441-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465232019-12441-1-git-send-email-rklein@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6/6/2016 12:53 PM, Rhyland Klein wrote:
> Check the return value of get_temp, which can fail. If it does, then
> unlock and return the error code.
> 
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> ---
>  drivers/thermal/thermal_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 5e1c160944c9..dc260749f8d6 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -90,6 +90,10 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  	mutex_lock(&tz->lock);
>  
>  	ret = tz->ops->get_temp(tz, temp);
> +	if (!ret) {
> +		mutex_unlock(&tz->lock);
> +		goto exit;
> +	}
>  
>  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
>  		for (count = 0; count < tz->trips; count++) {
> 

I haven't seen any comments on this patch, has anyone had a chance to
review it yet?

-rhyland

-- 
nvpublic
