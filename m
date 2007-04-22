From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 20:05:55 -0700
Message-ID: <200704212005.55743.david-b@pacbell.net>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210841.18581.david-b@pacbell.net>
	<20070421214405.GA2758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070421214405.GA2758@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 April 2007, Pavel Machek wrote:
> Hi!
> 
> > >  int suspend_enter(suspend_state_t state)
> > >  {
> > >  	int error = 0;
> > > -	unsigned long flags;
> > >  
> > > -	local_irq_save(flags);
> > > +	arch_s2ram_disable_irqs();
> > 
> > Sorry for not highlighting this before, but these are badly misnamed.
> > They apply for every system suspend state except PM_SUSPEND_DISK ...
> > NOT just suspend-to-ram, as specified by the function name.
> 
> Every suspend state means "standby" and "s2ram" in this context. I
> think this name is better than alternatives.

Every suspend state is **NOT** s2ram though.

This is a very straightforward point.  A function that's
called on non-S2RAM paths shouldn't be named as if it's
only for S2RAM.

Ergo, those two functions are misnamed.  End of story.

- Dave
