From: Dasaratharaman Chandramouli
	<dasaratharaman.chandramouli@intel.com>
Subject: Re: [PATCH] intel powerclamp: support Knights Landing
Date: Fri, 24 Apr 2015 10:33:34 -0700
Message-ID: <1429896814.16073.4.camel@localhost>
References: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7399 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303AbbDXRVf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Apr 2015 13:21:35 -0400
In-Reply-To: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan Jun <jacob.jun.pan@intel.com>, Nikhil Rao <nikhil.rao@intel.com>

Adding Jacob Pan

On Fri, 2015-04-17 at 15:31 -0700, Dasaratharaman Chandramouli wrote:
> This patch enables intel_powerclamp driver to run on the
> next-generation Intel(R) Xeon Phi Microarchitecture
> code named "Knights Landing"
> 
> Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index 12623bc..e34ccd5 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -690,6 +690,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x4c},
>  	{ X86_VENDOR_INTEL, 6, 0x4d},
>  	{ X86_VENDOR_INTEL, 6, 0x56},
> +	{ X86_VENDOR_INTEL, 6, 0x57},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);


