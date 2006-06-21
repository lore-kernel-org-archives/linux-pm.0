From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 20:23:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606202008290.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<1150858653.12507.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150858653.12507.69.camel@localhost.localdomain>
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



On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> It's the driver that gets the suspend() request from the bus layer
> (device model if you prefer, but in bus order) and thus is responsible
> for stopping it's own request queue. In some drivers, requests queues
> are even completely handled locally by the drivers themselves.

No. =


If that is really how people expect things to happen, and if people are =

_happy_ with that, then I can only throw up my hands in disgust.

Dammit, if we want to make a machine quiescent enough to take a memory =

snapshot, the only sane way to do that is to do it with proper scoping of =

the problems.

A global memory snapshot is not a "device model" thing.

It's a _system_ event.

The same way the device models try to create a hierarchy, there's a much =

higher-level hierarchy there that should also be respected. Devices (even =

in the device model) are just about the lowest of the low. Before we tell =

devices to be quiet, we tell the upper layers to be quiet.

That's why we freeze processes. That's why we try to clean out the memory =

management. That's why we do things like shut down the console layer (not =

the _device_ layer - the whole logic for "printk()" etc gets shut up).

> Or you ask the drivers who ask their providers to shut up etc... all the
> way up the chain. Works like a charm _and_ allows you to have proper bus
> ordering. Going downard the chain does NOT.

Stop blathering about "chains". There's no "chains". We're talking about =

much higher-level things: getting the requests to GO AWAY in the first =

place at the highest level, and waiting for the queues to drain.

That can (and should) happen without devices being involved with it AT =

ALL. It doesn't _matter_ if there's a chain of devices (say, raid queues =

feeding into some multipath queue, feeding into a low-level queue). The =

way you empty a block device queue is totally independent of any devices =

anywhere:

 - you stop feeding it
 - you unplug it
 - you wait for it to drain.

"Look, ma, no hands!"

None of those operations have anything to do with devices at all (well, =

the unplug ends up telling something to start, but it has nothing to do =

with any special operation).

And none of those operations are in any way "special" as far as the device =

is concerned. The exact same thing actually happens for any normal IO. If =

some process does a "read" and wants to wait for the result, it ends up =

doing exactly that, indirectly.

In other words, THIS HAS NOTHING TO DO WITH THE DEVICE MANAGEMENT. It's =

all a much higher-level issue. It should _literally_ be a question of =

freezing processes (so that they can't be generating more information), =

and then waiting for all the reachable queues (which is about iterating =

the known devices) to become empty. =


At that point, any lower-level queues will be empty too, because the only =

way they are reachable is indirectly through a higher-level queue.

> And how do you make sure there is no request coming from the above when
> a given segment of a bus is going offline or being power managed or
> whatever and thus a given driver needs to make sure it's not fed any
> requests ? stop the entire system block layer ? What if it's not a block
> driver ?

We were talking about IDE, weren't we? Last I saw, it was a block driver..

And yes, that can (and should) be done without ANY DRIVER ACCESS =

WHAT-SO-EVER.

The fact is, if we call down to a driver with something that a driver =

should not have to worry about, it's a _failure_. =


Why? =


Count the number of drivers. Then count them again. Then count the upper =

layers. And realize that if we can do things at upper layers without every =

invocing a driver for an op, we're _much_ better off.

And tell me why the above isn't much simpler than asking drivers to shut =

up on their own? Tell me _one_ reason why an IDE freeze/unfreeze should be =

anything but a no-op, in other words.

			Linus
