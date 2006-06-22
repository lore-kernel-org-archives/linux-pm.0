From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 19:47:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606211940350.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 21 Jun 2006, Linus Torvalds wrote:
> =

> >  - userland will stop responding at any point in time in the future (as
> > soon as the backing store of a given process or swap is put to sleep, or
> > maybe blocked in an ioctl of a sleeping driver or whatver
> =

> Exact same thing. This has _nothing_ to do with save_state(), and is no =

> different from what we have now, in exactly the same ways.
> =

> And btw, in my suggested setup, you actually _do_ get that notification, =

> ie the "freeze()" thing tells you that if you're doing snapshotting etc, =

> that's the point where processes have also been put to sleep.

On a somewhat tangential notion: if a driver actually cares about which =

phase is going on, we do have the "system_state" variable.

Traditionally, we've not done a lot to it, but some kernel infrastructure =

has wanted to know whether the system is "booting" or "running", and =

there's certainly nothing wrong with adding a state for "shutting down".

I don't actually see very many drivers caring, but we could certainly add =

a state and make sure it's set when the suspend cycle starts (or even set =

it to different values for different parts of the cycle).

For some strange reason, almost half the users of that variable are in the =

powerpc tree. =


That may be enough for whatever you had in mind (adding notification of =

each phase seems to be a bit overkill).

			Linus
