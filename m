From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
	for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 17:33:42 +0200
Message-ID: <200906221733.44629.rjw__15390.4018611231$1245684905$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
	<20090621234324.06fda564@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090621234324.06fda564@infradead.org>
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
> On Mon, 22 Jun 2009 15:20:43 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > On Sat, Jun 20, 2009 at 11:30 PM, Alan
> > Stern<stern@rowland.harvard.edu> wrote:
> > > Some more thoughts...
> > >
> > > Magnus, you might have some insights here.  It occurred to me that
> > > some devices can switch power levels very quickly, and the drivers
> > > might therefore want the runtime suspend and resume methods to be
> > > called as soon as possible, even in interrupt context.
> > 
> > I'd like to call pm_request_suspend() from interrupt context. I don't
> 
> there are some really strong reasons to at least be able to call the
> resume function from an interrupt handler.... shared interrupts are one
> of them.

Yes.  But that requires your hardware to be able to wake up fast enough, so I
think we can introduce pm_runtime_resume_atomic() and
pm_runtime_suspend_atomic() to be used with the devices that can do that, as
proposed by Alan.

Surely not all devices can do it, though.

Best,
Rafael
