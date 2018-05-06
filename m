From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: tegra: soctherm: add const to struct
 thermal_cooling_device_ops
Date: Sun, 6 May 2018 15:50:45 -0700
Message-ID: <20180506225044.GA25956@localhost.localdomain>
References: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srplinux2008 <srplinux2008@gmail.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 08, 2018 at 05:31:45PM +0530, srplinux2008 wrote:
> From: srp linux <srplinux2008@gmail.com>
> 
> Correct the typecast with const to struct thermal_cooling_device_ops.
> It is the last argument to the function thermal_of_cooling_device_register
> and this argument is of type const. So, declare this structure
> thermal_cooling_device_ops as constant.
> 
> Signed-off-by: srp linux <srplinux2008@gmail.com>

Please resend with your real name.

Thanks

> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 455b58c..72da745 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -926,7 +926,7 @@ static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
>  	return 0;
>  }
>  
> -static struct thermal_cooling_device_ops throt_cooling_ops = {
> +static const struct thermal_cooling_device_ops throt_cooling_ops = {
>  	.get_max_state = throt_get_cdev_max_state,
>  	.get_cur_state = throt_get_cdev_cur_state,
>  	.set_cur_state = throt_set_cdev_state,
> -- 
> 2.7.4
> 
