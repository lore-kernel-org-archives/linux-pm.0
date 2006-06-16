From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:56:52 +0200
Message-ID: <20060616135652.GE1666@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<20060615191925.GA1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
	<1150421189.7725.81.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151927580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151927580.5498@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Well, solving that problem is exactly why we have the PM callbacks in
> > bus hierarchy.
> =

> No. That's a separate thing. =

> =

> We have PM callbacks in the bus hierarchy because we need that just to =

> turn them off. You can't turn off the device after you've turned off the =

> bus it is attached to.
> =

> But that's _totally_ orthogonal to the issue that a complex state save ma=
y =

> need a totally unrelated device - along dependancies we don't even _know_.
> =

> For example, when a device save needs to allocate memory, that in turn ca=
n =

> end up needing to write to just about _any_ device - and there simply _is=
_ =

> no hierarchy for that. No such hierarchy is even possible, because it's a =

> circular problem.
> =

> Btw, one final note:
> =

> If people who do STD really do want to suspend all devices and then wake =

> up devices that lead to the STD device, in the end, I personally simply =

> don't care.

No, this is not what I want. I want to:

* freeze all devices (can be implemented as suspend)
* create atomic image
* unfreeze all devices (can be implemented as resume)
* write image to disk
* powerdown (which implies suspending devices).

...in fact, that is what we do today.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
