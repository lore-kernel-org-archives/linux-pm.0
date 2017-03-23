From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/3] mfd: intel_soc_pmic_bxtwc: Rename header to
 follow c-file
Date: Thu, 23 Mar 2017 12:13:28 +0000
Message-ID: <20170323121328.3t3qds7iesettfay@dell>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <20170317153715.48555-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317153715.48555-3-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Mar 2017, Andy Shevchenko wrote:

> For better understanding of relationship between headers and modules
> rename:
> 	intel_bxtwc.h -> intel_soc_pmic_bxtwc.h
> 
> While here, remove file name from the file itself.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c                          | 2 +-
>  include/linux/mfd/{intel_bxtwc.h => intel_soc_pmic_bxtwc.h} | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/mfd/{intel_bxtwc.h => intel_soc_pmic_bxtwc.h} (96%)

Applied, thanks.

> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index c71db687b7ca..1496a862baa6 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -20,8 +20,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/core.h>
> -#include <linux/mfd/intel_bxtwc.h>
>  #include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/mfd/intel_soc_pmic_bxtwc.h>
>  #include <asm/intel_pmc_ipc.h>
>  
>  /* PMIC device registers */
> diff --git a/include/linux/mfd/intel_bxtwc.h b/include/linux/mfd/intel_soc_pmic_bxtwc.h
> similarity index 96%
> rename from include/linux/mfd/intel_bxtwc.h
> rename to include/linux/mfd/intel_soc_pmic_bxtwc.h
> index 240d6752ec64..0c351bc85d2d 100644
> --- a/include/linux/mfd/intel_bxtwc.h
> +++ b/include/linux/mfd/intel_soc_pmic_bxtwc.h
> @@ -1,5 +1,5 @@
>  /*
> - * intel_bxtwc.h - Header file for Intel Broxton Whiskey Cove PMIC
> + * Header file for Intel Broxton Whiskey Cove PMIC
>   *
>   * Copyright (C) 2015 Intel Corporation. All rights reserved.
>   *

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
