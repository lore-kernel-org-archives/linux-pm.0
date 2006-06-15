From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 17:07:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614235713.GA24859@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> On St 14-06-06 15:59:00, Linus Torvalds wrote:
> >
> > There is no "console device".
> > =

> > There are potentially _many_ console devices.
> =

> With printks going to all of them?

Yup.

> My point is that you really want the console enabled in writing phase
> of suspend-to-disk. And old setup got that detail right, while new
> setup does not.

I definitely agree that we can change things around a bit. I don't =

personally use suspend-to-disk, and I'm a bit tired of having people tell =

me STD works, when STR is what I have always cared about, so if the tables =

are turned for once, I won't be _too_ sorry.

I have always argued that the suspend should be a two-phase thing: a =

"prepare to suspend" (that saves the device state) and then a "real =

suspend" (that actually turns off devices). =


_I_ think that's the only sane schenario, and I think that in that =

schenario we could save the image to disk in between, and disable the =

console after that, and just before the "actually turn off devices" phase.

But I've said that before, and nobody cared last time either. For some =

reason, people continue to think that suspend should be a single phase, =

with us sending down "suspend" to each device. =


And quite frankly, until we do it the way I say we should do it, I don't =

think you can _ever_ do things well. For example, the whole thing where we =

have hacks to try to avoid suspending the device that is the disk to =

suspend to all comes from this same problem.

		Linus
