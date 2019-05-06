From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] drivers: thermal: processor_thermal: Downgrade error
 message
Date: Mon, 06 May 2019 20:50:20 +0800
Message-ID: <1557147020.2456.5.camel@intel.com>
References: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430034213.40028-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 一, 2019-04-29 at 20:42 -0700, Srinivas Pandruvada wrote:
> Downgrade "Unsupported event" message from dev_err to dev_dbg.
> Otherwise it
> floods with this message one some platforms.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c
> om>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2
> +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 4b206b594825..436c256f111d 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -275,7 +275,7 @@ static void proc_thermal_notify(acpi_handle
> handle, u32 event, void *data)
>  				THERMAL_DEVICE_POWER_CAPABILITY_CHAN
> GED);
>  		break;
>  	default:
> -		dev_err(proc_priv->dev, "Unsupported event
> [0x%x]\n", event);
> +		dev_dbg(proc_priv->dev, "Unsupported event
> [0x%x]\n", event);
>  		break;
>  	}
>  }

a similar patch has been applied, the only difference is that I'm using
dev_notice instead.
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=3c7110fab805766450c5d2eac1c994d4c8c230d3

thanks,
rui
