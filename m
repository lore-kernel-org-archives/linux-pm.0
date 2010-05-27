From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 11:47:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271141410.3239-100000__1691.14001696489$1274975920$gmane$org@iolanthe.rowland.org>
References: <1274974479.27810.5247.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274974479.27810.5247.camel@twins>
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

On Thu, 27 May 2010, Peter Zijlstra wrote:

> On Thu, 2010-05-27 at 16:33 +0100, Alan Cox wrote:
> > On Thu, 27 May 2010 17:09:16 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Thu, 2010-05-27 at 11:06 -0400, Alan Stern wrote:
> > > > 
> > > >         Opportunistic suspends are okay.
> > > > 
> > > >         The proposed userspace API is too Android-specific.
> > > 
> > > I would argue opportunistic suspends are not ok, and therefore the
> > > proposed API is utterly irrelevant.
> > 
> > Assuming you are happy that opportunistically entering C6 and the like is
> > ok via ACPI can you explain why you have a problem with opportunistic
> > suspend and why it is different to a very deep sleep CPU state such as we
> > have now (and which on many embedded platforms we deal with *is* sleeping
> > external devices too)
> 
> Agreed, but I understood the opportunistic suspend line from Alan Stern
> to mean the echo opportunistic > /sys/power/foo thing.

Yes, that's what I meant.  Why do you think it is any worse than "echo 
mem >/sys/power/state"?  The only difference is that it will block 
until all in-kernel suspend blockers are disabled.

Or do you also think that "echo mem >/sys/power/state" is evil and 
should be removed from the kernel as soon as possible?

And to answer Thomas's question: The whole reason for having in-kernel 
suspend blockers is so that userspace can tell the system to suspend 
without losing wakeup events.

Suppose a key is pressed just as a user program writes "mem" to
/sys/power/state.  The keyboard driver handles the keystroke and queues
an input event.  Then the system suspends and doesn't wake up until
some other event occurs -- even though the keypress was an important
one and it should have prevented the system from suspending.

With in-kernel suspend blockers and opportunistic suspend, this 
scenario is prevented.  That is their raison-d'etre.

Alan Stern
