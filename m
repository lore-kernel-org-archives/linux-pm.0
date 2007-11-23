From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Freezer: Fix s2disk resume from initrd
	(rev. 2)
Date: Fri, 23 Nov 2007 13:21:33 +0100
Message-ID: <20071123122133.GB2055@elf.ucw.cz>
References: <200711212322.02340.rjw@sisk.pl> <200711212325.32964.rjw@sisk.pl>
	<20071122095059.GA9860@elf.ucw.cz> <200711221709.21175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711221709.21175.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Chris Friedhoff <chris@friedhoff.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > +	/*
> > > +	 * In case that a resume from disk is carried out by linuxrc or one of
> > > +	 * its children, we need to tell the freezer not to wait for us.
> > > +	 */
> > > +	current->flags |= PF_FREEZER_SKIP;
> > > +
> > >  	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
> > >  	if (pid > 0)
> > > -		while (pid != sys_wait4(-1, NULL, 0, NULL)) {
> > > -			try_to_freeze();
> > > +		while (pid != sys_wait4(-1, NULL, 0, NULL))
> > >  			yield();
> > > -		}
> > > +
> > > +	current->flags &= ~PF_FREEZER_SKIP;
> > 
> > New code should work (but it is uglier than the old one).
> 
> Well, the old code plain doesn't work ...
> 
> > What was wrong with the old one? Refrigerator should make sys_wait4() return,
> 
> It doesn't, because the task as no mm and is therefore considered as a kernel
> thread and not sent a signal.
> 
> This _really_ is an exceptional case.

Ok, ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
