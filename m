From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 16 Jun 2006 14:15:30 +1000
Message-ID: <1150431331.15202.10.camel@localhost.localdomain>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
	<20060615204317.GC1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
	<20060615212724.GB2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151518380.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151518380.5498@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> X and video really isn't anything special. They are just the _obvious_ =

> problem. They are the problem that you can't avoid on _any_ machine: the =

> others you can just add special cases for on a one-by-one basis, and you =

> can get most setups working.

X is a bit special in fact in the sense that if you want something
reliable, including the ability you mentioned to be able to reconstruct
state on resume (because your state "saving", gosh, I don't like that
terminology, we aren't really saving a sate there) didn't stop
operations, you'll have to push whole new concepts all the way up the
stack... to things like X APIs, GL/DRI, etc...

For example, X can store pixmaps in vram. It needs to know the vram is
going away to migrate them back into main memory (or other storage).
Thus if we want to separate thing, we have to create new intefaces to X
so it gets a chance to do that (and fallback to a boring drawing mode
maybe until suspend) since I don't think you can just tell an X client
that a pixmap it owned just vanished.

Worse with GL. Clients store textures, fbo's (framebuffer objects),
etc... in vram and there is no GL interfaces to tell GL apps to bring
their stuff back in as the vram might become invalidated.

And that's just the tip of the X iceberg.

Thus it's definitely worth considering X as a special case for now (and
other gfx applications) and using the existing method of taking away the
VT from them is what will give us the best chances of not shooting
ourselves in the foot, at least for now. X might do things like
enable/disable AGP, which affects the config space (and thus even your
saved states if that makes any sense), etc... let's just not open that
can of worms right now :)

Ben.
