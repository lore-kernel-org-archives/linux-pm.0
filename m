From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 5 Sep 2006 12:31:58 +0200
Message-ID: <200609051231.59356.rjw@sisk.pl>
References: <200609032300.k83N0uL6016830@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200609032300.k83N0uL6016830@olwen.urbana.css.mot.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Monday, 4 September 2006 01:00, Scott E. Preece wrote:
> =

> | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> | =

> | On Sunday, 3 September 2006 23:34, Scott E. Preece wrote:
> | > =

> | > | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> | > | =

> | > | On Sunday, 3 September 2006 18:25, David Singleton wrote:
> | > | > On 9/2/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> | > | > >
> | > | > > That depends on the definition, but I think of suspend states a=
s the ones
> | > | > > that require processes to be frozen before they can be entered.=
  IMHO it is
> | > | > > quite clear that such states cannot be handled in the same way =
as those
> | > | > > that do not require the freezing of processes, so they are not =
the same.
> | > | > =

> | > | > You are correct, processes do need to be frozen before a suspend.
> | > | > That's the prepare to suspend part of the suspend process, and
> | > | > the transtition is the suspending and finish is the un-freezing
> | > | > of the processes to resume execution.
> | > | > =

> | > | > And those same steps are the same steps required to transition the
> | > | > system to a new operating point, whether it's suspend or change
> | > | > from 1.4GHz to 600MHz.
> | > | =

> | > | There are only a few states that require the processes to be frozen=
 and I
> | > | think that's a good enough reason to handle them separately.
> | > =

> | > ---
> | > =

> | > But, surely that distinction can be handled in the implementation beh=
ind
> | > the interface, rather than exsposed in the interface.
> | =

> | I don't think you can handle that behind the interface in a satisfactor=
y way.
> | For example during a suspend to disk we carry out several transitions of
> | devices within the suspend-resume cycle.
> | =

> | > Does that distinction matter to the policy manager?
> | =

> | I think so.
> | =

> | > I would argue that it =

> | > increases the latency, which would be important to the policy manager,
> | > but that the nature of the latency isn't important to making a policy
> | > decision,  and the proposed interface already exposes the latency as
> | > something that can be used in making transition decisions.
> | =

> | From the policy manager perspective it may be just a latency fator,
> | but for all of the things _outside_ of the policy manager it's much more
> | than that.
> | =

> | For example transitions like a CPU frequency change are transparent for=
 kernel
> | threads, but the suspend "transitions" are not, because the kernel thre=
ads need
> | to be informed that the system is suspending and they are expected to f=
reeze
> | themselves voluntarily.
> | =

> | Really, I think that the "states" which are entered only after tasks are
> | frozen should be considered as special and handled separately.
> ---
> =

> My point is that if the only kernel interface is set-op(), then the code
> in the kernel that implements set-op() is the thing that's going to
> drive the details of suspending the system, just as it does today.

It's not exactly correct in the case of the userland suspend when we have
a userland process that drives the suspend (eg. it writes the suspend image
to a storage).  In that case the kernel is only asked to performe some
well defined atomic actions and not the entire transition.

> The abstraction at the kernel interface is about as simple as it can be a=
nd
> all the policy issues are moved outside the kernel.
> =

> My question is whether there are aspects of suspending, other than
> latency, that the policy manager would need to consider in deciding
> whether to suspend or not.
> =

> Look at it this way. In one scheme the policy manager code is:
> =

>    new_OP =3D select_transition(current_OP, decision_factors);
>    set_OP(new_OP);
> =

> in the other the policy manager code is:
> =

>    new_OP =3D select_transition(current_OP, decision_factors);
>    if (new_OP =3D=3D SUSPEND)
>       suspend();
>    else
>       set_OP(new_OP);
> =

> The only practical difference is whether the kernel has one interface or
> two; in the one-interface case, there's code in the kernel's
> implementation of set_OP() that does the same conditional and calls the
> same implementation of suspend. In Pavel's preferred idiom, the calls
> to set_OP() are replaced by a sequence of
> =

>    set_power_parameter(PARM, VALUE) calls
> =

> All dreadfully oversimplified, of course, but I know that the general
> approach is possible, because our PM subsystem works in a vaguely
> similar manner. The simplification isn't completely ignorable, though,
> because the mechanisms driving the transitions involve input from the
> kernel (entry to idle, interrupts, clock events, load information, etc.).
> The interaction between the kernel and the policy manager may actually
> be too complex to support doing all of policy management in user space
> (our implementation actually has some kernel bits and some user-spec
> bits). Not sure that affects the question of whether suspend is an
> operating point, though - that seems (to me) to work the same whether
> the policy decision is in the kernel or in user space.
> =

> The one question that I see as interesting on that score is whether the
> policy decision to suspend is based on factors that are wholly different
> than the factors that drive frequency/voltage changes. If that were the
> case, then there would be no point to making the decisions in the same
> place.  Honestly, I'm not sure of the answer to that...

I think the decision to suspend is made
a) by the user,
b) by a policy manager in case when, for example, the battery is running
critical (ie. on emergency).
and the decision to change a frequency/voltage is usually based on some
efficiency factors.

Also, the suspend "transitions" are never transparent to the user and the
changes of frequency/voltage usually are, at least as far as CPUs are
concerned.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
