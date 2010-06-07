From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH] pm_qos: make update_request callable from
 interrupt context
Date: Mon, 07 Jun 2010 10:20:48 -0400
Message-ID: <1275920448.2849.31.camel@mulgrave.site>
References: <1275913865-16277-1-git-send-email-florian@mickler.org>
	<1275916241.2849.21.camel@mulgrave.site>
	<20100607161034.5ece3f83@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100607161034.5ece3f83@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-07 at 16:10 +0200, Florian Mickler wrote:
> On Mon, 07 Jun 2010 09:10:40 -0400
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > index f42d3f7..0a67997 100644
> > > --- a/kernel/pm_qos_params.c
> > > +++ b/kernel/pm_qos_params.c
> > > @@ -63,7 +63,8 @@ static s32 min_compare(s32 v1, s32 v2);
> > >  
> > >  struct pm_qos_object {
> > >  	struct pm_qos_request_list requests;
> > > -	struct blocking_notifier_head *notifiers;
> > > +	struct atomic_notifier_head *notifiers;
> > > +	struct blocking_notifier_head *blocking_notifiers;
> > >  	struct miscdevice pm_qos_power_miscdev;
> > >  	char *name;
> > >  	s32 default_value;
> > > @@ -72,20 +73,24 @@ struct pm_qos_object {
> > >  };
> > >  
> > >  static struct pm_qos_object null_pm_qos;
> > > -static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> > > +static ATOMIC_NOTIFIER_HEAD(cpu_dma_lat_notifier);
> > > +static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_blocking_notifier);
> > 
> > So I think it might be better implemented by having only a single active
> > notifier head: either blocking or atomic  because all this depends on
> > where the callsites for the notifiers are, and the person adding the
> > notifier should know this..  
> 
> > We can add atomic notifiers to the blocking
> > chain, just not vice versa.  The idea is that if all the add and update
> > call sites are blocking, you just register the blocking chain and forget
> > the atomic one.  
> 
> > The only difference between atomic and blocking
> > notifiers is whether we use a spinlock or a mutex to guard the integrity
> > of the call chain ... if you know you always have user context at the
> > callsites, then you can always use the mutex.
> 
> > Then, for blocking notifiers, I think in init, we can register a single
> > notifier which just calls __might_sleep() ... that will pick up at
> > runtime any atomic callsite.
> 
> I like that part. Simple and elegant :)
> 
> > 
> > For atomics, you just set up an atomic call chain and leave the blocking
> > one null.  Then we get a BUG if anyone tries to register a blocking
> > notifier to an atomic only pm_qos_object.
> > 
> (Well, we can also just ignore and print a WARN() ... but I got your
> point)
> 
> But I don't think I understand how you want to set up the call chains.
> (I.e. How to decide if all call-sites are from process-context (mutex
> allowed)? )

We don't.  Whoever creates the new pm_qos constratint decides this ...
based on where they're putting the add and update calls.  They do this
by either declaring a blocking or an atomic notifier chain for the
pm_qos_object.

> As far as I see, the locking for the notifier-chains is in the head. So
> I have to decide before the first AddNotifier what locking I
> want (blocking_ or atomic_notifier_head). 

Right.  We still have the atomic and blocking pm_qos notifier
registers ... but if you try to register an blocking notifier to a
pm_qos_object that only supports atomic, we bug.  Conversely, if you try
to register an atomic notifier to a pm_qos_object that supports
blocking, we just add it to the blocking call chain ... there's no harm
in that since an atomic notifier is only guaranteeing that it won't
sleep, so it's irrelevant to it whether we have user context or not.

> Are you thinking about having it hardcoded alongside the pm_qos_object
> instantiation? (I think that would be ok) 
> 
> Or are you thinking about some other scheme I don't see?

James
