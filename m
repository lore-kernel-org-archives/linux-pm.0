From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pseries/cpuidle: add polling idle for shared
 processor guests
Date: Fri, 17 Nov 2017 02:17:53 +1000
Message-ID: <20171117021753.4f8402ee@roar.ozlabs.ibm.com>
References: <20171010071109.31207-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46033 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964911AbdKPQSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 11:18:05 -0500
In-Reply-To: <20171010071109.31207-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 10 Oct 2017 17:11:09 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> For shared processor guests (e.g., KVM), add an idle polling mode rather
> than immediately returning to the hypervisor when the guest CPU goes
> idle.
> 
> Test setup is a 2 socket POWER9 with 4 guests running, each with vCPUs
> equal to 1/2 of real of CPUs. Saturated each guest with tbench. Using
> polling idle gives about 1.4x throughput.
> 
> Kernel compile speed was not changed significantly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

What should we do about this one?


> ---
>  drivers/cpuidle/cpuidle-pseries.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index e9b3853d93ea..16be7ad30fe1 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -171,11 +171,17 @@ static struct cpuidle_state dedicated_states[] = {
>   * States for shared partition case.
>   */
>  static struct cpuidle_state shared_states[] = {
> +	{ /* Snooze */
> +		.name = "snooze",
> +		.desc = "snooze",
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = &snooze_loop },
>  	{ /* Shared Cede */
>  		.name = "Shared Cede",
>  		.desc = "Shared Cede",
> -		.exit_latency = 0,
> -		.target_residency = 0,
> +		.exit_latency = 10,
> +		.target_residency = 100,
>  		.enter = &shared_cede_loop },
>  };
>  
