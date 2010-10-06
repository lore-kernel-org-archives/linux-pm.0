From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Wed, 06 Oct 2010 12:35:50 -0700
Message-ID: <8739sjktbd.fsf__18847.8349628442$1286393982$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1010061156460.2047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010061156460.2047-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 6 Oct 2010 11:58:35 -0400 (EDT)")
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 5 Oct 2010, Kevin Hilman wrote:
>
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> 
>> > On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
>> >
>> >> > > In my opinion the _irq operations should really be one-shot, without
>> >> > > any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
>> >> > > the _irq resume should immediately fail and analogously for the _irq
>> >> > > suspend.  And so on.  As simple as reasonably possible.
>> >> > 
>> >> > But what if the device's own status is currently SUSPENDING or
>> >> > RESUMING?  Do you want to fail when that happens, instead of waiting
>> >> > for the concurrent operation to finish?
>> >> 
>> >> Yes.  IMO an _irq() suspend should only be allowed if the status is RPM_ACTIVE
>> >> and an _irq() resume should fail if the status is not RPM_SUSPENDED.  The
>> >> error code returned should depend on the situation, though.
>> >> 
>> >> > There's no way to prevent this
>> >> > on SMP systems, because a wakeup request can arrive while a
>> >> > software-initiated resume is in progress.
>> >> 
>> >> I know that. :-)
>> >
>> > I suspect Kevin will not want to live with this restriction, but I'd
>> > like to hear from him.  Kevin?
>> 
>> [ Apologies for the delays... I've been running around preparing OMAP PM
>>   stuff for the upcoming merge window. ]
>> 
>> I think I can live with the above restrictions (the _irq methods failing
>> unless they can immediately run.)  For the rare corner cases I've
>> currently run into, this will work fine as they happen because of a
>> wakeup IRQ, where we know the device is RPM_SUSPENDED.
>
> Then what will the driver do if it gets a wakeup IRQ but it can't
> resume the device because some other thread is in the middle of a
> suspend or resume?

In those cases, I guess it will have to return IRQ_NONE, and print some
sort of error.  Alternatively, it could fall back to the high-latency
case of masking the IRQ and doing an asynchronous call then call the ISR
in the runtime_resume callback.

For the corner cases that I've run into, other transitions will not be
in progress because system has just woken up (so no threads are in the
middle of suspends or resumes) and the IRQ fires as soon as pm_idle
enables interrupts, and before there's a chance to schedule anything
else.

Kevin
