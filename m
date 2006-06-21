From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 12:57:33 +1000
Message-ID: <1150858653.12507.69.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
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

On Tue, 2006-06-20 at 19:40 -0700, Linus Torvalds wrote:
> =

> On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > But the driver queue isn't quiescent !
> =

> AND WHAT THE HELL DOES THAT HAVE TO DO WITH THE DRIVER?
> =

> It's not up to the driver to worry about request queues. If you guys thin=
k =

> it is, you have your heads so solidly up your nether regions that it's no=
t =

> even funny.

It's the driver that gets the suspend() request from the bus layer
(device model if you prefer, but in bus order) and thus is responsible
for stopping it's own request queue. In some drivers, requests queues
are even completely handled locally by the drivers themselves.
 =

> Dammit, stop trying to make that a driver issue. It isn't. Drivers should =

> not have to worry about things like that, because it's not actually the =

> driver that even _does_ any of the request queue stuff. =


In some cases it is.

> That's _all_ at a much higher level, and trying to push it down to a driv=
er writer is not =

> just stupid, it's so incredibly broken and idiotic that it's not even =

> funny.

Yeah yeah yeah ... so give concrete examples of how things should
happen.

> If you want to take a snapshot of memory, you do NOT ask the drivers to =

> just make everything quiet. You start from the upper layers, make things =

> quiet there, and _than_ you ask the driver to also shut up.

Or you ask the drivers who ask their providers to shut up etc... all the
way up the chain. Works like a charm _and_ allows you to have proper bus
ordering. Going downard the chain does NOT.

> But the fact is, IDE drivers don't even have to be told to shut up. If =

> there are no requests coming in from above, then they will be quiet on =

> their own. So, pretty much by definition, a freeze/unfreeze event for an =

> IDE driver had better be pretty much a no-op, or you have serious serious =

> problems anyway.

And how do you make sure there is no request coming from the above when
a given segment of a bus is going offline or being power managed or
whatever and thus a given driver needs to make sure it's not fed any
requests ? stop the entire system block layer ? What if it's not a block
driver ? Iterate through all subsystems in the kernel ? What about
drivers that implement their own internal request queuing mecanisms
(that aren't block drivers for example) ? What about ioctl's or such
things coming from userland ?

> Trying to claim anything else is beyond stupid.

Yeah  yeah, big words, insults, whatever you want, I still see all sort
of practical examples where my approach currently works and no way yours
will ... =


> And yes, I realize that the suspend/resume code has done some damn stupid =

> things. That's not an excuse for then making things _worse_ by not even =

> admitting that they are idiotic and bad.

facts, please. How long since you have put your hands in a driver btw ?

Ben.
