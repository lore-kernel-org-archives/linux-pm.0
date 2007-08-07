From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 14:17:47 -0700
Message-ID: <200708071417.47706.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<20070806222351.090dc035.akpm@linux-foundation.org>
	<20070807125054.GC2833@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070807125054.GC2833@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 August 2007, Russell King wrote:

> 4. the description of the function implies that this function may be
>    called when we are not suspending:
> 
>   + * On platforms that support reduced functionality operating states, the
>   + * constraint may also need to be tested during resume() and probe() calls.

Right ... support for multiple "run" states will imply this same kind
of predicate, and I couldn't justify chosing a name which forces the
existence of more than one such predicate.  Ergo a generic name.

However, right now no platforms support them (cpufreq aside), so this
text could be rather harmlessly removed:  the second half of the sentence
doesn't apply to anything yet.  And maybe it *should* be removed, since
such platforms might do arbitrarily surprising stuff ... they might use
driver-level "reclock yourself" callbacks/notifiers (like the original
DPM stuff).


>    With SoCs with multiple power states affecting which clocks are
>    available, and the need in point (2) for the architecture code to
>    record which PM mode we're entering via the pm_ops set_target method,

Your point (2) was that it's "unclear" how that information becomes
available.  But the presumption of (4) here is that it's set_target().
So either it's clear enough, and (2) was wrong; or (4) has a false
premise; or both.  From false premises, anything can be proven...

I'd certainly not expect pm_ops.set_target() to apply in any context
other than the start of a suspend sequence.  Any platform choosing
to implement multiple run states necessarily provides some more
mechanisms...

(Purely as an example ... this is much the same kind of thing that goes
on with cpufreq updating a CPU clock that's also exposed through the
clock API:  multiple interfaces to the same PM-related state.  In both
cases, the public interface doesn't say how the implementation might
be done; it doesn't even care.)


>    calling clk_must_disable() outside of the suspend methods results in
>    this function essentially returning undefined values at driver probe
>    time.  Note: there is no locking between driver probing and the
>    set_target method.
> 
>    Moreover, if used in a driver probe() path, the return value could
>    well depend on the _last_ system suspend state entered, and would be
>    undefined for a system which hasn't been suspended from boot.

No, this platform maintains an invariant that the target PM state is
always PM_SUSPEND_ON except while suspending.  (So does ACPI, as I
recall.)  You're presuming a broken platform; but it's not broken...

Re locking, that issue would be addressed as part of supporting
multiple run states.  I still don't see suspend ops being involved
in non-suspend transitions.  But if a state change is in progress as
probe() is called, then suspend() should probably be called later.

- Dave
