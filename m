From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Tue, 4 Mar 2008 10:58:41 +0100
Message-ID: <20080304105841.6c951665__47204.9223761589$1204624922$gmane$org@mjolnir.drzeus.cx>
References: <200802241500.41969.rjw@sisk.pl>
	<200803031359.38263.david-b@pacbell.net>
	<20080304070357.61ee825b@mjolnir.drzeus.cx>
	<200803040144.09601.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803040144.09601.david-b@pacbell.net>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008 01:44:09 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Monday 03 March 2008, Pierre Ossman wrote:
> > On Mon, 3 Mar 2008 13:59:37 -0800
> > David Brownell <david-b@pacbell.net> wrote:
> > 
> > > 
> > > Card insert/remove events can be system wake events though.  Which
> > > makes that restriction impractical.
> 
> This part seems to be ignored by your comment ... wake events.
>

How so? How is a wake caused by the MMC controller different than any other source?

> 
> That is, the MMC core doesn't understand wakeup events.
> 
> Or, as pointed out elsewhere, well-behaved MMC hosts ... which don't
> need either such reprobing or the associated remove-on-suspend.
> 

You need well behaved _systems_, not just hosts to achieve that guarantee. SDHCI controllers have the ability to wake up the system on card removal, but there is zero guarantee that the platform actually wired the controller up in a way that actually allows it to do this. Throw suspend to disk, where the system might completely lose power, into the mix and you're completely screwed.

So for the default behaviour to change, we need one of two things:

- Certainty that removals cannot go unnoticed. (even then, you also need wakeup latency guarantees)
- Ability to detect a removal after the fact.

For the general case, the first one is impossible given todays hardware. The second might be solvable, but noone has done the work.

(If your complete system can satisfy the first option, feel free to add the "unsafe" option to you defconfig, but that is hardly adequate reason to have it on by default.)

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
