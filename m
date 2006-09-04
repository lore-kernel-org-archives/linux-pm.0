From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 11:12:40 +0200
Message-ID: <20060904091230.GL9991@elf.ucw.cz>
References: <200609032300.k83N0uL6016830@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032300.k83N0uL6016830@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | Really, I think that the "states" which are entered only after tasks are
> | frozen should be considered as special and handled separately.
> ---
> =

> My point is that if the only kernel interface is set-op(), then the code
> in the kernel that implements set-op() is the thing that's going to
> drive the details of suspending the system, just as it does today. The
> abstraction at the kernel interface is about as simple as it can be and
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

No, it would be =


    new_OP =3D select_transition(current_OP, decision_factors);
if (new_OP =3D=3D SUSPEND) {
	setup wakeup events ...
}
    set_OP(new_OP);


> in the other the policy manager code is:
> =

>    new_OP =3D select_transition(current_OP, decision_factors);
>    if (new_OP =3D=3D SUSPEND)
>       suspend();
>    else
>       set_OP(new_OP);
...
> The one question that I see as interesting on that score is whether the
> policy decision to suspend is based on factors that are wholly different
> than the factors that drive frequency/voltage changes. If that were the
> case, then there would be no point to making the decisions in the same
> place.  Honestly, I'm not sure of the answer to that...

I'm pretty sure decision to suspend is other factors. Remember most
machines are non-functional during suspend.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
