From: David Brownell <david-b@pacbell.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Tue, 4 Mar 2008 10:53:44 -0800
Message-ID: <200803041053.44909.david-b__12322.4020972431$1204658131$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803041252480.15190-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803041252480.15190-100000@iolanthe.rowland.org>
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
> > Or, as pointed out elsewhere, well-behaved MMC hosts ... which don't
> > need either such reprobing or the associated remove-on-suspend.
> 
> I don't understand this comment.  Suppose a card was inserted while the 
> system was hibernating.  If the core didn't reprobe, when would that 
> card be discovered?

The host controller would tell the core to check for a card, exactly
like it does at all other times.

That's the natural alternative to having the MMC core assume that card
detection was broken in low power states, so that the core needed to
forcibly remove the cards before suspend, and reprobe during resume
processing.

Having the MMC core make such needless assumptions can cause problems
for the upper layers, including filesystems.

- Dave
