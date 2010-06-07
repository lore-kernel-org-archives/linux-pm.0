From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Sun, 06 Jun 2010 23:05:06 -0400
Message-ID: <1275879906.7227.582.camel@mulgrave.site>
References: <1275760688.7227.10.camel@mulgrave.site>
	<20100606213954.GD8610@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606213954.GD8610@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-06-06 at 14:39 -0700, mark gross wrote:
> > @@ -251,22 +244,27 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> >  	unsigned long flags;
> >  	int pending_update = 0;
> >  	s32 temp;
> > +	struct pm_qos_object *o;
> >  
> > -	if (pm_qos_req) { /*guard against callers passing in null */
> > -		spin_lock_irqsave(&pm_qos_lock, flags);
> > -		if (new_value == PM_QOS_DEFAULT_VALUE)
> > -			temp = pm_qos_array[pm_qos_req->pm_qos_class]->default_value;
> > -		else
> > -			temp = new_value;
> > +	if (!pm_qos_req) /*guard against callers passing in null */
> > +		return;
> 
> need a better test to see if the pm_qos_req is in the plist or not as we
> move to a caller allocated design.

This is a guard against callers passing in NULL ... which is probably
unnecessary ... I think oopsing on a NULL deref would be just fine for
that, since it would represent a programming error.

> >  
> > -		if (temp != pm_qos_req->value) {
> > -			pending_update = 1;
> > -			pm_qos_req->value = temp;
> > -		}
> > +	o = pm_qos_array[pm_qos_req->pm_qos_class];
> > +
> > +	if (new_value == PM_QOS_DEFAULT_VALUE)
> > +		temp = o->default_value;
> > +	else
> > +		temp = new_value;
> > +
> > +	if (temp != pm_qos_req->list.prio) {
> > +		pending_update = 1;
> > +		spin_lock_irqsave(&pm_qos_lock, flags);
> > +		plist_del(&pm_qos_req->list, &o->requests);
> > +		plist_node_init(&pm_qos_req->list, temp);
> >  		spin_unlock_irqrestore(&pm_qos_lock, flags);
> > -		if (pending_update)
> > -			update_target(pm_qos_req->pm_qos_class);
> >  	}
> > +	if (pending_update)
> > +		update_target(o, &pm_qos_req->list, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(pm_qos_update_request);
> >  
> > @@ -280,19 +278,15 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
> >   */
> >  void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
> >  {
> > -	unsigned long flags;
> > -	int qos_class;
> > +	struct pm_qos_object *o;
> >  
> >  	if (pm_qos_req == NULL)
> >  		return;
> >  		/* silent return to keep pcm code cleaner */
> 
> need a way to tell if the request is in the list or not so we don't
> crater removing a plist node that isn't in the list.

It won't: plist_del is idempotent, like list_del.  Of course, such a
programming error represents a bug and probably *should* be reported.

James
