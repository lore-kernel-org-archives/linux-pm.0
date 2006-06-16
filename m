From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 14:04:55 +1000
Message-ID: <1150430695.15202.2.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<1150421516.7725.88.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606152008160.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152008160.5498@g5.osdl.org>
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

> It's not up to the block driver, that's the thing.
> =

> The _user_mode_ requests should just be stopped (you don't need to block =

> the queue - you just stop the processes). Then you wait for the queue to =

> drain. End of story.
> =

> BUT YOU DON*T STOP THE DEVICE QUEUE. Because if you did, that would mean =

> that you couldn't save the state.

My experience has been that relying on userland being stopped -> no more
driver activity isn't going to work. Things like read-ahead or other
niceties (not even talking about filesystems that scrub things in the
background or kernel based web/nfs servers ;)  will defeat that.

> Note the "often". Quite often you can't. Things like cardbus controllers =

> will be set up by the POST to have all the right things, and you literall=
y =

> can't re-generate it, because it depends on the motherboard. That's when =

> you save it.

Yeah, well, video cards enter in that category... I have code that can
bring back some radeon's from D3 cold for powermac provided I saved a
whole bunch of registers beforehand.

> (Or, even more commonly, you save it just because it's easier than =

> regenerating it)
> =

> > Of course they do. Or we have a different notion of what you call
> > "state" here...
> =

> Yes. I think that's the main stumbling block.
> =

> You consider "state" to be everything, whether needed or not. And I don't=
. =

> I consider "state" to be the things that "resume()" _requires_ to get =

> going again, which is actually a lot lot smaller.
> =

> And exactly because I don't think it means "every bit", _my_ viewpoint =

> actually matches reality. It matches - for example - _exactly_ what we =

> already do wrt X. We (and here, the "we" is obviously mostly the X server=
) =

> need to save enough state to _recreate_ the state before suspend, but tha=
t =

> does not need that we need to save each bit.

I agree that your viewpoint matches reality, it's just that I wouldn't
have called it 'state' :) =


> It's actually also what a lot of drivers already do. Several drivers' =

> suspend routines don't actually need to save anythign at all, they just =

> turn the device off - exactly because they can recreate all the state =

> _without_ saving anything.

Ben.
