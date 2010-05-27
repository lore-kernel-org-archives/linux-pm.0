From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:29:13 +0100
Message-ID: <20100527182913.GO3543__20678.3488313251$1274985822$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<1274982779.27810.5708.camel@twins>
	<20100527175719.GD3543@srcf.ucam.org>
	<1274983333.27810.5744.camel@twins>
	<20100527181433.GG3543@srcf.ucam.org>
	<1274984291.27810.5802.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274984291.27810.5802.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 08:18:11PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 19:14 +0100, Matthew Garrett wrote:
> > If I get a WoL 
> > packet in the 0.5 of a second between userspace deciding to suspend and 
> > actually doing so, the system shouldn't suspend. 
> 
> Please re-read Thomas' description of how a driver should do the state
> transition.
>
> So either we get the packet before suspend, and we cancel the suspend,
> or we get it after and we wake up. What's the problem, and how does that
> need suspend blockers?

In order to cancel the suspend we need to keep track of whether 
userspace has consumed the event and reacted appropriately. Since we 
can't do this with the process scheduler, we end up with something that 
looks like suspend blockers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
