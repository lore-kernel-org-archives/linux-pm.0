From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 08:21:33 +1000
Message-ID: <1151014893.4046.24.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
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

On Thu, 2006-06-22 at 09:10 -0700, Linus Torvalds wrote:
> =

> On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > How so ? What is insane in expecting that settings you have done to your
> > controller are restored to the last settings you did when you resume ?
> =

> No. It's insane to do controller setup while a suspend is going on. We ca=
n =

> make it impossible if you want (easy enough - just stop user land), but =

> the point is that you're worrying about ALL THE WRONG THINGS.

The problem is that what you call "controller setup" might well happen
as part of normal operations of a given device. A lot of pieces in the
system (both subsystems and userland) have no idea that a suspend is in
progress and that they should stop doing that sort of thing. Of course
we could add inftastructure for _that_, and then try to fix everybody
(including userland). Though how would partial tree or dynamic suspend
fit in that picture ?

(To re-use a couple of examples, automatic timing demotion on CRC
errors, automatically rotating encryption keys, I'm sure we could find a
lot more by just looking a bit more closely at various devices).

I'm really convinced that the model where suspend() is the one to block
requests processing _and_ save state is the right one. At last for STR.
It's robust and will always give you back the device in the exact state
that was last set by a client.


> The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. =

> I have never _ever_ met a laptop or machine of mine that "just worked". =

> I've always had to fix something, and people always end up having to do =

> something ridiculous like unlink all modules etc.
> =

> If that isn't what worries you, you're on the wrong page. =


It does worry me that it is indeed the situation on x86 (though it tends
to "just work" on powerbooks), but I doubt it has anything to do with
this specific aspect of the model we are using.

I _do_ think we need to add this prepare/finish mecanism however, to fix
the very real problem of drivers doing things like request_firmware() in
resume() and to tell bus drivers to stop inserting new devices in (that
will help a lot with USB as we discussed with David).

I also think we might make things more stable by having things like
get_free_pages() silently add NOIO when the suspend() cycle is started
(after all prepare() and before all suspend()).

Then we have abuse of sysdev's who are sort-of out of the normal
device-tree and subsystems like cpufreq abuse them in ways that are
problematic with suspend/resume. This is a bug/misdesign in those
subsystems though.

And of course there is still drivers who simply don't have or don't have
working suspend/resume notifiers and there is the various ACPI problems
we had in the past etc...

So all of the above are things we could/should work on to make things
more stable. Yes, we _do_ have room for improvements. I don't think that
changing the entire model is the right answer as I don't think the model
is at fault. As I wrote, I'm not convinced that your split save_state()
and later suspend() will make things any more stable nor get drivers in
any better shape.

Another problem is STD. I've avoided it so far because I wanted to point
out at the specific issue I have with save_state() vs. suspend(). for
the STR case...

We have historically implemented the "freeze" thing by doing a sort-of
"light" suspend (via this argument passed to suspend) based on the logic
that even if devices don't _have_ to suspend to get a stable snapshot,
doing so will be good enough. That is, suspend is in all the ways that
matter a superset of what is needed (DMA off basically is all that is
needed). Which means that it was possible to get something out quickly
by just re-using the existing infrastructure and thus the existing
callbacks in a lot of drivers, with an argument to "optimize" things in
order, for example, to avoid spinning down the platter on IDE or things
like that.

I agree that is not pretty not a generic snapshotting mecanism and I do
agree that it might be a good idea to re-think that part of it and maybe
introduce a speparate freeze() callback to drivers for use by STD that
would only be implemented by those who care. However, there is the exact
same problem with dynamic state here that there is with STR: that state
that is stored in hardware has to be saved and later restored.

The only reason why in the specific case of STD, a split save_state
might work, is that we should have stopped everything in the kernel
before hand in order to get a stable image. But do we really want to add
a separate save_state just for the use of STD ? I don't think it's very
smart... in fact, if you think about it this way, freeze() is the right
place to save the state.. and what happens when you start actually
implementing that in drivers ? You end up with a lot of code that looks
strangely exactly the same as what you have done in suspend()... =


So my point here is that having this suspend(freeze) mecanism, while
possibly not pretty, actually _works_. Dumb drivers might just suspend
all the time, that's sub-optimal, but _works_. Smarter drivers can then
split that into separate implementations. It might be better to split
that into 2 different callbacks, but that's almost a detail.

I think you are trying to change a model that is not broken... what are
broken are drivers, they need to be fixed and they will be broken with a
different model too. I do not beleive that a split save_state/suspend
will make things easier to driver writers, in fact, I think we'll get a
lot more sneaky bugs due to the loss of state scenario I've explained in
my previous emails.

Ben.
 =
