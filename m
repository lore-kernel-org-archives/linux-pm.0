From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Thu, 17 May 2007 09:28:09 +0000
Message-ID: <20070517092809.GA4608@ucw.cz>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
	<200705161534.42740.rjw@sisk.pl>
	<200705171044.26662.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705171044.26662.marcus@better.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > my Thinkpad R60 (x86_64, SMP, XFS) has failed to resume from RAM twice,
> > >
> > > I should probably add that I have applied the Rafael's patch [1] for the
> > > suspend-to-disk issue.
> >
> > Please revert it.  It's a debug-only patch and it fiddles with too many
> > things.
> 
> Ok, so the resume-from-RAM problem appears on 2.6.22-rc1, but not on 2.6.20, 
> and probably not in 2.6.21. I may try to bisect it if I can find some time...
> 
> Also, it works correctly with "init=/bin/sh", but not when booting 
> with "single". Perhaps a driver issue?

Sounds so. Try to locate which driver.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
