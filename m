From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH] pm_qos: make update_request callable from
 interrupt context
Date: Mon, 07 Jun 2010 09:10:40 -0400
Message-ID: <1275916241.2849.21.camel@mulgrave.site>
References: <1275913865-16277-1-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275913865-16277-1-git-send-email-florian@mickler.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: florian@mickler.org
Cc: pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-07 at 14:31 +0200, florian@mickler.org wrote:
> We introduce new atomic_notifiers and only call the (legacy) blocking
> notifiers if there are any registered. A might_sleep() tries to
> fence off all misuse.
> 
> This should make it possible to call update_request from interrupt-context
> as long as only atomic notifiers are registered.
> 
> Signed-off-by: Florian Mickler <florian@mickler.org>
> ---
>  include/linux/pm_qos_params.h |    3 +
>  kernel/pm_qos_params.c        |  114 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 94 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
> index 8ba440e..60ed542 100644
> --- a/include/linux/pm_qos_params.h
> +++ b/include/linux/pm_qos_params.h
> @@ -22,6 +22,9 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
>  void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
>  
>  int pm_qos_request(int pm_qos_class);
> +
>  int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
>  int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
>  
> +int pm_qos_add_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier);
> +int pm_qos_remove_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier);
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index f42d3f7..0a67997 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -63,7 +63,8 @@ static s32 min_compare(s32 v1, s32 v2);
>  
>  struct pm_qos_object {
>  	struct pm_qos_request_list requests;
> -	struct blocking_notifier_head *notifiers;
> +	struct atomic_notifier_head *notifiers;
> +	struct blocking_notifier_head *blocking_notifiers;
>  	struct miscdevice pm_qos_power_miscdev;
>  	char *name;
>  	s32 default_value;
> @@ -72,20 +73,24 @@ struct pm_qos_object {
>  };
>  
>  static struct pm_qos_object null_pm_qos;
> -static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> +static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> +static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_blocking_notifier);

So I think it might be better implemented by having only a single active
notifier head: either blocking or atomic  because all this depends on
where the callsites for the notifiers are, and the person adding the
notifier should know this..  We can add atomic notifiers to the blocking
chain, just not vice versa.  The idea is that if all the add and update
call sites are blocking, you just register the blocking chain and forget
the atomic one.  The only difference between atomic and blocking
notifiers is whether we use a spinlock or a mutex to guard the integrity
of the call chain ... if you know you always have user context at the
callsites, then you can always use the mutex.

Then, for blocking notifiers, I think in init, we can register a single
notifier which just calls __might_sleep() ... that will pick up at
runtime any atomic callsite.

For atomics, you just set up an atomic call chain and leave the blocking
one null.  Then we get a BUG if anyone tries to register a blocking
notifier to an atomic only pm_qos_object.

The implementation looks fine, except:

[...]
>  /**
> + * pm_qos_add_notifier_nonblocking - sets notification entry for changes to target value
> + *
> + * Code executed by the notifier block may not sleep!
> + *
> + * @pm_qos_class: identifies which qos target changes should be notified.
> + * @notifier: notifier block managed by caller.
> + *
> + * Will register the notifier into a notification chain that gets called
> + * upon changes to the pm_qos_class target value.
> + */
> +int pm_qos_add_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier)

Rightly or wrongly, the notifier people use atomic not nonblocking, so
we should really stick with it to avoid confusion.

James
