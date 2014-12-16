From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] powercap/rapl: add ids for future xeon cpus
Date: Mon, 15 Dec 2014 16:36:48 -0800
Message-ID: <20141216003648.GA32627@roeck-us.net>
References: <1418667255-8804-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60204 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaLPAgy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 19:36:54 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y0g8E-003H0r-K8
	for linux-pm@vger.kernel.org; Tue, 16 Dec 2014 00:36:54 +0000
Content-Disposition: inline
In-Reply-To: <1418667255-8804-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, Dec 15, 2014 at 10:14:15AM -0800, Jacob Pan wrote:
> Enable RAPL driver on Xeon cpu id 0x56.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index c71443c..ee00ffb 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1041,6 +1041,7 @@ static const struct x86_cpu_id rapl_ids[] = {
>  	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
>  	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
>  	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
> +	RAPL_CPU(0x56, rapl_defaults_atom),/* Future Xeon */

Is rapl_defaults_atom correct, or should this be rapl_defaults_core ?

Guenter

>  	RAPL_CPU(0x5A, rapl_defaults_atom),/* Annidale */
>  	{}
>  };
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
