From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.22-rc2 built on ppc (1)
Date: Sat, 9 Jun 2007 16:14:21 +0200
Message-ID: <20070609141421.GC3397@elf.ucw.cz>
References: <20070520110625.GC3253@aragorn.home.lxtec.de>
	<200705201336.05205.rjw@sisk.pl>
	<1179661437.3590.11.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1179661437.3590.11.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org, Elimar Riesebieter <riesebie@lxtec.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > kernel/power/swsusp.c: In function 'swsusp_show_speed':
> > > kernel/power/swsusp.c:193: warning: comparison of distinct pointer types lacks a cast
> > 
> > Well, this warning doesn't make sense.  In 2.6.22-rc2 line 193 of swsusp.c is
> > 
> > do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
> > 
> > where elapsed_centisecs64 is s64.
> 
> yeah, and the do_div64 macro is then comparing (s64*) == (u64*) in a
> null-statement and tells you that the types are different. I tracked
> this a long time ago and figured it wasn't worth thinking about.

Elimar, can you modify the code to 

do_div(elapsed_centisecs64, (s64) NSEC_PER_SEC / 100);

...to see if the warning goes away?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
