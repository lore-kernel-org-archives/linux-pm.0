From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 9 May 2009 15:03:38 +0200
Message-ID: <20090509130338.GB10859__43469.1235925586$1241874361$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507215112.GC14611@elf.ucw.cz>
	<1241746459.19600.246.camel@nigel-laptop>
	<200905081611.41865.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905081611.41865.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Actually, I see advantages of working together versus fighting flame wars.
> > > > Please stop that, I'm not going to take part in it this time.
> > > 
> > > Ok, so what do you propose? Merging tuxonice into 2.6.32, resulting in
> > > having swsusp,uswsusp *and* tuxonice to maintain? I hope not.
> > > 
> > > If we are talking about improving mainline to allow tuxonice
> > > functionality... then yes, that sounds reasonable.
> > 
> > I'd like to see use have all three for one or two releases of vanilla,
> > just to give time to work out any issues that haven't been foreseen.
> > Once we're all that there are confident there are no regressions with
> > TuxOnIce, I'd remove swsusp. That's my ideal plan of attack.
> 
> So this is an idea to replace our current hibernation implementation with
> TuxOnIce.
> 
> Which unfortunately I don't agree with.
> 
> I think we can get _one_ implementation out of the three, presumably keeping
> the user space interface that will keep the current s2disk binaries happy, by
> merging TuxOnIce code _gradually_.  No "all at once" approach, please.
> 
> And by "merging" I mean _exactly_ that.  Not adding new code and throwing
> away the old one.
> 
> While I can work on creating one hibernation implementation by taking the
> best ideas from all of the implementation we have at hand, I surely won't be
> working on replacing our current code with TuxOnIce.  If that disappoints you,
> then I'm sorry.

FWIW, I agree with Rafael here. Improving the current code in
reasonable steps is the way to go.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
