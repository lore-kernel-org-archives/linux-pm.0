From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: invoke suspend notifications after console
	switch
Date: Fri, 25 Jan 2008 07:43:16 +0000
Message-ID: <20080125074316.GA4134@ucw.cz>
References: <1197853799.4885.7.camel@johannes.berg>
	<20080111182042.GC4016@ucw.cz> <200801231607.46112.rjw@sisk.pl>
	<200801231903.30293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801231903.30293.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org


> > > > > triggered in any way by using the suspend notifications. This causes
> > > > > the system to lock up between X being needed to switch away from the
> > > > > VT and X already waiting for resume in the apm ioctl.
> > > > > 
> > > > > This patch moves the console switch (if enabled) before the suspend
> > > > > notification (and after the resume notification) to avoid this issue.
> > > > 
> > > > I don't see this in the suspend git tree yet, anything wrong with it?
> > > 
> > > Its pretty intrusive I'd say.
> 
> How so?  There's only one user of the suspend notifiers right now, AFAICS.

Ok... that and consistence with uswsusp makes it acceptable I guess.
Feel free to add my acked-by and sorry for noise.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
