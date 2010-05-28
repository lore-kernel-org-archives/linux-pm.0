From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 11:30:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281128280.1939-100000__19052.5364516818$1275060750$gmane$org@iolanthe.rowland.org>
References: <1275059924.27810.9640.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275059924.27810.9640.camel@twins>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Peter Zijlstra wrote:

> On Fri, 2010-05-28 at 10:35 -0400, Alan Stern wrote:
> >         The app is busy doing something else unimportant
> >         We do into power save
> >         Push a button, generate an IRQ
> >         Come out of power save
> >         No app to poke
> >         * System goes back to sleep and eventually wakes up again
> >         The app finishes what it was doing
> >         The app sees there is a keystroke and marks itself important
> >         ...
> > 
> > The * step is where trouble can occur. 
> 
> Only because you don't run runnable tasks. Please stop considering that
> an option and these problems go away.

True.  If the untrusted apps can be segregated and forcibly stopped, 
and if they don't need timely delivery of wakeup events, then there's 
no problem.

Alan Stern
