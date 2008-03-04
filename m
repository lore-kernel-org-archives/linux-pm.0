From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Tue, 4 Mar 2008 12:50:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803041245460.15190-100000@iolanthe.rowland.org>
References: <200803031359.38263.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803031359.38263.david-b@pacbell.net>
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

On Mon, 3 Mar 2008, David Brownell wrote:

> Card insert/remove events can be system wake events though.  Which
> makes that restriction impractical.
> 
> I think hosts need to be able to call mmc_detect_change() as soon as
> they see a stable signal.  The MMC core can hold off handling that
> for a while, if it needs to wait until the code walking the device
> tree gets around to resuming that host.  It's a lot more natural to
> hold off such stuff one time there than in N host drivers; especially
> since the MMC core already has such hold-off code.

That's what ended up happening.  The workqueue used by
mmc_detect_change() was made freezable, so hosts could call the routine
at any time but it wouldn't do anything until the system sleep was
over.

A more flexible approach would avoid freezing the workqueue, and allow 
it to process card removals at any time.  But card insertions would be 
ignored if the mmc_host device was suspended; at resume time the core 
probes for changes that occurred during the sleep.

Alan Stern
