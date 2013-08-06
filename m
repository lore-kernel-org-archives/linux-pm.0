From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
Date: Tue, 6 Aug 2013 18:08:40 -0500
Message-ID: <1375830520.5600.23.camel@snotra.buserror.net>
References: <20130731025840.19448.24468.stgit@deepthi>
	 <20130731025934.19448.16658.stgit@deepthi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:16076
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756827Ab3HFXJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 19:09:04 -0400
In-Reply-To: <20130731025934.19448.16658.stgit@deepthi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, michael@ellerman.id.au, srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, rjw@sisk.pl, dongsheng.wang@freescale.com, linux-pm@vger.kernel.org

On Wed, 2013-07-31 at 08:29 +0530, Deepthi Dharwar wrote:
>  /*
> - * pseries_idle_probe()
> + * powerpc_idle_probe()
>   * Choose state table for shared versus dedicated partition
>   */
> -static int pseries_idle_probe(void)
> +static int powerpc_idle_probe(void)
>  {
>  
> +#ifndef PPC_POWERNV
>  	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>  		return -ENODEV;
> +#endif

A bunch of ifdefs is not a good start for a file you're claiming is now
generic for all powerpc.

Certainly you shouldn't be calling pseries stuff based only on the
absence of powernv.

And do you not support building one kernel that supports both pseries
and powernv?

>  	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>  		return -ENODEV;
>  
>  	if (max_idle_state == 0) {
> -		printk(KERN_DEBUG "pseries processor idle disabled.\n");
> +		printk(KERN_DEBUG "powerpc processor idle disabled.\n");
>  		return -EPERM;
>  	}
>  
> +#ifdef PPC_POWERNV
> +	cpuidle_state_table = powernv_states;
> +#else
>  	if (get_lppaca()->shared_proc)

Here's another example.  get_lppaca() will only build on book3s -- and
yet we get requests for e500 code to use this file.

-Scott



