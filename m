From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 12:58:02 -0700
Message-ID: <200703201258.03926.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FFAD39.1000302@gmail.com>
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
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> >  Do you really expect every single
> > algorithm choice to be packaged as a pluggable policy?
>
> I didn't say pluggable policy, I just said there are must be
> an alternative - "use" or "do not use" a predefined policy.

I'd call that a "choose between two policies" switch.


> For example, in USB you are able to enable/disable autosuspend rule,
> don't know if it's possible to disable it at runtime though.

There are patches to allow disabling it at runtime through sysfs
attributes of any given device.

The primary reason to have one is bugs in those external devices,
where they don't behave according to the USB spec.  That's the
same reason that the "wakeup" mechanism needs to be disabled
for various devices:  they don't work correctly.

With billions of USB devices in the world, it's impractical for
Linux to rely on lists of device quirks.  No other subsystem has
that particular burden.


> > Most components don't actually _need_ a choice of policies.
> =

> Yes, but they at least need a mechanism to disable an associated policy,

No, most of them don't "need" any such thing.


> upper layers should be able to decide where the policy well be kept,
> they may delegate the keeping to lower layers but also may want to
> keep the policy themselves for some reason.

This keeps sounding worse and worse.  Most of the time, any one
layer ("upper" or otherwise) can't have a clue about the issues
that affect another layer ("lower" or otherwise).

This is a basic fallout of good systems design.  The principle
is called "information hiding", and it minimizes needless
coupling.  It's what lets systems evolve incrementally, and
without needing to constantly change interfaces.

 =

> > That's not a choice; it's how the API is defined.  It's not "policy".
> >
> > Arithmetic is defined so that 2 + 2 =3D=3D 4.  Should we have a "policy"
> > allowing it to =3D=3D 5 instead?  Or should we just accept that as how
> > things are defined, and move on?
>
> We should accept this if we agree that benefit of using the rule always
> exist, but if the rule constrain some functionality we may want to
> disable the rule.

Another basic "how to design systems" guideline is stick to simple rules,
and let the complex behaviors come (when needed) by applying those rules
correctly and consistently.

Or to put it differently:  if you keep having to define exceptions to
the rules (as you propose), you're doing something *very* wrong.  You're
building a house of cards; one that will not stand up to much stress.
It's the same reason that "spaghetti code" is bad.  Once the system gets
too chaotic, it stops being comprehensible ... and you lose the ability
to maintain or enhance it.


> Considering the case with clocks,  we may want  to leave the clock running
> even if there is no users of the clock, but there is a timing constraint
> for readiness  of  a clock device  (PLLs can't be started immediately).

As Igor pointed out:  that may be a reason to keep an extra reference
to PLL output clock.  In the cases I've happened across, those latencies
are not troublesome ... they're not incurred in time-critical transitions.

Whatever keeps that extra reference would need extra information to
decide whether to keep it running.  Presumably you have some real-world
scenario in mind..

- Dave
