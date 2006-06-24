From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 10:22:22 +1000
Message-ID: <1151108543.16946.41.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
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

On Fri, 2006-06-23 at 16:44 -0700, Linus Torvalds wrote:
> =

> On Fri, 23 Jun 2006, Adam Belay wrote:
> > =

> > In my opinion, the point here is that the suspend functions are trying =
to
> > prevent access to hardware.
> =

> Yes. =

> =

> My point is that it's not needed for STR, has nothing to do with "driver" =

> (every driver needs to do it, and it doesn't actually touch hardware), an=
d =

> it's wrong.
> =

> And IT'S ONLY DONE BECAUSE THE INTERFACE SUCKS!

It's utterly completely and absolutely needed or your machine will burst
into flames ! Beside, that's new that you say that's not needed as well,
that wasn't part of your rant 2 days ago...

> It's really only needed with the current setup, because the whole =

> suspend() phase is so messy, and we try to solve everything in one single =

> pass, and one single function call.

Bla bla bla bla

> What I'd like to get to (and no, I realize that just ->save_state() will =

> _not_ get me there - it's just a first step) is a point where 99% of all =

> devices can literally do just something like
> =

> 	pci_save_state(dev);
> 	pci_set_wake_event(..);
> 	pci_set_power_state(dev, PCI_D3hot);
> =

> in their suspend routine. =


And just crash your machine as soon as something tries to call into the
driver after having done the above. Too bad ...
 =

> Now, in order to get there, we'll need a few more pieces. In particular, =

> it would require that this final suspend be called when interrupts have =

> been turned off. =


That's bullshit. How can USB operate without interrupts ? It can't. Thus
the final suspend will not be useable for anything below a USB
controller. Among others... That means that every driver that needs to
talk to it's hardware will have to run with "interrupts off"... thus
every driver will need some kind of demoted polled mode that they don't
necessarily have.

Thus your "final suspend" ends up only being useful for a small subset
of drivers

Also there is nothing magic about "interrupts have been turned off".
It's no magic, it won't prevent everything from happening. How do you
make sure you weren't in the middle of driver routine already ? You
can't. Thus you need your driver to _also_ be able to recover of suspend
being called at any fucking time while it was doing something and not be
able to synchrnize with things like semaphores etc...

That is totally insane.

> We can't do that right now, but I think we can split up "->suspend()" the =

> other way: split the remains into two, similarly to how "save_state()" is =

> for "stuff that can be done without any side effects". We would have =

> "early suspend with interrupts enabled" and "late suspend with interrupts =

> disabled".

We already do for the 2 drivers that actually care. That is NOT an
answer to the problem.

Now I can already see you coming with your big foot and claiming we just
don't suspend the driver... I'm giving up here. All I can say is you are
wrong. I've tries to explain via all possible ways that your model will
never ever produce anything reliable and stable, you don't beleive me,
then just go wild, break everything if that amuses you, I don't care
anymore.

You are trying to simplify something that can't be simplified.

> So, for a network controller, you'd leave "early_suspend()" as NULL, and =

> "late_suspend()" would basically be the above sequence. For a disk, you'd =

> make "early_suspend()" be the "flush cache" etc sequence, while the =

> "late_suspend" would be NULL.
> =

> See? Different devices want different things. Again, the current =

> "suspend()" has to cater to _all_ needs, which makes it very complicated. =

> Catering to _all_ needs means that it has to do things with interrupts on=
, =

> because _some_ users need it.

No. It has to cater the needs of suspend, which are well defined and not
that complicated at all. Besides, that's mostly NOT where the bugs are.
So stop trying to break everything to fix an illusory problem that don't
even exist in the first place.

> See a pattern here? It's exactly the same thing, all over again.

And you are totally wrong.

> Splitting it up really should make some things _much_ easier.
> =

> This, btw, is something we can (and probably should) do on the resume sid=
e =

> too. Again, "early_resume()" would be done before interrupts are enabled =

> and other cores are brought up. And "late_resume()" would be done with =

> interrupts on.
> =

> (And I think Ben is right, we might want to have a "final_resume()" which =

> is called when user mode has resumed).
> =

> And again, most devices probably want just one or the other, not both (or =

> all three). But just the fact that a device knows that it's =

> late_suspend()/early_resume() routines would be called with no interrupts =

> etc ever happening in between would make things _much_ easier for those.
> =

> And yes, some devices might want to actually use both. You might resume =

> controller state in early_resume() (allowing a simpler late_suspend() tha=
t =

> doesn't need to worry), and then actually do things like device =

> re-discovery in "late_resume()", because you need to wait for things). =

> =

> Which brings us back to the fact that I think "suspend()" tries to do too =

> many things as it stands now. It tries to handle all the cases, but =

> because it does so in one single phase, it's _really_fundamentally_hard_.
> =

> I really don't understand people who think that one routine is better tha=
n =

> five routines. I pretty much _guarantee_ that most devices will still jus=
t =

> have one or two routines, but they'll be simpler, just because they can b=
e =

> more directed rather than flailing around wildly and aimlessly because of =

> having just one interface that needs to make everybody happy.
> =

> Five simple routines are _superior_ to one complicated routine. That is =

> true even if the five simple routines end up having more lines of code.
> =

> 			Linus
