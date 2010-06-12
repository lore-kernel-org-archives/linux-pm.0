From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 12 Jun 2010 18:10:13 +0100
Message-ID: <20100612171013.GA3151__7296.36878609217$1276362709$gmane$org@sirena.org.uk>
References: <1276268539.2862.92.camel@mulgrave.site>
	<Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1006111638040.19894-100000@netrider.rowland.org>
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
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 11, 2010 at 04:48:15PM -0400, Alan Stern wrote:
> On Fri, 11 Jun 2010, Mark Brown wrote:

> > The clock framework is implemented independantly for each CPU.

> That's not an impediment, since drivers' requirements regarding which 
> clocks remain running in which power states are necessarily 
> platform-dependent also.

It does mean that you can't make any general statements about what the
clock framework does and doesn't do which is what the person I was
replying to (the quoting you did as you cut'n'pasted replies to multiple
messages seems more than a little confused, sorry) seemed to want.
