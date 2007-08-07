From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 14:20:58 -0700
Message-ID: <200708071420.59260.david-b@pacbell.net>
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

> Changing the function name to "clk_available_in_suspend()" addresses at
> least two of these points.

Except that it would

 (a) Preclude using this function in non-suspend contexts, including the
     "multiple run states" PM support that's regularly requested (and
     is thus IMO in the "why not plan on it" category).  The mechanism
     doesn't *NEED* to be constrained to be usable only from suspend().

 (b) Beg the question of which suspend state is involved ... something
     which has to date been intentionally hidden, since such states are
     so extremely system-specific (and since drivers misused that info).
     Drivers can care about *attributes* of an upcoming state (like
     whether a clock will be available, or a power domain, etc); fine.

The original notion for a name was of course clk_will_be_available(clk),
but that seemed too darn unwieldy to use.  Plus, logic like

	if (clk_must_disable(clk))
		clk_disable(clk);

(and similar) just seems inherently less likely to confuse ... it doesn't
need to introduce even one new term or concept, and focusses exclusively
on the key point:  whether clk_disable() is mandatory.


> The other two points are addressed by 
> providing a way for the method to be passed the desired system suspend
> state, which may be resolved by expanding pm_message_t to contain that
> information.

You do realize that pm_message_t was created to move *AWAY* from
passing an ID for the target system state down to the drivers?
The PM core previously passed down PM_SUSPEND_* integer codes.

Personally I detest pm_message_t ... "struct pm_message *" would
have been better, much less costly to expand (if needed), no new
typedefs, no pass-struct-by-value.  And in any case, there's work
afoot to have different methods for each different PM event, and
thus finally abolish pm_message_t.


> Finally, concerning merging this during the -rc phase, I'd much rather
> see the one liner simple build fix of adding the missing function
> prototype going into the -rc kernels, and then a similar patch to this
> going in during the next merge window.

If clk_must_disable() hadn't been "the plan of record" for over a
year, and already in use, I'd have been more in accord with that.

- Dave


> >  /*
> > - * Call this from platform driver suspend() to see how deeply to suspend.
> > + * This is called from clk_must_disable(), to see how deeply to suspend.
> >   * For example, some controllers (like OHCI) need one of the PLL clocks
> >   * in order to act as a wakeup source, and those are not available when
> >   * going into slow clock mode.
> > - *
> > - * REVISIT: generalize as clk_will_be_available(clk)?  Other platforms have
> > - * the very same problem (but not using at91 main_clk), and it'd be better
> > - * to add one generic API rather than lots of platform-specific ones.
> >   */
> >  int at91_suspend_entering_slow_clock(void)
