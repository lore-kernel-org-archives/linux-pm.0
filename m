From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] PM: make freezer optional for suspend
Date: Sun, 18 Nov 2007 18:21:08 +0000
Message-ID: <20071118182107.GA5474@ucw.cz>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711142230.14662.rjw@sisk.pl>
	<1195145246.13846.68.camel@johannes.berg>
	<200711152124.25136.rjw@sisk.pl>
	<1195228712.8147.151.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1195228712.8147.151.camel@johannes.berg>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > It can't really. Things break. Ben and Paul just don't want to hear
> > > about it. I made it depend on BROKEN so people can take it out and see
> > > what breaks (to possibly fix it), and depend on ADB_PMU so they can have
> > > their favourite setting without enabling BROKEN.
> > 
> > I understand that, but it's a bit confusing to put ADB_PMU, which is specific
> > to powerpc, into the generic configuration file.
> 
> Alright, I'll give it some thought and repost later. Maybe
> ARCH_DOESNT_WANT_FREEZER ;)

What about just 

a) reverse the logic, so that it is C_SUSPEND_NO_FREEZER

b) hardcode it in ppc-specific config?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
