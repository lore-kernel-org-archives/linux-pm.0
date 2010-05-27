From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 17:26:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271724430.3239-100000__24496.4590682232$1274995604$gmane$org@iolanthe.rowland.org>
References: <20100527203843.GA8395@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527203843.GA8395@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010, Matthew Garrett wrote:

> On Thu, May 27, 2010 at 10:23:50PM +0200, Thomas Gleixner wrote:
> > On Thu, 27 May 2010, Matthew Garrett wrote:
> > > A wakeup event is defined as one that wakes the system - if a system 
> > > can't be woken by a specific event then it's impossible to lose it, 
> > > since it wasn't a wakeup event to begin with.
> > 
> > So where is the problem ?
> 
> The problem is that, right now, if a wakeup event is received between 
> the point where userspace decides to start a suspend and userspace 
> actually starts a suspend, that event may not abort the suspend.

The two of you are talking at cross purposes.  Thomas is referring to 
idle-based suspend and Matthew is talking about forced suspend.

Or at least, that's how it appears to me.  No wonder you can't agree on 
anything.

Alan Stern
