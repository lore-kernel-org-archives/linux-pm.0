From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
	for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 17:39:34 +0200
Message-ID: <200906221739.34920.rjw__3641.47923323817$1245685251$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
	<20090622064915.741154a7@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090622064915.741154a7@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Monday 22 June 2009, Arjan van de Ven wrote:
> On Mon, 22 Jun 2009 16:27:29 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > On Mon, Jun 22, 2009 at 3:43 PM, Arjan van de
> > Ven<arjan@infradead.org> wrote:
> > > On Mon, 22 Jun 2009 15:20:43 +0900
> > > Magnus Damm <magnus.damm@gmail.com> wrote:
> > >
> > >> On Sat, Jun 20, 2009 at 11:30 PM, Alan
> > >> Stern<stern@rowland.harvard.edu> wrote:
> > >> > Some more thoughts...
> > >> >
> > >> > Magnus, you might have some insights here.  It occurred to me
> > >> > that some devices can switch power levels very quickly, and the
> > >> > drivers might therefore want the runtime suspend and resume
> > >> > methods to be called as soon as possible, even in interrupt
> > >> > context.
> > >>
> > >> I'd like to call pm_request_suspend() from interrupt context. I
> > >> don't
> > >
> > > there are some really strong reasons to at least be able to call the
> > > resume function from an interrupt handler.... shared interrupts are
> > > one of them.
> > 
> > I suppose you mean that you need to resume the hardware device before
> > you can check if it has a pending interrupt source? If so then you
> > also mean that suspended hardware devices may generate interrupts, no?
> 
> yes and no. For the shared interrupt case.. no.
> but yes for the hw I have in mind (and on my desk ;-) that can happen
> as well from the device itself.

If that's PCI hardware (I guess it is ;-)), I'm not really sure if this
behavior is compliant with the specification.

Anyway, if the interrupt is not shared and the device can wake up fast enough,
we should be able to handle it.

Best,
Rafael
