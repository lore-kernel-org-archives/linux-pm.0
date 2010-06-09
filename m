From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Tue, 8 Jun 2010 19:42:09 -0700
Message-ID: <20100609024209.GB26668@gvim.org>
References: <1275760688.7227.10.camel@mulgrave.site>
	<20100606213954.GD8610@gvim.org> <20100608133157.GA26668@gvim.org>
	<1276012336.4344.7.camel@mulgrave.site>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1276012336.4344.7.camel@mulgrave.site>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 08, 2010 at 11:52:16AM -0400, James Bottomley wrote:
> On Tue, 2010-06-08 at 06:31 -0700, mark gross wrote:
> > On Sun, Jun 06, 2010 at 02:39:54PM -0700, mark gross wrote:
> > > On Sat, Jun 05, 2010 at 12:58:08PM -0500, James Bottomley wrote:
> > > > A lot of the pm_qos extremal value handling is really duplicating what a
> > > > priority ordered list does, just in a less efficient fashion.  Simply
> > > > redoing the implementation in terms of a plist gets rid of a lot of this
> > > > junk (although there are several other strange things that could do with
> > > > tidying up, like pm_qos_request_list has to carry the pm_qos_class with
> > > > every node, simply because it doesn't get passed in to
> > > > pm_qos_update_request even though every caller knows full well what
> > > > parameter it's updating).
> > > > 
> > > > I think this redo is a win independent of android, so we should do
> > > > something like this now.
> > > > 
> > > > There is one nasty that should probably be fixed in plists not open
> > > > coded here: plist_first gives the highest priority value, but there's no
> > > > corresponding API to give the lowest (even though you can get it from
> > > > the head.nodes_list.prev) ... if the sched people are OK, I'll correct
> > > > this with the final patch set.
> > > > 
> > > > James
> > > > 
> > > > ---
> > > > 
> > > >  kernel/pm_qos_params.c |  152 +++++++++++++++++++++++-------------------------
> > > >  1 files changed, 73 insertions(+), 79 deletions(-)
> > > > 
> > > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > > index f42d3f7..241fa79 100644
> > > > --- a/kernel/pm_qos_params.c
> > > > +++ b/kernel/pm_qos_params.c
> > > > @@ -30,6 +30,7 @@
> > > >  /*#define DEBUG*/
> > 
> > snip
> > 
> > > > @@ -251,22 +244,27 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> > > >  	unsigned long flags;
> > > >  	int pending_update = 0;
> > > >  	s32 temp;
> > > > +	struct pm_qos_object *o;
> > > >  
> > > > -	if (pm_qos_req) { /*guard against callers passing in null */
> > > > -		spin_lock_irqsave(&pm_qos_lock, flags);
> > > > -		if (new_value == PM_QOS_DEFAULT_VALUE)
> > > > -			temp = pm_qos_array[pm_qos_req->pm_qos_class]->default_value;
> > > > -		else
> > > > -			temp = new_value;
> > > > +	if (!pm_qos_req) /*guard against callers passing in null */
> > > > +		return;
> > > 
> > > need a better test to see if the pm_qos_req is in the plist or not as we
> > > move to a caller allocated design.
> > >
> > 
> > snip  
> > > >  void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
> > > >  {
> > > > -	unsigned long flags;
> > > > -	int qos_class;
> > > > +	struct pm_qos_object *o;
> > > >  
> > > >  	if (pm_qos_req == NULL)
> > > >  		return;
> > > >  		/* silent return to keep pcm code cleaner */
> > > 
> > > need a way to tell if the request is in the list or not so we don't
> > > crater removing a plist node that isn't in the list.
> > > 
> > snip
> > >
> > 
> > I found that e1000e will panic on rmmod because of it attempting to
> > removing of a pm_qos request that it never added.
> > 
> > This is an ugly patch, but I think its needed for a while to clean out
> > the abusers, then it can be updated to not be so noisy.
> > 
> > 
> > --mgross
> > 
> > --Signed-off-by: mark gross <markgross@thegnar.org>
> > 
> > 
> > 
> > >From fb713f95b83ea3744c31917cfd019bf3e32349b3 Mon Sep 17 00:00:00 2001
> > From: markgross <markgross@thegnar.org>
> > Date: Tue, 8 Jun 2010 06:22:01 -0700
> > Subject: [PATCH] check and complain about abuse of the api to avoid panics
> > 
> > ---
> >  kernel/pm_qos_params.c |   12 +++++++++++-
> >  1 files changed, 11 insertions(+), 1 deletions(-)
> > 
> > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > index f1d3d23..4bded27 100644
> > --- a/kernel/pm_qos_params.c
> > +++ b/kernel/pm_qos_params.c
> > @@ -212,7 +212,7 @@ void pm_qos_add_request(struct pm_qos_request_list *dep,
> >  	int new_value;
> >  
> >  	if (pm_qos_request_active(dep))
> > -		return;
> > +		return; /* already in the list */
> >  
> >  	if (value == PM_QOS_DEFAULT_VALUE)
> >  		new_value = o->default_value;
> > @@ -244,6 +244,11 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
> >  
> >  	if (!pm_qos_req) /*guard against callers passing in null */
> >  		return;
> > +	if (!pm_qos_request_active(pm_qos_req)) {
> > +		WARN(true, "pm_qos: update to an unregistered request");
> > +		dump_stack();
> > +		return;
> > +	}
> >  
> >  	o = pm_qos_array[pm_qos_req->pm_qos_class];
> >  
> > @@ -279,6 +284,11 @@ void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
> >  	if (pm_qos_req == NULL)
> >  		return;
> >  		/* silent return to keep pcm code cleaner */
> > +	if (!pm_qos_request_active(pm_qos_req)) {
> > +		WARN(true, "pm_qos: removal an unregistered request");
> > +		dump_stack();
> > +		return;
> > +	}
> 
> Yes, that would more or less reflect current functionality.  If it's the
> intention of the API to silently ignore update and removal of
> unregistered requests, then it should probably be done silently,
> though ... otherwise we'll start to make noise where previously there
> was none.
> 
> James
The intention of the API was not to silently ignore bogus updates and
removals, even though the initial implementation implemented that :(

I recommend we start making the noise and fix the API to return failure
when updating an un-registered qos request.  

Silently failing on removal may be still needed, but a Warn-once would
be in order.

I had planned to start making that API change before this plist stuff,
but I think for now adding the noise and getting the plist stuff good,
then tackling the slight API change is the order I would like to see
things happen.

what do you think?

--mgross
