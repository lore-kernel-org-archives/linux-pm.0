From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Fri, 24 Sep 2010 11:54:36 -0700
Message-ID: <87ocbnas5v.fsf__17081.242046743$1285354532$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1009241104540.1744-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Partha Basak <p-basak2@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 23 Sep 2010, Kevin Hilman wrote:
>
>> Hello,
>> 
>> Looking for advice for a little runtime PM dilemma...
>> 
>> After some inactivity, a driver decides to supend iteslf using
>> pm_runtime_put_sync().
>> 
>> The device is now suspended, it's ->runtime_suspend() method has
>> disabled its clock, so its registers cannot be accessed anymore.
>> 
>> Now, as interrupts are still enabled, an interrupt for this device might
>> still arrive.  For example, if this device is a wakeup source, its
>> ->runtime_suspend() method may not have masked its interrupt.
>
> Right.
>
>> So, the IRQ fires, and the drivers ISR is called.  The driver wants to
>> access the device registers, but since it has been runtime suspended,
>> it's registers are not available.
>> 
>> The first reflex would be to simply do a pm_runtime_get_sync() in the
>> ISR, however this is not safe if the ISR is an IRQs-disabled handler (as
>> is the case for me, where the problematic handler is chained handler
>> used for demuxing GPIO IRQs.)
>
> An ISR shouldn't call pm_runtime_get_sync() in any case.
>
>> So, what is the "right" thing to do here?
>
> You should call pm_runtime_get(), turn off the interrupt source, and
> return.  Then your resume routine should check for an outstanding
> interrupt or wakeup request and handle it (the easiest way may be 
> simply to call the ISR).

For a "normal" device driver, your solution makes complete sense.  The
only catch is that it introduces potentically significant latency in the
interrupt handling and it requires the interrupt source to be masked,
potentially loosing other interrupts, while waiting for the runtime PM
workqueue to schedule.  For chained handlers in particular, this means
that *all* interrupts managed by the chained handler would be masked for
this additional time.  Not good.

The problematic device for me as an on-chip GPIO controller, and the ISR
in question is a chained handler (run with interrupts disabled) which
does the GPIO demux and then dispatches to the actual ISR.  Following the
above approach means that all GPIO interrupts (in that bank) would be
masked until ->runtime_resume() is called.  For a GPIO bank with
multiple edge-triggered IRQs, masked IRQs for that amount of time could
mean several missed interrupts while waiting.

For example, Here's what would happen:

- IRQ arrives
- ISR: [chained handler, called with IRQs disabled ]
  if (pm_runtime_suspended()) {
      pm_runtime_get()
      <mask the GPIO bank interrupt>
      /* starting now, we miss edge-triggered IRQs in this bank */
      state->irq_pending = true;
      return;
  }

... some time later (scheduler latency, other hard IRQs, soft IRQs?, etc.) ...

- pm_runtime_work()
      /* IRQs disabled */
      __pm_runtime_resume()
          /* IRQs enabled */
          bus->runtime_resume()
              driver->runtime_resume()
          /* IRQs disabled */
     /* IRQs enabled */

And in the driver's runtime_resume method()

  if (state->irq_pending) {
      /* disable IRQs */
      <call GPIO demux ISR, which will finally unmask the bank IRQ>
      /* enable IRQs */
      /* Here, we can finally receive interrupts on that bank again. */ 
  }
      
Not only is the additional interrupt latency a problem, but any other
drivers hooked up to these IRQs may have requested IRQF_DISABLED
handlers, expecting to be called in interrupt context with interrupts
disabled, which clearly will not be the case.  Hoever, this isn't a
major concern as we don't (currently) have IRQF_DISABLED handlers hooked
up to GPIO IRQs (that I know of.)

>> A quick hack would be to for the drivers ISR to do a
>> pm_runtime_get_noresume() and directly call the its ->runtime_resume()
>> method, then do its normal stuff, followed by a pm_runtime_put() at the
>> end of the ISR.
>> 
>> Is this an acceptable hack given that it's only needed for the
>> increasingly rare cases of ISRs with interrupts disabled?
>> 
>> Or should we think of making a version of _get_sync() that is safe for
>> IRQs disabled contexts like this where we know the device is already
>> RPM_SUSPENDED?
>> 
>> Any advice appreciated...
>
> You're trying to fight the runtime-PM design instead of using it as it 
> was intended.  We already have an API for starting a resume from 
> interrupt context, and that's what you should use.

It may seem like I'm trying to fight the design, but I'm actually trying
to find ways to use it.  I want to use the API (and we're using it
successfully in most of our drivers now.)  The problem is only in a few
of these corner cases where using it introduces significant changes from
previous behavior like introducing long, unbounded windows for missed
interrupts.

Kevin
