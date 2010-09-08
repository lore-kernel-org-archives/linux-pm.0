From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM / Wakeup: Introduce wakeup source
 objects and event statistics (was: Re: Wakeup-events implementation)
Date: Wed, 8 Sep 2010 16:17:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009081607170.1535-100000__511.139995842491$1283977227$gmane$org@iolanthe.rowland.org>
References: <201009080151.43047.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009080151.43047.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Sep 2010, Rafael J. Wysocki wrote:

> Hi,
> 
> Below is a patch that adds some statistics to the previously merged
> pm_wakeup_event()/pm_stay_awake()/pm_relax() code.  It also makes it possible
> to use wakeup sources that are not directly associated with devices.

I noted only a few things during a quick read-through.  See below.

> It adds functions for manipulating wakeup source objects and reworks the
> device wakeup enabling/disabling to use the new functions.  The list of wakeup
> sources is only used for updating the "hit count" statistics for now (this is
> the number of times the wakeup source was active when the PM core checked), but
> I'm planning to add a /proc file listing all wakeup sources, including the ones
> that are not attached to device objects.

It must be obvious that this is starting to look more and more like the
suspend_blockers patch.  What that means or will lead to, I don't
know...

> It appears to work with the PCI wakeup code added previously, but that's only
> one case.  I'm also not sure if it builds withoug CONFIG_PM_SLEEP.  [BTW, I'm
> not sure it atomic_inc() and atomic_dec() imply a memory barrier in general.
> That seems to be the case on x86, but I don't know about other architectures.]

They do not imply memory barriers.  See the section on atomic 
operations in Documentation/memory-barriers.txt.


> +/**
> + * wakeup_source_create - Create a struct wakeup_source object.
> + * @name: Name of the new wakeup source.
> + */
> +struct wakeup_source *wakeup_source_create(const char *name)
> +{
> +	struct wakeup_source *ws;
> +
> +	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
> +	if (!ws)
> +		return NULL;
> +
> +	if (name) {
> +		int len = strlen(name);
> +		char *s = kzalloc(len + 1, GFP_KERNEL);
> +		if (s) {
> +			strncpy(s, name, len);

Would it be better to use kmalloc instead of kzalloc, call memcpy 
instead of strncpy, and write the terminating NUL character manually?

> +			ws->name = s;
> +		}
> +	}
> +
> +	return ws;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_create);
> +
> +/**
> + * wakeup_source_destroy - Destroy a struct wakeup_source object.
> + * @ws: Wakeup source to destroy.
> + */
> +void wakeup_source_destroy(struct wakeup_source *ws)
> +{
> +	if (!ws)
> +		return;
> +
> +	spin_lock_irq(&ws->lock);

Since you use the spinlock here, it needs to be initialized in 
wakeup_source_create rather than wakeup_source_register.

> +	while (ws->active) {
> +		spin_unlock_irq(&ws->lock);
> +
> +		schedule_timeout_interruptible(msecs_to_jiffies(TIMEOUT));
> +
> +		spin_lock_irq(&ws->lock);
> +	}
> +	spin_unlock_irq(&ws->lock);
> +
> +	if (ws->name)
> +		kfree(ws->name);

No need for the "if".

> +	kfree(ws);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_destroy);
> +
> +/**
> + * wakeup_source_register - Add given object to the list of wakeup sources.
> + * @ws: Wakeup source object to register.
> + */
> +void wakeup_source_register(struct wakeup_source *ws)
> +{
> +	if (WARN_ON(!ws))
> +		return;
> +
> +	spin_lock_init(&ws->lock);
> +	setup_timer(&ws->timer, pm_wakeup_timer_fn, (unsigned long)ws);
> +	ws->active = false;
> +
> +	spin_lock_irq(&events_lock);
> +	list_add_rcu(&ws->entry, &wakeup_sources);
> +	spin_unlock_irq(&events_lock);
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_register);

...

> +/**
> + * wakeup_source_add - Create and register a wakeup source object.
> + * @name: Name of the wakeup source to create.
> + */
> +struct wakeup_source *wakeup_source_add(const char *name)
> +{
> +	struct wakeup_source *ws;
> +
> +	ws = wakeup_source_create(name);
> +	if (ws)
> +		wakeup_source_register(ws);
> +
> +	return ws;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_add);

Your use of names is backward.  Normally the *_register routine does
*_init followed by *_add.

I haven't looked through the rest in enough detail yet to make any 
meaningful comments.

Alan Stern
