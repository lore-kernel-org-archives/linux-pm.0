From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM: runtime: add might_sleep to PM
	runtime functions
Date: Wed, 27 Jul 2011 00:14:36 +0200
Message-ID: <201107270014.36910.rjw__35485.3541277864$1311718484$gmane$org@sisk.pl>
References: <1311627344-8097-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311627344-8097-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 25, 2011, Colin Cross wrote:
> Some of the entry points to pm runtime are not safe to
> call in atomic context unless pm_runtime_irq_safe() has
> been called.  Inspecting the code, it is not immediately
> obvious that the functions sleep at all, as they run
> inside a spin_lock_irqsave, but under some conditions
> they can drop the lock and turn on irqs.
> 
> If a driver incorrectly calls the pm_runtime apis, it can
> cause sleeping and irq processing when it expects to stay
> in atomic context.
> 
> Add might_sleep_if to all the __pm_runtime_* entry points
> to enforce correct usage.
> 
> Add pm_runtime_put_sync_autosuspend to the list of
> functions that can be called in atomic context.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  Documentation/power/runtime_pm.txt |    1 +
>  drivers/base/power/runtime.c       |   15 ++++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index c291233..1ad507c 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -469,6 +469,7 @@ pm_runtime_resume()
>  pm_runtime_get_sync()
>  pm_runtime_put_sync()
>  pm_runtime_put_sync_suspend()
> +pm_runtime_put_sync_autosuspend()
>  
>  5. Run-time PM Initialization, Device Probing and Removal
>  
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2e746f8..f3d8583 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -731,13 +731,16 @@ EXPORT_SYMBOL_GPL(pm_schedule_suspend);
>   * return immediately if it is larger than zero.  Then carry out an idle
>   * notification, either synchronous or asynchronous.
>   *
> - * This routine may be called in atomic context if the RPM_ASYNC flag is set.
> + * This routine may be called in atomic context if the RPM_ASYNC flag is set,
> + * or if pm_runtime_irq_safe() has been called.
>   */
>  int __pm_runtime_idle(struct device *dev, int rpmflags)
>  {
>  	unsigned long flags;
>  	int retval;
>  
> +	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> +

Now that I think of it, perhaps it's better to put the might_sleep()
annotations into the actual code paths that should trigger them instead of
checking the conditions upfront on every call?  This way we'll avoid quite
some overhead that's only necessary for debugging.

Thanks,
Rafael
