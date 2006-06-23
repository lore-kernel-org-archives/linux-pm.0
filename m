From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 10:05:59 +1000
Message-ID: <1151021159.4046.73.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Here's a _fact_:
> =

>  - we currently walk the device chain to suspend different devices
>  - one device returns an error
>  - we've now suspended half the machine, done major things, and we need t=
o =

>    undo it
>  - the thing fails.
> =

> Are you seriously claiming this has never happened to you? It sure has =

> happened to me.

It happens occasionally (latest was a USB controller going dead
occasionally on a box and usb suspend() method for it failing when that
happens).

When we fail, we resume() things that were suspended(), at least we used
to, and that works. That is suspending fails but at least the machine
comes back into operational state and you can look at dmesg, console,
whatever. I haven't had the case where _that_ failed.

> And YES, THIS WOULD BE IMPROVED BY MY SCHEME. Instead of getting a machin=
e =

> that has suspended partly, and may be effectively dead and unable to even =

> tell the user that it failed half-way through, it would not have suspende=
d =

> anything at all, and just say "Sorry, I can't do that".

That would have been fixed by a prepare() callback too as I'm advocating
it. This has nothing to do with saving state.

> Adn yes, this is a _direct_ result of THE BROKEN CONVENTION OF DOING =

> EVERYTHING IN SUSPEND()!
>
> But yeah, you go on and ignore it. Because the current scheme is obviousl=
y =

> all right.

The current scheme is not perfect, and I've proposed at least one
mecanism to improve it. My argument is that it has nothing about saving
state and changing the state save vs. suspend semantics. Changing _that_
won't help.

Ben.
