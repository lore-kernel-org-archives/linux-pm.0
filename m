From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: int3400_thermal: Ignore Unknown Notification
 Codes
Date: Wed, 27 Dec 2017 10:15:25 +0800
Message-ID: <1514340925.2755.7.camel@intel.com>
References: <1510680996-25468-1-git-send-email-brian.bian@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:7693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbdL0CP7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 21:15:59 -0500
In-Reply-To: <1510680996-25468-1-git-send-email-brian.bian@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Bian <brian.bian@linux.intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 2017-11-14 at 10:36 -0700, Brian Bian wrote:
> Some BIOS implementations route ACPI codes other than 0x83 to INT3400
> device. Ignore these ACPI notification codes because the INT3400
> driver
> does not handle them.
> 
> Signed-off-by: Brian Bian <brian.bian@linux.intel.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index 8ee38f5..c9db1c6 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -211,7 +211,7 @@ static void int3400_notify(acpi_handle handle,
>  				thermal_prop);
>  		break;
>  	default:
> -		dev_err(&priv->adev->dev, "Unsupported event
> [0x%x]\n", event);
> +		/* Ignore unknown notification codes sent to INT3400
> device */
>  		break;
>  	}
>  }
