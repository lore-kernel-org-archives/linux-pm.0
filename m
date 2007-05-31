From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/3] PM: Hibernation and suspend
	notifiers
Date: Thu, 31 May 2007 16:23:57 +0200
Message-ID: <20070531142357.GK27309__18483.0733611763$1180621488$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0705281155270.22682-100000@netrider.rowland.org>
	<200705302311.40123.rjw@sisk.pl>
	<1180563897.6777.11.camel@nigel.suspend2.net>
	<200705310744.44488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705310744.44488.rjw@sisk.pl>
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

> > > I'll post revised patches in a new thread.
> > 
> > I haven't been giving this much attention, so forgive me if I'm about to
> > ask a silly question... which notifiers would you see the avenrun
> > saving/restoring using?
> 
> I'm not sure what you mean.  Could you please clarify?

Remember that patch about saving/restoring "load average"? I guess
Nigel asks where to hook it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
