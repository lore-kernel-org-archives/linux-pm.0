From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 23:45:57 +0200
Message-ID: <20070421214557.GB2758@elf.ucw.cz>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210955.11351.david-b@pacbell.net>
	<1177174861.5941.26.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704211006.58857.david-b@pacbell.net>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Or maybe arch_suspend_disable_irqs() ... there are PM
> > > operations that don't involve system suspend states.
> > 
> > Yeah, probably better and I'm fine with that, but the crowd who screamed
> > when I noted that CONFIG_SOFTWARE_SUSPEND had nothing to do with suspend
> > states might be confused... It should be obvious that this isn't called
> > for suspend to disk.
> 
> Yeah, but SOFTWARE_SUSPEND is also a misnomer.  It's more of a

Well, that's the way it is. "suspend" == s2ram, standby, swsusp,
swsusp+S4 in kernel context.

> system checkpoint/restore framework.  And even userspace makes
> that distinction clear, calling it "Hibernate" not "Suspend".

Gnome deciding to confuse their users is _their_ problem.

> I feel a Kconfig patch coming on ... ;)

I do not think confusion from a change is worth the benefit.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
