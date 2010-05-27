From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 18:52:58 +0100
Message-ID: <20100527175258.GB3543__19781.9109111608$1274983223$gmane$org@srcf.ucam.org>
References: <20100527170740.GA1980@srcf.ucam.org>
	<1274980391.27810.5552.camel@twins>
	<20100527171644.GA2468@srcf.ucam.org>
	<1274980856.27810.5582.camel@twins>
	<20100527172510.GC2468@srcf.ucam.org>
	<1274981288.27810.5609.camel@twins>
	<20100527173218.GF2468@srcf.ucam.org>
	<1274981750.27810.5641.camel@twins>
	<20100527174140.GB3187@srcf.ucam.org>
	<1274982397.27810.5679.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274982397.27810.5679.camel@twins>
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

On Thu, May 27, 2010 at 07:46:37PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 18:41 +0100, Matthew Garrett wrote:
> > On Thu, May 27, 2010 at 07:35:50PM +0200, Peter Zijlstra wrote:
> > > Then that's an application bug right there, isn't it?
> > > 
> > > If should have listened to the window server telling its clients it was
> > > going to go away. Drawing after you get that is your own damn fault ;-)
> > 
> > How long do you wait for applications to respond that they've stopped 
> > drawing? What if the application is heavily in swap at the time?
> 
> Since we're talking about a purely idle driven power saving, we wait
> until the cpu is idle.

If that's what you're aiming for then you don't need to block 
applications on hardware access because they should all already have 
idled themselves.

> Note that it doesn't need to broadcast this, it could opt to reply with
> that message on the first drawing attempt after it goes away and block
> on the second.

That's more interesting, but you're changing semantics quite heavily at 
this point.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
