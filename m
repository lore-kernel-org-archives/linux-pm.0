From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 27 Jun 2006 11:50:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606271137120.3927@g5.osdl.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
	<20060627060810.GD4264@neo.rr.com>
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
	<1151391516.2350.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151391516.2350.55.camel@localhost.localdomain>
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



On Tue, 27 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> I'm not sure actually _why_ we should have irqs off if we do the job
> properly

If we were able to do the job properly, I'd agree.

I just claim that the last few years have shown that we aren't.

I want that last suspend_late/resume_early to be done with interrupts =

disabled exactly because most of the problems I've seen in suspend/resume =

have been due to things like some subsystem calling into a driver that was =

partially shut down, or a shared interrupt happening for a driver that =

can't take it any more etc etc etc.

So for me, the absolutely _humongous_ advantage to doing the last (and the =

very first) phase with irq's off and in single-CPU mode is exactly that =

people _do_ get it wrong.

So I'd much rather have a more limited mode that allows people to =

basically think of suspend as something very controlled where nothing else =

happens, and they can _depend_ on that.

And the thing is, if you want to write a perfect driver, you still have =

that _option_. You don't have to use the late/early suspend if you don't =

want to, as a driver writer. =


I absolutely hate complexity and "perfect". I'd _much_ rather see the =

model be that you're in this really really limited mode when you do the =

final suspend, and have people do bit-twiddling and busy-waits. It may =

sound inconvenient, but the thing is, from a driver writer perspective, I =

think enforcing limitations is actually _good_.

For example, I hate ACPI and EFI with a passion. I actually think that the =

old stupif BIOS is infinitely more preferable as a loader, exactly because =

it's _so_ stupid that people don't try to do something clever in it, and =

don't try to use it. But because of that stupidity it _works_.

Suspend/resume shouldn't need to be "good". It doesn't need =

multi-processing, and the final (and most fragile phases) of turning off =

the core components of the montherboard doesn't need interrupts.

What if the interrupt controller or timers or whatever aren't strictly a =

"parent" of the devices that need it? THAT'S OK.

(It's also more than OK - it's a fact of life on some things. It should be =

ok to shut off the interrupt controller before you shut off some devices, =

and it should be ok to bring core devices up before the interrupt =

controller is even working).

So all of this means that I don't think the system should be "live" during =

the last phase. It should be as dead as humanly possible.

			Linus
