From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Thu, 6 Mar 2008 16:55:53 +0100
Message-ID: <20080306155553.GA3908__12557.3170990267$1204835138$gmane$org@ucw.cz>
References: <200803041230.42152.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0803041558070.15986-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0803041558070.15986-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-03-04 16:00:51, Alan Stern wrote:
> On Tue, 4 Mar 2008, David Brownell wrote:
> 
> > > What's wrong with a superfluous probe at resume time, besides the waste 
> > > of a few milliseconds?
> > 
> > I'm more concerned with the undesirable removal of devices at suspend
> > time ... ones with mounted filesystems etc.
> 
> On that we can agree.  The removal is done if the host doesn't define a 
> resume method.  There doesn't seem to be any point to that, given that 
> the probing during resume will determine whether a card has in fact 
> been removed.

Hmm, if the driver is sleeping too deeply, user might have removed the
card and put in different one, without driver noticing. That would be
_bad_.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
