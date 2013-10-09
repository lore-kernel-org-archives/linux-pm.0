From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: Add newer CPU models
Date: Wed, 09 Oct 2013 12:18:10 +0800
Message-ID: <1381292290.2133.38.camel@rzhang1-mobl4>
References: <1380195205-32646-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32551 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab3JIESN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Oct 2013 00:18:13 -0400
In-Reply-To: <1380195205-32646-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>

On Thu, 2013-09-26 at 04:33 -0700, Jacob Pan wrote:
> This will enable intel_powerclamp driver on newer Intel CPUs
> including some Ivy Bridge and Haswell processors.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/intel_powerclamp.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index b40b37c..6e3b061 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -675,6 +675,11 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x2e},
>  	{ X86_VENDOR_INTEL, 6, 0x2f},
>  	{ X86_VENDOR_INTEL, 6, 0x3a},
> +	{ X86_VENDOR_INTEL, 6, 0x3c},
> +	{ X86_VENDOR_INTEL, 6, 0x3e},
> +	{ X86_VENDOR_INTEL, 6, 0x3f},
> +	{ X86_VENDOR_INTEL, 6, 0x45},
> +	{ X86_VENDOR_INTEL, 6, 0x46},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);


