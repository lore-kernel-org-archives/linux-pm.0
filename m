From: David Brownell <david-b@pacbell.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Mon, 3 Mar 2008 13:59:37 -0800
Message-ID: <200803031359.38263.david-b__44536.5698695698$1204581801$gmane$org@pacbell.net>
References: <200802241500.41969.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0802240941440.29504-100000@netrider.rowland.org>
	<20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
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
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 25 February 2008, Pierre Ossman wrote:
> On Sun, 24 Feb 2008 10:33:34 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > But even changing that won't solve the second issue, which is a genuine
> > bug.  There is a race between detect events and suspend events.  The
> > mmc_suspend_host() routine starts out by flushing the kmmcd workqueue
> > before calling the host's suspend routine.  So what happens if another
> > detect event occurs in between?
> > 
> 
> The idea is that host drivers shouldn't do that. Once they've called
> mmc_suspend_host(), then they shouldn't be poking the MMC core in any
> other way. None of this is of course properly documented. :/

Card insert/remove events can be system wake events though.  Which
makes that restriction impractical.

I think hosts need to be able to call mmc_detect_change() as soon as
they see a stable signal.  The MMC core can hold off handling that
for a while, if it needs to wait until the code walking the device
tree gets around to resuming that host.  It's a lot more natural to
hold off such stuff one time there than in N host drivers; especially
since the MMC core already has such hold-off code.

- Dave
