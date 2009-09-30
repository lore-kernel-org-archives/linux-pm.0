From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] CPUidle: always return with interrupts
	enabled
Date: Wed, 30 Sep 2009 23:21:33 +0200
Message-ID: <200909302321.33088.rjw__2371.76313899017$1254345708$gmane$org@sisk.pl>
References: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 30 September 2009, Kevin Hilman wrote:
> In the case where cpuidle_idle_call() returns before changing state
> due to a need_resched(), it was returning with IRQs disabled.
> 
> This patch ensures IRQs are (re)enabled before returning.

Venki, any comments on this?

> Reported-by: Hemanth V <hemanthv@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/cpuidle/cpuidle.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ad41f19..12fdd39 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -76,8 +76,11 @@ static void cpuidle_idle_call(void)
>  #endif
>  	/* ask the governor for the next state */
>  	next_state = cpuidle_curr_governor->select(dev);
> -	if (need_resched())
> +	if (need_resched()) {
> +		local_irq_enable();
>  		return;
> +	}
> +
>  	target_state = &dev->states[next_state];
>  
>  	/* enter the state and update stats */

Best,
Rafael
