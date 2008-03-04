From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Tue, 4 Mar 2008 14:51:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803041447090.15190-100000__20922.4312370226$1204660551$gmane$org@iolanthe.rowland.org>
References: <200803041053.44909.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803041053.44909.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008, David Brownell wrote:

> > I don't understand this comment.  Suppose a card was inserted while the 
> > system was hibernating.  If the core didn't reprobe, when would that 
> > card be discovered?
> 
> The host controller would tell the core to check for a card, exactly
> like it does at all other times.

But how would the host controller know to do that?  Isn't card 
insertion detection often driven by interrupts?  If a card is 
inserted while the computer is off, no interrupt will be generated.

> That's the natural alternative to having the MMC core assume that card
> detection was broken in low power states, so that the core needed to
> forcibly remove the cards before suspend, and reprobe during resume
> processing.

Is that the assumption the MMC core was really making?  Are you sure it 
wasn't assuming something else (perhaps equally as bad)?

> Having the MMC core make such needless assumptions can cause problems
> for the upper layers, including filesystems.

What's wrong with a superfluous probe at resume time, besides the waste 
of a few milliseconds?

Alan Stern
