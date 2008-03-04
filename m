From: David Brownell <david-b@pacbell.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Tue, 4 Mar 2008 12:30:41 -0800
Message-ID: <200803041230.42152.david-b__44368.5772632763$1204663022$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803041447090.15190-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803041447090.15190-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 March 2008, Alan Stern wrote:
> On Tue, 4 Mar 2008, David Brownell wrote:
> 
> > > I don't understand this comment.  Suppose a card was inserted while the 
> > > system was hibernating.  If the core didn't reprobe, when would that 
> > > card be discovered?
> > 
> > The host controller would tell the core to check for a card, exactly
> > like it does at all other times.
> 
> But how would the host controller know to do that?  Isn't card 
> insertion detection often driven by interrupts?  If a card is 
> inserted while the computer is off, no interrupt will be generated.

I'm talking about Real Suspend States (tm), not hibernation.
The systems in question tend to not support hibernation.

In particular:  system sleep states where IRQs work ... that's a
common way for non-x86 platforms to work.


> > That's the natural alternative to having the MMC core assume that card
> > detection was broken in low power states, so that the core needed to
> > forcibly remove the cards before suspend, and reprobe during resume
> > processing.
> 
> Is that the assumption the MMC core was really making?  Are you sure it 
> wasn't assuming something else (perhaps equally as bad)?

On the systems I was looking at, that assumption seems equivalent to
what the latest MMC core is assuming.  (I think this came as part of
the rewrite/refactoring a while back.)  But since the assumptions aren't
documented as such, you could say all guesses are equal.  ;)


> > Having the MMC core make such needless assumptions can cause problems
> > for the upper layers, including filesystems.
> 
> What's wrong with a superfluous probe at resume time, besides the waste 
> of a few milliseconds?

I'm more concerned with the undesirable removal of devices at suspend
time ... ones with mounted filesystems etc.

- Dave
