From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] CPUidle: increment state counter for state
	actually entered
Date: Wed, 01 Oct 2008 14:00:15 +0300
Message-ID: <87skrgvav4.fsf@deeprootsystems.com>
References: <1222858024-20369-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1222858024-20369-1-git-send-email-khilman@deeprootsystems.com>
	(Kevin Hilman's message of "Wed\, 1 Oct 2008 13\:47\:04 +0300")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Currently, the count for state that the governor chooses is always
> incremented after the 'state_enter' hook is called.  However, the
> target's enter hook may choose a different state based on BM activity
> or other factors.
>
> This patch does the accounting use 'dev->last_state' state instead of
> the governor-chosen state.  If the target's enter_idle hook enters a
> different state than it was asked, it should update dev->last_state.
>

Oops, I sent this before I saw Venkatesh's earlier patch to do the
same.

Kevin

> ---
>  drivers/cpuidle/cpuidle.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 5ce07b5..c1294f5 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -67,10 +67,10 @@ static void cpuidle_idle_call(void)
>  	target_state = &dev->states[next_state];
>  
>  	/* enter the state and update stats */
> -	dev->last_residency = target_state->enter(dev, target_state);
>  	dev->last_state = target_state;
> -	target_state->time += (unsigned long long)dev->last_residency;
> -	target_state->usage++;
> +	dev->last_residency = target_state->enter(dev, target_state);
> +	dev->last_state->time += (unsigned long long)dev->last_residency;
> +	dev->last_state->usage++;
>  
>  	/* give the governor an opportunity to reflect on the outcome */
>  	if (cpuidle_curr_governor->reflect)
> -- 
> 1.6.0
