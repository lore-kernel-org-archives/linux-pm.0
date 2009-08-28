From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Fri, 28 Aug 2009 21:38:14 +0200
Message-ID: <200908282138.14602.rjw__40188.970990903$1251488321$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908281137110.4116-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908281137110.4116-100000@iolanthe.rowland.org>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 August 2009, Alan Stern wrote:
> On Wed, 26 Aug 2009, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Theoretically, the total time of system sleep transitions (suspend
> > to RAM, hibernation) can be reduced by running suspend and resume
> > callbacks of device drivers in parallel with each other.  However,
> > there are dependencies between devices such that, for example, we may
> > not be allowed to put one device into a low power state before
> > anohter one has been suspended (e.g. we cannot suspend a bridge
> > before suspending all devices behind it).  In particular, we're not
> > allowed to suspend the parent of a device before suspending the
> > device itself.  Analogously, we're not allowed to resume a device
> > before resuming its parent.
> 
> > In this version of the patch the async threads started to execute
> > the resume callbacks of specific device don't exit immediately having
> > done that, but search dpm_list for devices whose PM dependencies have
> > already been satisfied and execute their callbacks without waiting.
> 
> Given this design, why bother to invoke device_resume() for the async 
> devices?  Why not just start up a bunch of async threads, each of which 
> calls async_resume() repeatedly until everything is finished?  (And 
> rearrange async_resume() to scan the list first and do the actual 
> resume second.)
> 
> The same goes for the noirq versions.

I thought about that, but there are a few things to figure out:
- how many threads to start
- when to start them
- stop condition
I had a few ideas, but then I thought it would be simpler to start an async
thread when we know there's some async work to do (ie. there's an async
device to handle) and make each async thread browse the list just once (the
rationale is that we've just handled a device, so there's a chance there are
some devices with satisfied dependencies down the list).

Thanks,
Rafael
