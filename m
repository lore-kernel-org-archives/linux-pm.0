From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Thu, 31 May 2007 00:29:56 +0200
Message-ID: <20070530222956.GD27309__26853.5357587554$1180564248$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<20070530153740.GA4772@ucw.cz> <200705302244.25927.rjw@sisk.pl>
	<200705302311.40123.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705302311.40123.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > I think the rule should be: If you need to do something _before_ tasks are
> > frozen, do it in PM_PRE_FREEZE, but if you can do that after the tasks have
> > been frozen, do it on PM_HIBERNATION_PREPARE (or PM_SUSPEND_PREPARE in the
> > suspend case).
> 
> OTOH, having considered it for a while, I think that for now I can add just
> PM_PRE_FREEZE and PM_POST_THAW, as I don't have any user for the other ones.
> The other events may be added in the future if need be (along with some users).
> 
> I'll post revised patches in a new thread.

Yes please.

(Hmm, but you may create 4 of them PM_PRE_HIBERNATION, PM_PRE_SUSPEND,
PM_POST_HIBERNATION, PM_POST_SUSPEND -- I'd call all of them before
freeze and after thaw, but if we drop freezer for suspend, we won't
have to rename anything.)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
