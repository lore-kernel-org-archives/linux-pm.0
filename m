From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 3/3] pm_qos: only schedule work when in
 interrupt context
Date: Thu, 17 Jun 2010 18:02:25 -0500
Message-ID: <1276815745.7398.359.camel__4504.05838569186$1276815800$gmane$org@mulgrave.site>
References: <1276266352.2862.70.camel@mulgrave.site>
	<1276526800-12362-3-git-send-email-florian@mickler.org>
	<20100615192347.761f427a@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615192347.761f427a@schatten.dmk.lab>
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
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-06-15 at 19:23 +0200, Florian Mickler wrote:
> Hi James!
> 
> On Mon, 14 Jun 2010 16:46:40 +0200
> florian@mickler.org wrote:
> 
> > With this patch we only schedule the work when in interrupt context.
> > 
> > Before update_request was callable from interrupt-context there was a
> > 1:1 relation between a change in the request-value and a notification.
> > This patch restores that behaviour for all constraints that have update_request
> > never called from interrupt context.
> > 
> > The notifier mutex serializes calls to blocking_notifier_call_chain, so
> > that we are serialized against any pending or currently executing notification.
> > 
> > Signed-off-by: Florian Mickler <florian@mickler.org>
> > ---
> >  kernel/pm_qos_params.c |   10 +++++++---
> >  1 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > index 9346906..c06cae9 100644
> > --- a/kernel/pm_qos_params.c
> > +++ b/kernel/pm_qos_params.c
> > @@ -152,11 +152,15 @@ static s32 min_compare(s32 v1, s32 v2)
> >  static void pm_qos_call_notifiers(struct pm_qos_object *o,
> >  				  unsigned long curr_value)
> >  {
> > -	schedule_work(&o->notify);
> > -
> >  	if (o->atomic_notifiers)
> >  		atomic_notifier_call_chain(o->atomic_notifiers,
> > -					   curr_value, NULL);
> > +				(unsigned long) curr_value, NULL);
> > +
> > +	if (in_interrupt()) 
> > +		schedule_work(&o->notify);
> > +	else 
> > +		blocking_notifier_call_chain(o->blocking_notifiers, 
> > +				(unsigned long) curr_value, NULL);
> >  }
> >  
> >  static void update_notify(struct work_struct *work)
> 
> What about this? Is this ok? I don't know if it is benign to use
> in_interrupt() here. I took this idea from the
> execute_in_process_context() implementation. 

I think it will work ... but I still think it's over complex given the
listed requirements (android seems to only want atomic notifiers from
atomic contexts).

> If this is ok, should I rebase them on your two pm_qos patches (plists
> and the kzalloc removal)? 

Well, I would say yes.  However, for more impartial advice, I'd wait and
see what the pm maintainers want.

> Did you already thought about some debugging stuff that would suffice
> the android needs? I kind of thought about either registerieng some
> notifier callback or using the perf/tracing infrastructure. 
> But I have not looked into it yet.

I was just going to try the conversion when the wakelocks stuff was
finally in and see if it worked in an android kernel.

James
