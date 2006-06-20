From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 08:44:53 +1000
Message-ID: <1150843494.1901.42.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
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


> The "sharign code" and "avoiding mistakes" argument is fine, but it's =

> totally bogus in this case.
> =

> The thing is, if you want to, you can share it the other way around (ie =

> make your "suspend()" routine first call the "freeze()" routine).
> =

> And there's a HUGE difference between "freeze()" and "suspend()". If you =

> look at the only user that actually _wants_ this, look at disks, for =

> example.

Well...

> For suspend, you _want_ to spin down the disk. No ifs, buts or maybes =

> about it. =


So far, yes.

> For freeze(), you absolutely do NOT want to spin down the disk - in fact, =

> as far as the disk is concerned, a "freeze()" should be a total no-op =

> (it's the disk _controller_ that cares).

Yes, as far as the disk is concerned. Not the disk controller, nor, for
what matters, the disk driver since that's the one having the request
queue (unless you can block queuing at the controller level, I suppose
SCSI can though beware of timeouts, but IDE can't for example), but
yeah.

> So trying to make "suspend()" do a "freeze()" is fundamentally wrong.

Ugh ? Why not ? Why is it wrong to freeze incoming requests when doing
suspend(). You need to atomically spin down the disk _and_ prevent
further requests from coming when doing a system-wide suspend. If you
don't, you get the risk of a request sneaking in and waking your disk up
just as you are about to switch power off from it or whatever else
happens when the box enters S3.
  =

> It is absolutely _not_ a case of "drivers will do something sane by defau=
lt", =

> it's exactly the reverse. Mixing the two makes drivers do _in_sane things =

> by default.

But they will :) If you look at IDE, actually spinning down the platter
or not is a very simple decision in the suspend process (which is a
state machine). About 95% of the code in there is absolutely identical
between the freeze and the suspend case. It's only a "detail" that when
doing suspend we actually go hit the disk with a spindown request.
 =

> The "most drivers" argument is also pretty bad. The fact is, most drivers =

> probably don't need to do a whole lot for _either_ freeze nor suspend. Th=
e =

> drivers that matter aren't "most drivers", it's the "special cases". =


They do need at least a minimum to avoid touching hardware after it's
been powered down since that will blow up on a whole range of machines
(yeah yeah... most x86 just don't care about PCI aborts but it's still
very wrong and other architectures will blow up on you). That's for
suspend(). For freeze, it depends on how consistent you need your saved
memory image to be. Again, drivers can have intricated internal state
data structures. Saying we can always recover it from scratch on resume
is true on paper, it's not in reality when you have to also take care of
the subsystem which the driver interact with. Take audio drivers: it's
easy to just restart the chip and reprogram stuff etc... on resume() but
if the internal state of alsa got snapshoted at the wrong time when not
idle, go get it not blow up in all sort of weird ways.

The problem with your approach is that it's actually very fragile unless
very driver and subsystem has a very robust resume() function. =


> And the special cases may not even be hard. For example, take the disk =

> case above. Disks are generally _trivial_ to suspend.

No they are not. You need to make sure of pending tagged commands
completion (along with all the possible error handling that goes with
them) and sychronize the request queues, atomically block them while
still having a way to send your own low level commands to the disk to
spin it down. No it's not simple.
 =

> You just basicallyt tell them to. You're done. The thing is, trying to mi=
x up freeze with =

> suspend just fundamentally confuses and misses the whole point, and then =

> you start passing in flags to separate the two cases.

No. Suspend is just a superset of freeze. I don't understand how you can
think otherwise. It's true in pretty much all cases. Thinking
differnetly will just confuse people, especially driver writers, and
will lead to an incredible amount of bugs all over the place.

> But passing in flags ("we call the same routine, but you had better know =

> that you should do two totally different things depending on the =

> arguments") is _really_ bad for drivers. Driver writers simply don't =

> understand why they are being called, usually. It needs to be explicit in =

> the code, not implicit in some rules that most driver writers can (and do=
) =

> ignore.

Ben.
