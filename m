From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:17:58 +0100
Message-ID: <20100527181758.GJ3543__29577.9845481322$1274985762$gmane$org@srcf.ucam.org>
References: <20100527172510.GC2468@srcf.ucam.org>
	<1274981288.27810.5609.camel@twins>
	<20100527173218.GF2468@srcf.ucam.org>
	<1274981750.27810.5641.camel@twins>
	<20100527174140.GB3187@srcf.ucam.org>
	<1274982397.27810.5679.camel@twins>
	<20100527175258.GB3543@srcf.ucam.org>
	<1274982981.27810.5719.camel@twins>
	<20100527175920.GE3543@srcf.ucam.org>
	<1274983598.27810.5761.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274983598.27810.5761.camel@twins>
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

On Thu, May 27, 2010 at 08:06:38PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 18:59 +0100, Matthew Garrett wrote:
> > On Thu, May 27, 2010 at 07:56:21PM +0200, Peter Zijlstra wrote:
> > > On Thu, 2010-05-27 at 18:52 +0100, Matthew Garrett wrote:
> > > 
> > > > If that's what you're aiming for then you don't need to block 
> > > > applications on hardware access because they should all already have 
> > > > idled themselves.
> > > 
> > > Correct, a well behaved app would have. I thought we all agreed that
> > > well behaved apps weren't the problem?
> > 
> > Ok. So the existing badly-behaved application ignores your request and 
> > then gets blocked. And now it no longer responds to wakeup events. 
> 
> It will, when it gets unblocked from whatever thing it got stuck on.

It's blocked on the screen being turned off. It's supposed to be reading 
a network packet. How does it ever get to reading the network packet?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
