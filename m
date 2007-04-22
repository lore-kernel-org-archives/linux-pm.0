From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sun, 22 Apr 2007 13:09:49 +0000
Message-ID: <20070422130948.GC4236@ucw.cz>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
	<20070421214557.GB2758@elf.ucw.cz>
	<200704212010.51139.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704212010.51139.david-b@pacbell.net>
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

> > > system checkpoint/restore framework.  And even userspace makes
> > > that distinction clear, calling it "Hibernate" not "Suspend".
> > 
> > Gnome deciding to confuse their users is _their_ problem.
> 
> Hot news flash for Pavel:  "hibernate" is much more widely used
> and understood than "software suspend".  Everyone using Windows
> has already been trained in what it means.  But even today lots
> of folk scratch their heads at "software suspend" ... "gee, isn't
> all suspending done by software?"

Well, in apm case it is firmware, not software. That's how the name
was born.

> > > I feel a Kconfig patch coming on ... ;)
> > 
> > I do not think confusion from a change is worth the benefit.
> 
> Glad you waited to see the patch before you objected!

Uf I thought you were going to
s/CONFIG_SOFTWARE_SUSPEND/CONFIG/HIBERNATION/ over the kernel, and
wanted to spare you some time.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
