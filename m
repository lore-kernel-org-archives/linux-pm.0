From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 01/30] thermal: cpu_cooling: remove unused headers
Date: Wed, 24 Apr 2013 14:44:05 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632C9F3F@SHSMSX101.ccr.corp.intel.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
 <1366218743-20841-2-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-2-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Thursday, April 18, 2013 1:12 AM
> To: amit.kachhap@linaro.org
> Cc: Eduardo Valentin; Zhang, Rui; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 01/30] thermal: cpu_cooling: remove unused headers
> Importance: High
> 
> As this code is not a module nor a platform device driver, this patch
> removes some unused header files.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Applied.

Thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c
> b/drivers/thermal/cpu_cooling.c index 5f5c780..778c43d 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -20,10 +20,7 @@
>   *
>   *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~
>   */
> -#include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/thermal.h>
> -#include <linux/platform_device.h>
>  #include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> --
> 1.8.2.1.342.gfa7285d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
