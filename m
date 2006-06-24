From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:12:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060624024230.GB3438@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, Adam Belay wrote:
> =

> Yeah, I think it could certainly be improved.  However, I think it's very
> important that we be careful to prevent a driver from attempting to access
> powered off hardware, even in the STR case.  Now that doesn't warrant a
> fullblown teardown of the driver stack.  In most cases this sort of thing
> can be handled by notifying the right higher-level subystems.  So the act=
ual
> driver suspend() mechanisms can remain very simple. (see below)

Right. I think drivers do way too much, and that's part of the problem - =

not only do we have basically the same code repeated over and over, but =

they have a really hard time really doing the right thing.

For example, on the run-time management, if we shut things down not as a =

"pci_device" but as a "network device" (which just happens to be _bound_ =

to a pci device), we could very easily do the highlevel network device =

crap to make sure that we don't get entered that way _first_. And do it in =

just one place.

> > =

> > It's really only needed with the current setup, because the whole =

> > suspend() phase is so messy, and we try to solve everything in one sing=
le =

> > pass, and one single function call.
> =

> As an immediate incremental improvement, we could add a prepare_suspend()
> callback that would be called before userspace is stopped and a
> finish_resume() callback that would be called after userspace has been
> started again.

I basically have this patch finished. I'll post when I've tested the last =

version (I already tested my previous one and it worked, I just want to =

expand on it).

In fact, I did the second stage too, which is to do the "suspend_late" and =

"resume_early" parts too. It actually simplified a number of assumptions =

in the current power management code.

> Yes, most drivers, especially of the PCI variety, can do something pretty
> simple when suspending, but only if we have the right infrastructure in p=
lace.

Absolutely.

Which is what I'm trying to put in place, so that drivers don't have to do =

the extra work that really isn't on "their level" anyway.

Now, I'm not claiming that the rewrite will be perfect, but I've _already_ =

got a fairly small patch:

	[torvalds@macmini linux]$ git diff | wc -l
	338

that not only compiles, but actually implements the suspend as a =

five-stage process and _works_ (of course, it works mainly because most =

drivers only _use_ two of the five stages, but that's all part of the =

plan: I don't want to rewrite a million drivers, I want to prepare the =

infrastructure so that drivers can be written more simply and robustly in =

the future - and _fixed_ more simply when they don't work now).

So basically, instead of =


 - suspend
 - resume

in my current tree I have

 - suspend_prepare (I went with Ben's name, maybe that strokes his ego =

   enough that he'll admit it's better now)
 - suspend (same as old)
 - suspend_late
 - resume_early
 - resume (same as old)

(and I really wanted to do a "resume_finish()" too after user-land resume, =

just to have the "reverse" three phases of resume as I have of suspend, =

but I decided I didn't have any driver that I would make use of it =

personally)

> One thing that might help us get there is if we passed a suspend notifica=
tion
> to the class devices (i.e. the higher level subsystems).

Good point. We probably should. That really really makes sense, and that =

also automagically solves the "network device" issue.

I'll do that too, it actually looks pretty simple (famous last words).

> I'm curious about your thoughts on runtime suspending of devices are, suc=
h as
> the resource rebalancing or cpufreq cases I suggested earlier. =


I really don't see that as my primary worry. Runtime suspend is "nice", =

but it's not a _primary_ goal for me.

I think it should be pretty easy to implement, and I think your subsystem =

suspend notification thing would help a lot (to basically guarantee that =

the subsystem doesn't try to use it).

> Do you have any opinions on how this might be handled?  So far, I've =

> been favoring usage of the same sort of freeze() mechanism used for =

> preparing for memory snapshots etc.

Let me reboot my current kernel to test my current five-phase thing, and =

I'll do the subsystem thing too.

My off-the-cuff plan for that is to just add a "suspend(dev, state)" =

callback to the subsystem structure, and have device_suspend() call the =

subsystem suspend function before it even calls the actual device suspend =

function (and in reverse order on resume, of course).

Again - I'm not actually planning on doing very many individual drivers =

(that's the point I _don't_ care about), I want the support infrastructure =

to be sane.

(That, btw, obviously indirectly means that I'm not willing to break =

existing drivers - my infrastructure is strictly a _superset_ of what they =

get now).

			Linus
