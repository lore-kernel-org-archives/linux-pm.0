From: David Brownell <david-b@pacbell.net>
Subject: Re: Too many timer interrupts in NO_HZ
Date: Mon, 17 Mar 2008 00:44:49 -0800
Message-ID: <200803170144.50990.david-b__1543.54239716685$1205743709$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0803162224460.2108-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803162224460.2108-100000@netrider.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Chanda Sethia <chanda.sethia@in.ibm.com>, suresh.b.siddha@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, discuss@lesswatts.org, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 16 March 2008, Alan Stern wrote:
> On Sun, 16 Mar 2008, Vaidyanathan Srinivasan wrote:
> 
> The largest entry is for ehci_watchdog.  This timer won't run at all if

... you're not accessing EHCI devices at all.  Is HAL or
something else polling them too often?  Or are you maybe
doing something else that resembles "real work"?


> your EHCI controllers are allowed to autosuspend, which will happen
> automatically if
> 
> 	(1) You enable CONFIG_USB_SUSPEND, and
> 
> 	(2) You have no high-speed USB devices attached, or the
> 	    ones that are attached have all been suspended.
> 
> On the other hand, if you were actively using some high-speed USB 
> device during the test then it's understandable that there should be 
> lots of timer interrupts as a result.

That watchdog is a bit messy, but it's got two basic tasks:

 (a) Take work off the async ring ... bulk and control
     transfers will leave an empty QH there for a few
     milliseconds before taking it off, to avoid wasting
     effort in the common case where another transfer
     quickly follows the first one.  In the extreme case,
     when there's no more work, that ring gets disabled.

 (b) A real I/O watchdog ... in case the hardware forgets
     to issue some kind of I/O completion interrupt.  This
     watchdog rarely needs to fire.

So I'm thinking this is most likely a case where something
is sending work to one or more high speed devices.

- Dave
