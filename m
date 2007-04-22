From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sun, 22 Apr 2007 13:13:43 +0000
Message-ID: <20070422131343.GD4236@ucw.cz>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210841.18581.david-b@pacbell.net>
	<20070421214405.GA2758@elf.ucw.cz>
	<200704212005.55743.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704212005.55743.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-04-21 20:05:55, David Brownell wrote:
> On Saturday 21 April 2007, Pavel Machek wrote:
> > Hi!
> > 
> > > >  int suspend_enter(suspend_state_t state)
> > > >  {
> > > >  	int error = 0;
> > > > -	unsigned long flags;
> > > >  
> > > > -	local_irq_save(flags);
> > > > +	arch_s2ram_disable_irqs();
> > > 
> > > Sorry for not highlighting this before, but these are badly misnamed.
> > > They apply for every system suspend state except PM_SUSPEND_DISK ...
> > > NOT just suspend-to-ram, as specified by the function name.
> > 
> > Every suspend state means "standby" and "s2ram" in this context. I
> > think this name is better than alternatives.
> 
> Every suspend state is **NOT** s2ram though.
> 
> This is a very straightforward point.  A function that's
> called on non-S2RAM paths shouldn't be named as if it's
> only for S2RAM.

And the function that's called for s2ram+standby should not be named
as if it's also for swsusp...

> Ergo, those two functions are misnamed.  End of story.

...which is not only misnamed, it is also actively confusing. (And
someone _will_ ask me to call that function from swsusp, too.

...maybe we could solve it with a big fat comment?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
