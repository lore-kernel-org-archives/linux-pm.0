From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console
	handling	during	suspend/resume
Date: Fri, 16 Jun 2006 11:03:36 +1000
Message-ID: <1150419816.7725.53.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150324014.21941.23.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Peter Jones <pjones@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-14 at 18:26 -0400, Peter Jones wrote:
> On Thu, 2006-06-15 at 00:12 +0200, Pavel Machek wrote:
> > Hi!
> > =

> > > > > The debugging patch helped me figure out a number of the problems=
 (and =

> > > > > even more problems that then didn't actually make any difference =
once I =

> > > > > started getting things working ;)
> > > > > =

> > > > > And the console fixes is apparently what got things working in SM=
P mode. =

> > > > =

> > > > It works for some people _without_ that console fix.
> > > =

> > > Yes. It worked for me in UP and with several drivers removed without =
the =

> > > console fix. It didn't work for me when I did fancier stuff, netconso=
le in =

> > > particular ;/
> > =

> > I guess I'd much rather see
> > =

> > if (network_driver_suspended)
> > 	drop_message_on_the_floor() =

> =

> I think we have the same problems with e.g. fbcon .

fbcon has an interface to stop all access to the physical framebuffer.
It's called fb_set_suspend() and is meant to be called by the fbdev when
it's suspended.

Ben
