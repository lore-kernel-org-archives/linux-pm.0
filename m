From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 03/30] thermal: cpu_cooling: fix kernel_doc for
 cpufreq_cooling_device
Date: Wed, 24 Apr 2013 14:49:59 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632C9F91@SHSMSX101.ccr.corp.intel.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
 <1366218743-20841-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-4-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
> Sent: Thursday, April 18, 2013 1:12 AM
> To: amit.kachhap@linaro.org
> Cc: Eduardo Valentin; Zhang, Rui; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 03/30] thermal: cpu_cooling: fix kernel_doc for
> cpufreq_cooling_device
> Importance: High
> 
> Simple fixes for making kernel_doc happy about struct
> cpufreq_cooling_device. Includes also a minor spelling fix.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Applied.

Thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c
> b/drivers/thermal/cpu_cooling.c index d0d6a0c..7c0c05b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -28,11 +28,11 @@
>  #include <linux/cpu_cooling.h>
> 
>  /**
> - * struct cpufreq_cooling_device
> + * struct cpufreq_cooling_device - data for cooling device with
> cpufreq
>   * @id: unique integer value corresponding to each
> cpufreq_cooling_device
>   *	registered.
> - * @cool_dev: thermal_cooling_device pointer to keep track of the the
> - *	egistered cooling device.
> + * @cool_dev: thermal_cooling_device pointer to keep track of the
> + *	registered cooling device.
>   * @cpufreq_state: integer value representing the current state of
> cpufreq
>   *	cooling	devices.
>   * @cpufreq_val: integer value representing the absolute value of the
> clipped
> --
> 1.8.2.1.342.gfa7285d
