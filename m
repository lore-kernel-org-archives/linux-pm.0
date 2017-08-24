From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/idle: Round up latency and residency
 values
Date: Thu, 24 Aug 2017 10:05:24 +0530
Message-ID: <20170824043524.GA5695@in.ibm.com>
References: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbdHXEfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2017 00:35:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7O4ZX1C104011
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2017 00:35:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2chgmssg8a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2017 00:35:32 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 23 Aug 2017 22:35:32 -0600
Content-Disposition: inline
In-Reply-To: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi Vaidy,
On Thu, Aug 24, 2017 at 12:28:41AM +0530, Vaidyanathan Srinivasan
wrote:

Cc'ing Rafael and linux-pm list.

> On PowerNV platforms, firmware provides exit latency and
> target residency for each of the idle states in nano
> seconds.  Cpuidle framework expects the values in micro
> seconds.  Round up to nearest micro seconds to avoid errors
> in cases where the values are defined as fractional micro
> seconds.
> 
> Default idle state of 'snooze' has exit latency of zero.  If
> other states have fractional micro second exit latency, they
> would get rounded down to zero micro second and make cpuidle
> framework choose deeper idle state when snooze loop is the
> right choice.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

This looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 42896a67aeae..5f3922392059 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -383,9 +383,9 @@ static int powernv_add_idle_states(void)
>  		 * Firmware passes residency and latency values in ns.
>  		 * cpuidle expects it in us.
>  		 */
> -		exit_latency = latency_ns[i] / 1000;
> +		exit_latency = DIV_ROUND_UP(latency_ns[i], 1000);
>  		if (!rc)
> -			target_residency = residency_ns[i] / 1000;
> +			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
>  		else
>  			target_residency = 0;
> 
> -- 
> 2.13.5
> 
