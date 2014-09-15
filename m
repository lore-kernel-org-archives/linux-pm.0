From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
Date: Mon, 15 Sep 2014 16:59:12 +1000
Message-ID: <1410764352.32643.2.camel@concordia>
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:49438 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbaIOG7Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Sep 2014 02:59:16 -0400
In-Reply-To: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: mikey@neuling.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

On Fri, 2014-09-12 at 16:31 +0530, Preeti U Murthy wrote:
> Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
> entry into deep idle states beyond snooze. Check for the value of this
> parameter before entering fastsleep. We already do this check for nap in
> power7_idle().
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> 
>  drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index a64be57..b8ba52e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  	unsigned long old_lpcr = mfspr(SPRN_LPCR);
>  	unsigned long new_lpcr;
>  
> +	/*
> +	 * Verify if snooze is the only valid cpuidle state
> +	 */
> +	if (!(powersave_nap > 0))
> +		return index;
> +
>  	if (unlikely(system_state < SYSTEM_RUNNING))
>  		return index;

Doesn't the above mean we are just going to keep trying to go into fastsleep
again and again? Or does the idle code work out that it didn't work based on
the fact that we didn't sleep for the right period?

We were talking about getting rid of powersave_nap altogether, but I think we
decided we couldn't, I forget.

cheers


