From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 12:25:21 +0200
Message-ID: <20100528122521.3698a62e__39713.1090089262$1275042467$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010 02:18:06 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> > IMO, the whole concept is defining 2 modes of operation:
> >
> > 1. user interacts with the device (at least one suspend block active)
> > 2. user doesn't interact with the device (zero suspend block active)
> =

> That is a somewhat odd way of looking at it. Yes we have two modes of
> operation, but an active suspend blocker does not mean that the user
> is interacting with the device. The way we use it, the "main" suspend
> blocker is active when the user interacts with the device (controlled
> by writing to /sys/power/state). All other suspend blockers are used
> to prevent suspend when user space has decided that the user is not
> interacting with the device. This includes blocking suspend in the
> kernel on key events which means the user actually is interacting with
> the device, even if user-space has not realized it yet. For other
> events, like an incoming phone call, we block suspend and make some
> noise with the hope that the user will start interacting with the
> device.

Damn. I just want to put some abstract notion around this approach to
power saving. =


But one could say instead of "direct" interaction, that every time a
suspend blocker is taken it is "on behalf of the user"?

So if a suspend blocker is taken, because a download is in progress,
it is on behalf of (direct, or indirect) user interaction. =


If a suspend blocker is taken, because a key-press has to trickle up to
userspace, it is because of the user. =


If a call comes in, a suspend blocker is taken, because the user wants
to receive incomming calls. =


So suspend blockers are always a hint to the kernel, that the action is
"on behalf of the user" and it is therefore ok to not suspend the
device?

> =

> >
> > In case 1. the device wants _everything_ sheduled as normal (and save
> > maximum possible power, i.e. runtime pm with every technology available
> > now).
> >
> > In case 2. we want nothing sheduled (and save maximum possible power,
> > i.e. suspend)
> >
> OK.

Good. I got this right at least. =


> =

> > And now, every application and every kernel driver annotates (on behalve
> > of the user) if it (possibly) interacts with the user.
> >
> =

> Applications that interact with the user do not normally need to block
> suspend. The user interacting with the device blocks suspend (just
> like with your desktop screen saver). Not every kernel driver needs to
> be annotated either, only potential wakeup events need to be
> annotated.

The applications interacting with the user rely on other parts of
the system to block suspend then. =


So it is (in general) not the application which determines if the user
interacts, but other sources (like input-drivers) and possible a
timeout? =


> =

> > (Is this really the problematic bit, that userspace is giving
> > the kernel hints? Or is it that the hints are called "blocker"?)
> >
> > We can only enter mode 2, if _nothing_ (claims) to interact with the
> > user.
> >
> =

> If nothing blocks suspend. The reason to block suspend does not have
> to be direct user interaction.

But couldn't you say, that the suspend blockers are always due to the
user? Or is this too narrow?  I mean we talk about a device here. And
the device's purpose is it to serve the user. So it might be better to
say: suspend blockers annotate if a task is needed to fullfill the
devices purpose?

It is an easy to understand concept if one says, the device suspends if
it has nothing to do to further the cause.


I really want to get to a well expressed definition. suspend blockers
block suspend. Shure. Buy why?

> =

> > To integrate this with the current way of doing things, i gathered it
> > needs to be implemented as an idle-state that does the suspend()-call?
> >
> =

> I think it is better no not confuse this with idle. Since initiating
> suspend will cause the system to become not-idle, I don't think is is
> beneficial to initiate suspend from idle.

I'm not shure. But then again, i'm not too familiar with the kernel. It
sounds like it could save some duplication of effort to integrate
suspend into the idle-framework. "Purpose-fulness" could be just
another measure of "idle".


> =

> > Attributes of the idle states could be smth like this:
> >
> > c3
> > =A0 =A0 =A0 =A0cost-to-transition-to-this-state: X
> > =A0 =A0 =A0 =A0powersavings-per-time: Y
> > =A0 =A0 =A0 =A0expected time we stay in this state: relative short, the=
re is a
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer sheduled
> > =A0 =A0 =A0 =A0suspend-blockers: ignored
> >
> > suspend
> > =A0 =A0 =A0 =A0cost-to-transition-to-this-state: depends, how much driv=
ers to
> > =A0 =A0 =A0 =A0suspend, how much processes to freeze, how much state to=
 save
> > =A0 =A0 =A0 =A0powersavings-per-time: Y
> > =A0 =A0 =A0 =A0expected time we stay in this state: long, independent of
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sheduled timers
> > =A0 =A0 =A0 =A0suspend-blockers: must not be activated
> >
> >
> > Now all transitions and opportunistic suspend could be handled by the
> > same algorithms.
> >
> > Would this work?
> >
> =

> I'm not sure what you mean.

Yeah. It's a "little bit" handwavy. =


But the concept I have in mind:

	int what_good_would_it_be_to_go_into_this_state( state )
	{
		/*

		cur_state =3D get_current_state();
		benefit =3D ( get_power_per_time(cur_state)
			- get_power_per_time(state) ) * =

			get_expected_time_we_stay_there( state );
		cost =3D get_transition_cost(cur_state,state);
		return benefit-cost;

		*/
	}

and a constraint function:

	bool is_this_state_possible( state )
	{
		/* =


		ret =3D true;
		cur_latency_requirement =3D get_cur_latency_req();
		ret &=3D (cur_latency_requirement >=3Dstate_latency_guaranty( state ) );
		ret &=3D (some other QOS thingy);

		return ret;
		*/
	}

And now, a loop would enter the state which has the biggest score and
is possible at the time.

Afaik this is already implemented for c-states in the cpu_idle drivers?


cheers,
Flo
