From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 09:35:16 -0700
Message-ID: <200706210935.16864.david-b__34548.664574004$1182444007$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0706211148210.3547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211148210.3547-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 June 2007, Alan Stern wrote:
> On Thu, 21 Jun 2007, David Brownell wrote:
> 
> > If drivers actually need a handle on that state, that'd be a fair
> > approach; make it an opaque type though, platform-specific.
> > 
> > But actually I don't see much point to having such a struct.  What
> > matters is the attributes of the target state (what resources will
> > be present, especially), and that rarely needs to be indicated by
> > any kind of cookie.
> 
> Your meaning isn't clear.  You just said there isn't much point in 
> having a struct, and now you say that there rarely needs to be a 
> cookie.  Did you mean to say that a cookie can do a better job of 
> encapsulating the information than a struct can?

Struct, cookie, it's all the same thing.  Nothing is really needed.
The contents would be platform-specific, so there's no point in
having a struct vs some other identifier.

Remember that system suspend/sleep states are global transitions, so
there's no value in having a struct/cookie/... to help distinguish
between multiple concurrent transitions.  There is at most one such
transition under way at a time.  It's implicit.

There's no point in having *ANY* identifier.  That's good, since
updating all the APIs to pass such an identifier -- top to bottom of
all driver and framework stacks -- would be a lot of make-work.  Not
much code currently cares about how the various states differ.

As I think Linus also observed not that long ago, most driver writers
are having a hard time even understanding how to recover from power-off
"suspend" states.  Now, we need to get way beyond that for at least
some systems.  And to help those systems create the base of experience
that other developers can build on.  A key part of that is ensuring
that smarter drivers can be written, while not inflicting complexity
on other systems (and driver writers still struggling with 'resume').


> System suspend is different from runtime suspend in that the 
> requirements are passed from the top down: "The whole system is going 
> to enter this state, so prepare yourself".  Not "All your children are 
> in low-power states, so feel free to reduce your own power level".  A 
> driver can't rely on purely local information to know what will happen.

Right, the same global info applies ... globally.

 
> If a driver wants to find out whether some resource will be available
> in the target system state, the only way is to ask the resource's
> provider.  Hence the driver needs to have some cookie (representing the
> target state) that it can pass to the provider.

Not true.  The provider knows the target state.  Just ask it whether
the resource will be available.  It doesn't need a cookie to distinguish
between multiple target states, since there can be only one.

ACPI-aware providers will of course have to live within the constraints
of ACPI, which include knowing that there are only a handful of possible
states -- numbered S0, S1, S3, S4, S5 -- and that details of those states
are computed by interpreting AML bytecodes.  Those providers can talk to
the ACPI subsystem to get whatever info they need ... not just calling the
AML interpreter, but other details like what S-state is involved.

Providers for non-ACPI systems will naturally work quite differently,
and (by observation!) provide different kinds of resources.  Like clocks,
to pick just one of the more basic examples.

- Dave
