From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] Thermal: Fix Step-wise governor Kconfig help text
Date: Thu, 10 Oct 2013 08:55:11 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301185773@SHSMSX101.ccr.corp.intel.com>
References: <1381308587-25460-1-git-send-email-aricart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381308587-25460-1-git-send-email-aricart@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abelardo Ricart <aricart@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "trivial@kernel.org" <trivial@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Abelardo,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Abelardo Ricart
> Sent: Wednesday, October 09, 2013 4:50 PM
> To: linux-pm@vger.kernel.org
> Cc: trivial@kernel.org; linux-kernel@vger.kernel.org; Abelardo Ricart
> Subject: [PATCH] Thermal: Fix Step-wise governor Kconfig help text
> 
> Trivial fix for the help text of THERMAL_GOV_STEP_WISE.
> 
> Signed-off-by: Abelardo Ricart <aricart@gmail.com>

Thanks for your patch, but we've already have a fix here
https://patchwork.kernel.org/patch/2956561/

thanks,
rui
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig index
> dbfc390..29007bd 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -69,6 +69,7 @@ config THERMAL_GOV_STEP_WISE
>  	bool "Step_wise thermal governor"
>  	help
>  	  Enable this to manage platform thermals using a simple linear
> +	  throttling algorithm.
> 
>  config THERMAL_GOV_USER_SPACE
>  	bool "User_space thermal governor"
> --
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
