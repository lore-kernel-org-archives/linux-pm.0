From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [patch 1/2] cpuidle: use last_state which can
	reflect the actual state entered
Date: Wed, 01 Oct 2008 14:09:11 +0300
Message-ID: <87bpy4vag8.fsf@deeprootsystems.com>
References: <20080929222426.914988000@intel.com>
	<20080929222752.648696000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080929222752.648696000@intel.com> (Venkatesh Pallipadi's
	message of "Mon\, 29 Sep 2008 15\:24\:27 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> writes:

> cpuidle accounts the idle time for the C-state it was trying to enter and
> not to the actual state that the driver eventually entered. The driver may
> select a different state than the one chosen by cpuidle due to
> constraints like bus-mastering, etc.
>
> Change the time acounting code to look at the dev->last_state after
> returning from target_state->enter(). Driver can modify dev->last_state
> internally, inside the enter routine to reflect the actual C-state
> entered.
>
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
> ---
>  drivers/cpuidle/cpuidle.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Index: tip/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- tip.orig/drivers/cpuidle/cpuidle.c	2008-09-23 13:52:59.000000000 -0700
> +++ tip/drivers/cpuidle/cpuidle.c	2008-09-23 14:22:43.000000000 -0700
> @@ -71,8 +71,11 @@ static void cpuidle_idle_call(void)
>  	target_state = &dev->states[next_state];
>  
>  	/* enter the state and update stats */
> -	dev->last_residency = target_state->enter(dev, target_state);
>  	dev->last_state = target_state;
> +	dev->last_residency = target_state->enter(dev, target_state);
> +	if (dev->last_state)
> +		target_state = dev->last_state;
> +
>  	target_state->time += (unsigned long long)dev->last_residency;
>  	target_state->usage++;

Under what conditions would the enter hook set dev->last_sate to NULL?
Having the check seems to indicate it's possilble.

A minor nit-pick...  why not explicitly do the accounting using
'last_state' like below.  While functionally the same as above, this
makes it makes it more explicit when reading the code that the
accounting is done using 'last_state' and not 'target_state.'

Kevin


diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 5ce07b5..c1294f5 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -67,10 +67,10 @@ static void cpuidle_idle_call(void)
 	target_state = &dev->states[next_state];
 
 	/* enter the state and update stats */
-	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
-	target_state->time += (unsigned long long)dev->last_residency;
-	target_state->usage++;
+	dev->last_residency = target_state->enter(dev, target_state);
+	dev->last_state->time += (unsigned long long)dev->last_residency;
+	dev->last_state->usage++;
 
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
