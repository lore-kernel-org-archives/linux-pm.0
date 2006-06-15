From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 15:18:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151502150.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606151720350.10244-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606151720350.10244-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Alan Stern wrote:
>
> Here's what you actually did say:
> ---------
>
> > To have DMAs stopped, you need to "freeze" the devices.
> =

> No you don't. =

> =

> You need to stop the high-level _queues_, but that's something totally =

> different from actually stopping the _devices_.

Right. =


What you _do_ need to do, is stop the user-level actions.

Ie by "higher-level queues", we're talking stuff that has nothing at all =

to do with device drivers any more.

Before you suspend, you need to make the machine quiescent, in other =

words. The devices are still working, but you really really don't want to =

do this while things are still _happening_.

Now, with suspend-to-RAM, I suspect we could even avoid that until the =

very last phase (ie the actual suspend code). But quite frankly, from a =

pure debuggability standpoint, I do think we want to basically try to make =

everything as quiet as humanly possible.

And from a suspend-to-disk standpoint, the act of starting to write to =

disk really requires that everything is "done", so you had better have =

_nothing_ else than the actual write-to-disk actually happening. That's =

also the thing where a "save_state()" may actually want to flush its =

queues entirely and replace them with a known-temporary thing.

But the point is, the devices really have to be able to handle things that =

can happen during suspend, even after their state has been "saved". They =

can't just stop. That would be a bug - or it would require totally insane =

special casing, which is effectively what we do now.

So think about what we do now: We special-case X, and we special-case the =

save-to-disk device, and we special-case the console printouts, and we =

special-case a lot of other things, AND WE STILL GOT IT WRONG. Try using =

netconsole, and see it blow up in your face without my changes (it _might_ =

work with some network drivers, but I looked at the sky2 driver, and I =

suspect that apart from the stupid bug where it didn't actually do a =

pci_save_state(), it's probably one of the _better_ ones).

And the thing is, all those special-cases are all really doing the same =

thing: "keep the device alive despite shutting it down". Really. I'm not =

making that up. In the case of X, we did it the other way around, namely =

in that case, the special case was not keeping the device alive, but =

instead just saving the state separately (and early) from all the other =

drivers. Which I'm just saying we should do for _everyting_.

At some point, somebody just _has_ to realize, that the problem was =

shutting the damn thing down in the first place! If you just save the hw =

state that you need to save, and let the device itself continue work, =

suddenly all the special cases just go away.

Poof. They're gone.

And yes, I admit (and I started off talking about this) that I care a lot =

more about suspend-to-ram than I do about suspend-to-disk. I seriously =

claim that STR _should_ be a lot simpler than suspend-to-disk, because it =

avoids all the memory management problems. The reason that we support =

suspend-to-disk but not STR is totally perverse - it's simply that it has =

been easier to debug, because unlike STR, we can do a "real boot" into a =

working system, and thus we don't have the debugging problems that the =

"easy" suspend/resume case has.

Wouldn't you agree?

Which is obviously also why patch 1/2 (and in many way the more =

fundamental one) was about trying to make debugging much simpler. Or at =

least possible.

			Linus
