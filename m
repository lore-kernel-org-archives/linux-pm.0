From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/powerclamp: add id for braswell cpu
Date: Mon, 08 Dec 2014 12:00:08 +0800
Message-ID: <1418011208.19126.19.camel@rzhang1-toshiba>
References: <1417713466-1058-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44129 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbaLHEAL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Dec 2014 23:00:11 -0500
In-Reply-To: <1417713466-1058-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, 2014-12-04 at 09:17 -0800, Jacob Pan wrote:

Adding your Signed-off-by and applied.

thanks,
rui

> ---
>  drivers/thermal/intel_powerclamp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index 95cb7fc..b46c706 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -689,6 +689,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x3f},
>  	{ X86_VENDOR_INTEL, 6, 0x45},
>  	{ X86_VENDOR_INTEL, 6, 0x46},
> +	{ X86_VENDOR_INTEL, 6, 0x4c},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);


