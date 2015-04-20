From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] int340x_thermal/processor_thermal_device: add support
 to Skylake processors
Date: Mon, 20 Apr 2015 10:48:41 -0700
Message-ID: <1429552121.24805.75.camel@spandruv-DESK3.jf.intel.com>
References: <1429318691-5666-1-git-send-email-brian.bian@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45761 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbbDTRuO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Apr 2015 13:50:14 -0400
In-Reply-To: <1429318691-5666-1-git-send-email-brian.bian@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Bian <brian.bian@intel.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org

There is no commit message here. You may want to atleast a line.
"Added skylake thermal reporting device PCI Id. "

On Fri, 2015-04-17 at 17:58 -0700, Brian Bian wrote: 
> Signed-off-by: Brian Bian <brian.bian@intel.com>
> ---
>  drivers/thermal/int340x_thermal/processor_thermal_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> index 5e8d8e9..cdfff52 100644
> --- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> @@ -25,6 +25,9 @@
>  #define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
>  #define PCI_DEVICE_ID_PROC_HSB_THERMAL	0x0A03
>  
> +/* Skylake thermal reporting device */
> +#define PCI_DEVICE_ID_PROC_SKL_THERMAL	0x1903
> +
>  /* Braswell thermal reporting device */
>  #define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
>  
> @@ -346,6 +349,7 @@ static void  proc_thermal_pci_remove(struct pci_dev *pdev)
>  static const struct pci_device_id proc_thermal_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_SKL_THERMAL)},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
>  	{ 0, },
>  };


