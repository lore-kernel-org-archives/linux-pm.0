From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 22:57:29 +0100
Message-ID: <20080319215729.GF1811__46318.8007743613$1205964356$gmane$org@elf.ucw.cz>
References: <200803172317.33745.rjw@sisk.pl> <47E178FE.6050500@suse.de>
	<20080319205812.GC1811@elf.ucw.cz> <200803192243.14520.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803192243.14520.rjw@sisk.pl>
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
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org


> > >> Revert ec.c to 2.6.25-rc5 state:
> > >>
> > >> * this fixes backlight after closing/reopening the lid while in X on
> > >> thinkpad x60
> > >>
> > >> * unfortunately it breaks fn-home/end keyboard brightness control
> > > It should also break volume up/down/mute keys. Essentially all the keys on Thinkpad.
> > > And it would also be regression to 2.6.24 level.
> > 
> > As I explained above.
> > 
> > Unfortunately, applying this means I loose screen as soon as I
> > close/reopen lid. 2.6.24 did not behave like that. And it makes my
> > machine mostly unusable -- as soon as you try to carry it away, you
> > loose video. BAD.
> 
> Can you text the current -git (preferably without anything on top) pretty please?

Did anything relevant change in the last 8 hours or so? My scripts
tell me there's nothing to pull:

Done counting 441 objects.
Result has 304 objects.
Deltifying 304 objects.
 100% (304/304) done
Total 304, written 304 (delta 236), reused 121 (delta 75)
Fetching pack (head and objects)...
Fetching tags...
Up to date.

Applying changes...
Branch already fully merged.
pavel@amd:~$ 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
