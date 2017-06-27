From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: prevent overridding bits outside of the mask
Date: Tue, 27 Jun 2017 02:17:32 +0200
Message-ID: <30611930.SfmUctH6tv@aspire.rjw.lan>
References: <20170601092150.4474-1-adam.lessnau@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45245 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751461AbdF0AY4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2017 20:24:56 -0400
In-Reply-To: <20170601092150.4474-1-adam.lessnau@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Lessnau <adam.lessnau@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Thursday, June 01, 2017 11:21:50 AM Adam Lessnau wrote:
> Fixes wrong bits shift operation in the rapl_write_data_raw function, which
> might cause overridding bits outside of the mask.
> 
> For example, writing new TIME_WINDOW1 value can override POWER_LIMIT1.
> 
> Signed-off-by: Adam Lessnau <adam.lessnau@intel.com>

Jacob, any comments?

> ---
>  drivers/powercap/intel_rapl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 3c71f608b444..6dc27afb8527 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -887,7 +887,9 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
>  
>  	cpu = rd->rp->lead_cpu;
>  	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
> -	bits |= bits << rp->shift;
> +	bits <<= rp->shift;
> +	bits &= rp->mask;
> +
>  	memset(&ma, 0, sizeof(ma));
>  
>  	ma.msr_no = rd->msrs[rp->id];
> 
