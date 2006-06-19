From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 20:54:36 -0700
Message-ID: <200606182054.36975.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday 18 June 2006 10:48 am, Linus Torvalds wrote:

> The thing is, if you want to, you can share it the other way around (ie =

> make your "suspend()" routine first call the "freeze()" routine).

Sure, I had the same thought.  Of course the distinction would be moot
unless the driver implements two distinct methods ... implying big
changes in both the infrastructure, and hundreds of drivers (which
will be especially hard to re-test).


> And there's a HUGE difference between "freeze()" and "suspend()". If you =

> look at the only user that actually _wants_ this, look at disks, for =

> example.
> =

> For suspend, you _want_ to spin down the disk. No ifs, buts or maybes =

> about it. =

> =

> For freeze(), you absolutely do NOT want to spin down the disk - in fact, =

> as far as the disk is concerned, a "freeze()" should be a total no-op =

> (it's the disk _controller_ that cares).

This has previously been the primary -- only? -- example of this class of
difference.  (Albeit with the previous definition of "freeze", which is
getting morphed a bit in this discussion...)  In fact freeze() has been
rather loosely defined, mostly by referring to that counterexample.

Do you see the case of consoles staying usable as being like no-spindown?
Or something different?  (Some of what you've said implied to me switching
to a different model than freezing driver stacks...)


> So trying to make "suspend()" do a "freeze()" is fundamentally wrong. It =

> is absolutely _not_ a case of "drivers will do something sane by default"=
, =

> it's exactly the reverse. Mixing the two makes drivers do _in_sane things =

> by default.

I think you're being excessive.  There are a handful of drivers that
will be atypical, no matter whether suspend() morphs to freeze() or
freeze() morphs to suspend().  Those drivers are ones that need to
be intelligent about PM.  The other drivers don't need to be, won't
get that attention regardless, and aren't hurt by the overkill of
implementing a freeze() request as suspend().


> The "most drivers" argument is also pretty bad. The fact is, most drivers =

> probably don't need to do a whole lot for _either_ freeze nor suspend. Th=
e =

> drivers that matter aren't "most drivers", it's the "special cases". =


True, and those special cases are going to get attention no matter
how the other issues get resolved.  That alone can't motivate one
approach over another.  Most drivers are PM-stupid.  (Except on some
embedded hardware, where they all must at least do software clock
gating just in order to let the system enter lower power states...)


> And the special cases may not even be hard. For example, take the disk =

> case above. Disks are generally _trivial_ to suspend. You just basicallyt =

> tell them to. You're done.

Most pieces of hardware are pretty easy to stick into low power states.
What's hard is getting everything quiesced, and ready to be suspended.
(Which is the guts of what a freeze does.)


> The thing is, trying to mix up freeze with  =

> suspend just fundamentally confuses and misses the whole point, and then =

> you start passing in flags to separate the two cases.

In the context of the current tree, I've certainly annoyed Pavel enough
by pointing out that the pm_message_t parameter to suspend() is just
a fancy boolean ("flag").  Luckily it's just _one_ for now (Mr Suspend
vs Mr Freeze) ...

And I agree, flags for tweaking state machine semantics just suck; they
make what looks like one transition become exponential in the number of
flags, and increase the number of states accordingly.  (Along with the
testing problem, especially since most of the new states are errors...)
That kind of code is a mess to repair.

The upcoming PM_EVENT_PRETHAW patches change that slightly, but I'm not
a huge fan of that approach either.  I can accept the model that suspend()
is just a "do the driver's next PM state machine transition" event trigger,
with the specific transition sometimes caring about the PM_EVENTs, and it's
certainly the most viable fix for that problem -- other than the simple one
of preparing for snapshot restore the way kexec() prepares for a new kernel,
which approach got flamed -- but I know there's got to be a better way to
solve those problems in the longer term.

 =

> But passing in flags ("we call the same routine, but you had better know =

> that you should do two totally different things depending on the =

> arguments") is _really_ bad for drivers. Driver writers simply don't =

> understand why they are being called, usually. It needs to be explicit in =

> the code, not implicit in some rules that most driver writers can (and do=
) =

> ignore.

See above, I've never liked that style either.  The saving grace is that
virtually no drivers actually need to _care_ about the details of suspend
transitions ... today.  When more drivers start to leverage the wakeup
capabilities of their hardware, or otherwise become PM-smart, those
dynamics will be changing.

The current suspend() driver model has flaws, and while I know some near
term fixes that are needed (the PRETHAW patches -- which move away from
"fancy boolean" -- and a clock model patch) I'd certainly agree that some
longer term revisions are also needed.

Not that I know what those longer term revisions are, or quite how to
take the current driver codebase and morph it...

- Dave
