From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/3] mfd: intel_soc_pmic_bxtwc: Move inclusion to
 c-file
Date: Thu, 23 Mar 2017 12:13:16 +0000
Message-ID: <20170323121316.gkhsmqcykf3oy4en@dell>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <20170317153715.48555-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317153715.48555-2-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Mar 2017, Andy Shevchenko wrote:

> There is no need to include intel_soc_pmic.h into header which doesn't
> require it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 1 +
>  include/linux/mfd/intel_bxtwc.h    | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 699c8c7c9052..c71db687b7ca 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/intel_bxtwc.h>
> +#include <linux/mfd/intel_soc_pmic.h>
>  #include <asm/intel_pmc_ipc.h>
>  
>  /* PMIC device registers */
> diff --git a/include/linux/mfd/intel_bxtwc.h b/include/linux/mfd/intel_bxtwc.h
> index 1a0ee9d6efe9..240d6752ec64 100644
> --- a/include/linux/mfd/intel_bxtwc.h
> +++ b/include/linux/mfd/intel_bxtwc.h
> @@ -13,8 +13,6 @@
>   * more details.
>   */
>  
> -#include <linux/mfd/intel_soc_pmic.h>
> -
>  #ifndef __INTEL_BXTWC_H__
>  #define __INTEL_BXTWC_H__
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
