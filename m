From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 28 Jun 2006 08:09:27 +1000
Message-ID: <1151446167.2350.79.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
	<20060627060810.GD4264@neo.rr.com>
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
	<1151391516.2350.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606271137120.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606271137120.3927@g5.osdl.org>
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


> What if the interrupt controller or timers or whatever aren't strictly a =

> "parent" of the devices that need it? THAT'S OK.

Sure and we have sysdev's for these low level things, those _do_ get
suspended with IRQ off. I hate sysdev's for many reasons but not that
one :)

> (It's also more than OK - it's a fact of life on some things. It should b=
e =

> ok to shut off the interrupt controller before you shut off some devices, =

> and it should be ok to bring core devices up before the interrupt =

> controller is even working).
> =

> So all of this means that I don't think the system should be "live" durin=
g =

> the last phase. It should be as dead as humanly possible.

Yeah, I see your point, and it does make sense, but I still need to find
a solution for the problem of the console semaphore :) I might have to
keep fbdev's in the first phase for now.

Ben.
