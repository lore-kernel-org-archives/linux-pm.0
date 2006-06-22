From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 14:58:17 +1000
Message-ID: <1150952298.3633.20.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
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

> If you did that, you'd get the old keys. =

> =

> Your complaint is like
> =

>   "Doctor, doctor, it hurts when I dig out my eyes with a dull spool"
> =

> OF COURSE it hurts. Don't do it.
> =

> Your example is insane.

How so ? What is insane in expecting that settings you have done to your
controller are restored to the last settings you did when you resume ?
Keys are an example, as is the IDE timing one you mentionned yourself
(and Im not talking about a user shooting himself in the foot with
hdparm here, the IDE layer might do timing demotion in case of too many
CRC errors for example), etc... =


So in all those examples where you said "don't do that", What should we
do ? not restore things at all ? What if those keys are used to talk to
your disk ? You resume and ... no disk ? What if userland sets some
settings in a device via a driver ioctl/sysfs/whatever, system suspends,
resumes, and you suddenly get the wrong settings because your save_state
happened before the last userland call ? =


Have you read my mail completely ?

I've talked to paulus about it, just to make sure I wasn't totally
insane (or maybe we are both !) and so far, he doesn't see a failure in
my reasoning. In fact, in every case where save_state() would be of any
use for actually, it's also the cases where we hit the problem I
described.

It essentially boils down to the 3 categories of "state" I've described
but I'll do it again:

 - Static. State that doesn't change. This is for example PCI config
state, that sort of thing. Could be saved at _any_ time, as far back
as ... driver initialisation. I don't see the need for a specific
callback for these.

 - Volatile: That's what you have very well described in a lot of your
examples: things that can be reconstructed, like current request pointer
etc... In many cases, hw state is also "cached" by the driver (for
example, your multicast filters setting are in your netdev structure
iirc, etc...) and thus that state can be considered "volatile" on the
hardware side since it can be reprogrammed in at resume time from those
cached data.

 - Dynamic: That's the interesting case. That's state that gets set into
the hardware upon client requests and that affects device operations.
Examples of that are numerous, from controller timings, encryption keys,
link type/speed/width, god knows what. Client here can be a dependent
driver (the disk driver changes the settings of the controller for a
given channel for example) or it can be userland (or a protocol stack,
like softmac changing the speed and tx power of your wireless, etc etc
etc...). That's exactly the sort of thing one may want to save and later
restore. That is, if it's not already cached by the driver in some
memory data structure in which case it goes into the volatile category
and doesn't need save_state. Now if you think a bit about it... those
states you want to save from your hardware to restore later... how can
it make sense at ALL to save that state at any random point in time
during suspend (which is bascially what your save_state) is while it can
still and will be changed by the clients of that driver ? Essentially,
what you propose is that on resume, devices that have such a state in
the hardware will come back up with some random version of what you put
there some time ago ... not the last you have set when suspending, no,
wahtever was there some time before ....

Please, show me the flaw in my argument, I haven't found it yet. I can't
find a case where save_state is useful (for actually saving some
hardware state) where it doesn't also need to be atomic to the actual
suspend (or rather to the "stop processing user requests" part of
suspend semantics).

Examples of such states ? well, you found one yourself, IDE timings. It
could be argued that the client (the disk drive here) should
re-negociate timings on resume though, in which case it becomes a
volatile state and doesn't need to be saved at all. SCSI link setup
(same thing, could be renegociated, so either you save it, or it's
volatile, but if you save it, you'd rather save something that matches
what your client think it is, that is what your client last set).
Encyrption keys in things like wireless, encrypted storage, etc...

In fact, there is not that many of these things. Most of the time, state
is volatile (that is cached by the driver). =


Now there is _one_ argument for having an early pass here is memory
footprint vs. static state. That is, all this state that does not change
(PCI config space, various video card registers that the BIOS has set
that you may need to save/restore, firmware, etc etc ....). I said you
can save it at init time. But you might not want to keep all that saved
stuff around all the time in memory for no good use, thus indeed, it
might be _convenient_ to have a call a bit before suspend to allocate
storage for those things, and possibly save them at that point.

In that case, save state becomes a convenience. But heh, we need that
prepare() call for all the reasons I described, so why not make it the
same. I do still think that the prepare() semantics (which is important
and required) is more important though than this "convenience"
save_state. Not only that, but save_state is confusing as it might lead
the driver writer to think he can safely also save what I described as
dynamic state in there, which he cannot safely as I explained already
enough I think.

Am I more clear or what ?

Ben.
