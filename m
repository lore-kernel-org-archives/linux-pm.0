From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RC][PATCH -mm] PM: Prevent frozen user mode helpers
	from failing the freezing of tasks
Date: Sun, 24 Jun 2007 19:05:14 +0200
Message-ID: <20070624170514.GA21757__34312.4972693205$1182704831$gmane$org@elf.ucw.cz>
References: <200706221647.50509.rjw@sisk.pl> <20070622210750.GA4267@ucw.cz>
	<200706222347.55717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706222347.55717.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Special thanks to Uli Luckas <u.luckas@road.de> for reviewing the previous
> > > versions of this patch and for very useful comments.
> > ...
> > > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Eh, not sure this header is worth anything. Sometimes I'm lazy and
> > stop when I see first problem.
> > 
> > >  	switch (action) {
> > >  	case PM_HIBERNATION_PREPARE:
> > >  	case PM_SUSPEND_PREPARE:
> > >  		usermodehelper_disabled = 1;
> > > -		return NOTIFY_OK;
> > > +		retval = wait_event_timeout(running_helpers_waitq,
> > > +					atomic_read(&running_helpers) == 0,
> > 
> > Are you sure here? What happens when atomic variable changes between
> > the atomic_read and the function call?
> 
> Er, this is a macro. :-)
> 
> In fact we rely only on atomic_read(&running_helpers) being still zero after
> helper_finished() has woken us up, but I think that's acceptable.
> 
> IOW, if the wait_event_timeout() returns with retval different from zero, this
> means that atomic_read(&running_helpers) returned zero at one point after
> we'd set usermodehelper_disabled, which is enough.  OTOH, if it doesn't

Ok, can you write short comment explaining that? /* We have set
usermodehelper_disabled, so any new usermode helpers are not a problem
*/.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
