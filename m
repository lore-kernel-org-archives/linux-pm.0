From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 23:47:05 +0200
Message-ID: <20070421214705.GC2758@elf.ucw.cz>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704210955.11351.david-b@pacbell.net>
	<1177174861.5941.26.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
	<1177177763.5941.28.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177177763.5941.28.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-04-21 19:49:23, Johannes Berg wrote:
> On Sat, 2007-04-21 at 10:06 -0700, David Brownell wrote:
> 
> > And even userspace makes
> > that distinction clear, calling it "Hibernate" not "Suspend".
> 
> But that was quite a fight, at least in the gnome camp ;)

Yep. Maybe we'll want to change "suspend to ram -> suspend", "swsusp
-> hibernate" one day, but it will be big and ugly patch confusing
everyone, and I do not think that day is close.

> > I feel a Kconfig patch coming on ... ;)
> 
> Not from me. But you'll get an updated one for this :)

Please don't. Original patch is fine.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
