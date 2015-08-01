From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH 4/4] thermal/powerclamp: add cpu id for Skylake u/y
Date: Fri, 31 Jul 2015 17:06:59 -0700
Message-ID: <20150731170659.3a2218c0@radivoje-desk2>
References: <1438355274-124552-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37301 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbbHAAJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Jul 2015 20:09:37 -0400
In-Reply-To: <1438355274-124552-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, rui.zhang@intel.com

+Rui

On Fri, 31 Jul 2015 08:07:54 -0700
Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com> wrote:

> From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> 
> Add support for Intel Skylake u/y
> 
> Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 63879a1..6e01723 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -695,6 +695,7 @@ static const struct x86_cpu_id
> intel_powerclamp_ids[] __initconst = { { X86_VENDOR_INTEL, 6, 0x46},
>  	{ X86_VENDOR_INTEL, 6, 0x4c},
>  	{ X86_VENDOR_INTEL, 6, 0x4d},
> +	{ X86_VENDOR_INTEL, 6, 0x4e},
>  	{ X86_VENDOR_INTEL, 6, 0x4f},
>  	{ X86_VENDOR_INTEL, 6, 0x56},
>  	{ X86_VENDOR_INTEL, 6, 0x57},

