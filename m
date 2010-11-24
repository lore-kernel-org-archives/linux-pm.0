From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt handlers
Date: Tue, 23 Nov 2010 16:11:31 -0800
Message-ID: <87mxozd1ho.fsf__2982.1822107353$1290557657$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1011222204440.26293-100000@netrider.rowland.org>
	<201011232351.11340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011232351.11340.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 23 Nov 2010 23:51:11 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, November 23, 2010, Alan Stern wrote:
>> On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:
>> 
>> > > > Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
>> > > > we need it, exactly?
>> > > 
>> > > Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
>> > > irq-safe version of rpm_idle() then drivers wouldn't be able to call 
>> > > pm_runtime_put_sync() from within an interrupt handler.
>> > 
>> > Right.  Which they can't do now, can they?
>> 
>> True.  That was the point of this patch -- to allow interrupt handlers
>> to do runtime PM, which they can't do now.
>
> The original idea was to allow suspend and resume to be carried out
> with interrupts off, not necessarily by interrupt handlers.  We've never
> considered doing that with _idle before.
>
>> > Why do you think we should allow them to do that?
>> 
>> Are you suggesting that interrupt handlers stick to pm_runtime_suspend 
>> and pm_runtime_resume, and ignore pm_runtime_get_sync and 
>> pm_runtime_put_sync?
>
> Why do they need the _sync versions?  What exactly is wrong with
> calling
>
> pm_runtime_put_noidle()
> pm_runtime_suspend()
>
> from an interrupt handler if it really wants the synchronous suspend to be
> carried out at this point?
>
> I don't really see a reason for calling pm_runtime_put_sync() by an interrupt
> handler, but perhaps I'm overlooking something important.

While I like the idea of the symmetry of having both _get_sync() and
_put_sync() callable from an interrupt handler, I can't currently think
of a situation where we would need to _put_sync() in the ISR.  A
standard _put() should suffice for all cases I can imagine.

Kevin
