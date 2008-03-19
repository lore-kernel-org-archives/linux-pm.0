From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation patchset against -rc6)
Date: Wed, 19 Mar 2008 22:56:24 +0100
Message-ID: <200803192256.25347.rjw__27126.2020724409$1205964248$gmane$org@sisk.pl>
References: <200803172317.33745.rjw@sisk.pl> <20080319205812.GC1811@elf.ucw.cz>
	<200803192243.14520.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803192243.14520.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 19 of March 2008, Rafael J. Wysocki wrote:
> On Wednesday, 19 of March 2008, Pavel Machek wrote:
> > On Wed 2008-03-19 23:35:10, Alexey Starikovskiy wrote:
> > > Pavel Machek wrote:
> > >> Hi!
> > >>
> > >>>> Ok, 7c0... is innocent. Reverting not only the mdelay, but also rest
> > >>>> of drivers/acpi/ec.c patch fixed the
> > >>>> "rc6-breaks-backlight-in-X-over-lid-close", good.
> > >>> Can you clarify a bit?
> > >>>
> > >>> Do you mean that the full revert of 2c81ce4 that already got committed is 
> > >>> sufficient for you, or do you need to totally undo everything we've done 
> > >>> to ec.c since -rc5, and thus also to revert the _other_ revert we did (in 
> > >>> 4af8e10a6c57e7292862bd1703712f0565c7e429)?
> > >>
> > >> I did some more testing, and realized I was wrong. We need to totally
> > >> undo everything we've done to ec.c since -rc5... (that has small
> > >> sideffect of brightness up/down keys no longer working -- regression
> > >> since 2.6.24, but saves us from "backlight gone after
> > >> closing/reopening lid" which is _NASTY_ regression from 2.6.25-rc5).
> > >>
> > >> ACPI sucks.
> > >>
> > >> I.e. this patch:
> > >>
> > >>
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
> Pavel,
> 
> Can you text the current -git (preferably without anything on top) pretty please?

s/text/test/  (sorry)

Rafael
