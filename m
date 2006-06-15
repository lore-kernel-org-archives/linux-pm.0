From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 15:44:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151541100.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606151625360.8641-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606151345000.5498@g5.osdl.org>
	<20060615211031.GA2255@elf.ucw.cz>
	<Pine.LNX.4.64.0606151446350.5498@g5.osdl.org>
	<20060615222115.GG2255@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615222115.GG2255@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Pavel Machek wrote:

> Hi!
> =

> > > Okay, so .. in your model you can simply save state *during driver
> > > init*, right at boot.
> > =

> > Basically.
> > =

> > Except in practice user actions/setups can change it, and in practice y=
ou =

> > really do want to save it later, because you may not need to save it at =

> > all. =

> =

> _If_ user actions can change it, there's nothing that prevents user
> from changing it just after suspend started. Remember -- you wanted
> userland enabled at that point.

Yes, but I also hate havign to depend on the distribution always doing the =

right thing. They usually don't.

For example, things like the user usign a mixer to set volume levels on an =

audio device: it's just much _nicer_ if we save the volume levels just =

before we suspend, instead of expecting crazy alsa deamon crud to notice =

that it was suspended and restore things for us. =


The "user level can do it" thing is clearly _true_, but at the same time, =

we've often seen how user level gets less TLC than the kernel, so in most =

cases, the answer is still "..but if we can do it easily in the kernel and =

not involve user land, let's do it".

And in many ways it's just _easier_ to save the state just before =

suspending, than save it at first boot. So it's not like there is any =

_advantage_ to doing it the hard way.

		Linus
