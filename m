From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 20:16:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152008160.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<1150421516.7725.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150421516.7725.88.camel@localhost.localdomain>
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



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> But what is the point ? What is the relevance of a state saved if it can
> be made invalid right away by processing of IOs ? I can save state at
> any time and suspend 2 hours later, how relevant that state is ? Why not
> save the state at boot and re-use it later ? Doesn't make sense to me :)

It _can_ be saved at boot, and re-used later. I already answered this =

exact question when Pavel asked.

> But the hardware state changes as soon as you process requests (run IO
> queues).

No it doesn't. Anything like that is not state that needs to be saved. I =

don't consider it "state", it's just a temporary thing.

> Sure, you don't save the content of the queue for network. At least the
> drivers I've cared about so far don't bother, they just drop packets.
> But block drivers need to block the queue as they can't afford to lose
> requests.

It's not up to the block driver, that's the thing.

The _user_mode_ requests should just be stopped (you don't need to block =

the queue - you just stop the processes). Then you wait for the queue to =

drain. End of story.

BUT YOU DON*T STOP THE DEVICE QUEUE. Because if you did, that would mean =

that you couldn't save the state.

> Saving the PCI interface "state" (BARs etc...) is a very small subset of
> the HW state. That one could probably be done out of line vs. the rest.
> In fact, that specific state can probably even be saved once at driver
> init time and be done with it :)

For a lot of hardware, it's literally the only state that needs to be =

saved at all.

(and no, you don't necessarily even need to save it, you can often =

re-generate it).

Note the "often". Quite often you can't. Things like cardbus controllers =

will be set up by the POST to have all the right things, and you literally =

can't re-generate it, because it depends on the motherboard. That's when =

you save it.

(Or, even more commonly, you save it just because it's easier than =

regenerating it)

> Of course they do. Or we have a different notion of what you call
> "state" here...

Yes. I think that's the main stumbling block.

You consider "state" to be everything, whether needed or not. And I don't. =

I consider "state" to be the things that "resume()" _requires_ to get =

going again, which is actually a lot lot smaller.

And exactly because I don't think it means "every bit", _my_ viewpoint =

actually matches reality. It matches - for example - _exactly_ what we =

already do wrt X. We (and here, the "we" is obviously mostly the X server) =

need to save enough state to _recreate_ the state before suspend, but that =

does not need that we need to save each bit.

It's actually also what a lot of drivers already do. Several drivers' =

suspend routines don't actually need to save anythign at all, they just =

turn the device off - exactly because they can recreate all the state =

_without_ saving anything.

			Linus
