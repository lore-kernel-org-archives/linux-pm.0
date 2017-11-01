From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal: int340x: processor_thermal: Add Coffee
 Lake support
Date: Wed, 01 Nov 2017 11:33:35 +0800
Message-ID: <1509507215.3080.82.camel@intel.com>
References: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1508449894-58797-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43495 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbdKADc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Oct 2017 23:32:57 -0400
In-Reply-To: <1508449894-58797-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-10-19 at 14:51 -0700, Srinivas Pandruvada wrote:
> Add new PCI id for Coffee lake processor thermal device.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c
> om>
> ---
>  drivers/thermal/int340x_thermal/processor_thermal_device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/drivers/thermal/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> index e724a23..1d9f524 100644
> --- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> @@ -32,6 +32,7 @@
>  
>  /* CannonLake thermal reporting device */
>  #define PCI_DEVICE_ID_PROC_CNL_THERMAL	0x5a03
> +#define PCI_DEVICE_ID_PROC_CFL_THERMAL	0x3E83
>  
shouldn't it be added into proc_thermal_pci_ids[]?

thanks,
rui
>  /* Braswell thermal reporting device */
>  #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
