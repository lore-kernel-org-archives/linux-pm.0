From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [markgross@thengar.org: [RFC] wake up notifications
 and suspend blocking (aka more wakelock stuff)]
Date: Tue, 25 Oct 2011 11:14:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110251105221.3089-100000__28030.6767592721$1319724393$gmane$org@iolanthe.rowland.org>
References: <20111025045046.GA8383@mgross-G62>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111025045046.GA8383@mgross-G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <markgross@thegnar.org>
Cc: khilman@ti.com, "Dmitry  Fink (Palm GBU)" <Dmitry.Fink@palm.com>, NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, peterz@infradead.org, John Stultz <john.stultz@linaro.org>, farrowg@sg.ibm.com, Magnus Damm <damm@opensource.se>, linux-pm@lists.linux-foundation.org, mjg@redhat.com
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Oct 2011, mark gross wrote:

> > > Timeout?  why can't we define a proper notification handshake for such
> > > things?  Timeouts are never right IMO.
> > > 
> > 
> > I thought that before, but I have come around to the opposite way of thinking
> > thanks to some instructive examples from Alan and Rafael.
> > 
> > Some things are simply not visible to the OS.  We can expect them to be
> > happening but we cannot be sure and there is no clear signal that they aren't
> > actually happening.  So we need a timeout.
> 
> um

> > - USB cannot (I think) know which USB device triggered a wake-from-suspend,
> >   and in any case cannot directly ask the device why it woke from suspend.
> >   It has to wait for the device to tell it (in response to a regular
> >   'interrupt' poll I assume - but it isn't guaranteed to be reported on the
> >   first poll) - or timeout and give up waiting.
> maybe if you are unwilling to change the user mode stack that is reading
> these events.  But if you where they you shouldn't need time outs.

Remember, here we are talking about timeouts in the kernel stack, not
in the user-mode stack.

So consider this theoretical situation (which is not very different
from reality): The system gets a wakeup signal.  Sometime in the next
30 ms or less, there may or may not be an input event -- the kernel has
no way to tell other than wait and see.

The kernel could simply go right back to sleep without waiting, but if
it does and there is a pending input event, then very quickly it will
get another wakeup signal, and it'll be right back where it started -- 
trying to decide whether to stay awake for the next 30 ms.

Can you suggest a way to handle this other than using a timeout?

Alan Stern
