From: David Brownell <david-b@pacbell.net>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Tue, 4 Mar 2008 01:44:09 -0800
Message-ID: <200803040144.09601.david-b__14595.1273655102$1204624053$gmane$org@pacbell.net>
References: <200802241500.41969.rjw@sisk.pl>
	<200803031359.38263.david-b@pacbell.net>
	<20080304070357.61ee825b@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304070357.61ee825b@mjolnir.drzeus.cx>
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

On Monday 03 March 2008, Pierre Ossman wrote:
> On Mon, 3 Mar 2008 13:59:37 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > 
> > Card insert/remove events can be system wake events though.  Which
> > makes that restriction impractical.

This part seems to be ignored by your comment ... wake events.


> > I think hosts need to be able to call mmc_detect_change() as soon as
> > they see a stable signal.  The MMC core can hold off handling that
> > for a while, if it needs to wait until the code walking the device
> > tree gets around to resuming that host.  It's a lot more natural to
> > hold off such stuff one time there than in N host drivers; especially
> > since the MMC core already has such hold-off code.
> > 
> 
> That actually sorts itself out as the MMC core reprobes on wakeup, but
> I see your point. Right now things will work peachy if the controllers
> just make sure to disable their card detection logic before telling the
> core to suspend.   

That is, the MMC core doesn't understand wakeup events.

Or, as pointed out elsewhere, well-behaved MMC hosts ... which don't
need either such reprobing or the associated remove-on-suspend.

- Dave
