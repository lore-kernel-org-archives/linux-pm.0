From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH] pm_qos: make update_request non blocking
Date: Sun, 6 Jun 2010 14:50:49 -0700
Message-ID: <20100606215049.GF8610@gvim.org>
References: <1275770783-4183-1-git-send-email-florian@mickler.org>
	<1275771430.7227.79.camel@mulgrave.site>
	<20100605232102.0eef78aa@schatten.dmk.lab>
	<1275777849.7227.192.camel@mulgrave.site>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275777849.7227.192.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Florian Mickler <florian@mickler.org>, pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 05, 2010 at 05:44:09PM -0500, James Bottomley wrote:
> On Sat, 2010-06-05 at 23:21 +0200, Florian Mickler wrote:
> > On Sat, 05 Jun 2010 15:57:10 -0500
> > James Bottomley <James.Bottomley@suse.de> wrote:
> > 
> > > On Sat, 2010-06-05 at 22:46 +0200, florian@mickler.org wrote:
> > > > First we use atomic_notifier to get the spinlocked variant.
> > > > Secondly we call the notifiers via schedule_work.
> > > > 
> > > > Signed-off-by: Florian Mickler <florian@mickler.org>
> > > > ---
> > > > 
> > > > Please advise.
> > > > 
> > > >  kernel/pm_qos_params.c |   33 ++++++++++++++++++++++-----------
> > > >  1 files changed, 22 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > > index f42d3f7..7335c27 100644
> > > > --- a/kernel/pm_qos_params.c
> > > > +++ b/kernel/pm_qos_params.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include <linux/string.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/init.h>
> > > > +#include <linux/workqueue.h>
> > > >  
> > > >  #include <linux/uaccess.h>
> > > >  
> > > > @@ -63,7 +64,7 @@ static s32 min_compare(s32 v1, s32 v2);
> > > >  
> > > >  struct pm_qos_object {
> > > >  	struct pm_qos_request_list requests;
> > > > -	struct blocking_notifier_head *notifiers;
> > > > +	struct atomic_notifier_head *notifiers;
> > > >  	struct miscdevice pm_qos_power_miscdev;
> > > >  	char *name;
> > > >  	s32 default_value;
> > > > @@ -72,7 +73,7 @@ struct pm_qos_object {
> > > >  };
> > > >  
> > > >  static struct pm_qos_object null_pm_qos;
> > > > -static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> > > > +static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> > > >  static struct pm_qos_object cpu_dma_pm_qos = {
> > > >  	.requests = {LIST_HEAD_INIT(cpu_dma_pm_qos.requests.list)},
> > > >  	.notifiers = &cpu_dma_lat_notifier,
> > > > @@ -82,7 +83,7 @@ static struct pm_qos_object cpu_dma_pm_qos = {
> > > >  	.comparitor = min_compare
> > > >  };
> > > >  
> > > > -static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> > > > +static ATOMIC_NOTIFIER_HEAD(network_lat_notifier);
> > > >  static struct pm_qos_object network_lat_pm_qos = {
> > > >  	.requests = {LIST_HEAD_INIT(network_lat_pm_qos.requests.list)},
> > > >  	.notifiers = &network_lat_notifier,
> > > > @@ -93,7 +94,7 @@ static struct pm_qos_object network_lat_pm_qos = {
> > > >  };
> > > >  
> > > > 
> > > > -static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> > > > +static ATOMIC_NOTIFIER_HEAD(network_throughput_notifier);
> > > >  static struct pm_qos_object network_throughput_pm_qos = {
> > > >  	.requests = {LIST_HEAD_INIT(network_throughput_pm_qos.requests.list)},
> > > >  	.notifiers = &network_throughput_notifier,
> > > > @@ -103,7 +104,6 @@ static struct pm_qos_object network_throughput_pm_qos = {
> > > >  	.comparitor = max_compare
> > > >  };
> > > >  
> > > > -
> > > >  static struct pm_qos_object *pm_qos_array[] = {
> > > >  	&null_pm_qos,
> > > >  	&cpu_dma_pm_qos,
> > > > @@ -135,6 +135,15 @@ static s32 min_compare(s32 v1, s32 v2)
> > > >  	return min(v1, v2);
> > > >  }
> > > >  
> > > > +static void update_notify(struct work_struct* work){
> > > > +	int pm_qos_class = atomic_long_read(&work->data);
> > > > +	
> > > > +	s32 extreme_value = atomic_read(&pm_qos_array[pm_qos_class]->target_value);
> > > > +	atomic_notifier_call_chain(
> > > > +		pm_qos_array[pm_qos_class]->notifiers,
> > > > +			(unsigned long) extreme_value, NULL);
> > > > +}
> > > > +struct work_struct pm_qos_update_notify_work;
> > > >  
> > > >  static void update_target(int pm_qos_class)
> > > >  {
> > > > @@ -160,10 +169,10 @@ static void update_target(int pm_qos_class)
> > > >  	}
> > > >  	spin_unlock_irqrestore(&pm_qos_lock, flags);
> > > >  
> > > > -	if (call_notifier)
> > > > -		blocking_notifier_call_chain(
> > > > -				pm_qos_array[pm_qos_class]->notifiers,
> > > > -					(unsigned long) extreme_value, NULL);
> > > > +	if (call_notifier){
> > > > +		atomic_long_set(&pm_qos_update_notify_work.data, pm_qos_class);
> > > > +		schedule_work(&pm_qos_update_notify_work);
> > > 
> > > Actually, you should use execute_in_process_context for this ... that
> > > way any current call from user context won't change semantics (i.e. the
> > > notifier will be executed before the call finishes).
> > 
> > Ah, ok. Didn't know of its existence. 
> > After thinking a bit, I think it is crucial for the qos-infrastructure
> > to provide direct notifiers. For example, any missed change in latency
> > could impact the system.
> > 
> > > 
> > > I also suspect we might need an atomic notifier chain to be called
> > > in-line ... things like the dma latency notifier need in-line
> > > notification, I can see that some android ones would at all.  However,
> > > this question can be deferred until an actual use case is seen.
> > 
> > We should probably only provide an atomic queue and have all users
> > either schedule work or be quick, as it can be crucial to get the
> > information out there.
> > 
> > What do you think?
> 
> Yes, considering the use cases, I don't think we want to muck with
> workqueues at all, so just do two queues per constraint, one blocking
> and one atomic.  For a constraint  that has atomic update sites,
> registering a blocking notifier would be illegal and we'd give a runtime
> warning (we can even code a __might_sleep in there before the call).
> That way we preserve current semantics and permit blocking notifiers to
> be registered, but only if all the call sites have user context.
> 
I like the idea of having only atomic safe notifiers.  Is there an easy
way to enforce that?

--mgross
 
> 
