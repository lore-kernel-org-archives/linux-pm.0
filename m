From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.21 suspend-to-disk regression
Date: Wed, 2 May 2007 11:20:06 +0200
Message-ID: <20070502092006.GB10245@elf.ucw.cz>
References: <f129n6$mro$1@sea.gmane.org> <200704291832.15959.rjw@sisk.pl>
	<200704301434.10008.marcus@better.se>
	<200704301621.11826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704301621.11826.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Rafael J. Wysocki wrote:
> > > Can you please apply the appended patch and see if that helps?
> > 
> > A second attempt also succeeded, so I think it's an improvement at least.
> 
> OK, so please run with it applied for a while to make sure it helps.
> 
> Ugh, we seem to have a problem with the code ordering in which
> platform_finish() goes before device_resume(), at least in the hibernation
> (aka s2disk) case.

Was not platform_finish before device_resume requirement for MSI
interrupts working?

> This is the second report confirming that the change of this ordering has fixed
> the a suspend problem, but the change of this ordering is intrusive, so I was
> afraid to do it before 2.6.21.  Can we try to change it now?

I guess so.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
