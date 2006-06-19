From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 17:34:42 -0700
Message-ID: <200606181734.43450.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606181113000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181113000.5498@g5.osdl.org>
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

On Sunday 18 June 2006 11:18 am, Linus Torvalds wrote:
> =

> On Sun, 18 Jun 2006, Linus Torvalds wrote:
> > =

> > The "most drivers" argument is also pretty bad. The fact is, most drive=
rs =

> > probably don't need to do a whole lot for _either_ freeze nor suspend. =
The =

> > drivers that matter aren't "most drivers", it's the "special cases". =


Although designing for the special cases creates its own flavor
of nightmare.  How does it go ... "easy things should be easy,
and hard things should be possible".  I've seen systems where
people tried to make the hard things easy, thereby making the
easy things hard.  (Which caused lots of people to switch to
other systems as soon as they had the opportunity...)

Special cases are always going to be special cases.


> Btw, you've gotten off the basic reason we'd want to do this in the first =

> place: keep the system alive throughout the process, so that you can do =

> "printk()" and other debugging, even while you're suspending one device, =

> without having to have horrible hacks about where to reach the console.

It's all interconnected.  I referenced that goal in my response
to Pavel's "why bother" question.   In this sub-thread I'm just
responding to some of the "what-if..." comments.


> If you want to be able to debug as much of the suspend process as =

> possible, you have two choices:
> =

>  - don't suspend devices until the very end (ie have a separate and =

>    well-defined "freeze", which doesn't actually need to really shut =

>    things off)
> =

>  - turn off all console activity and/or have horrible hacks that won't =

>    work anyway to try to figure out when it can print things and when it =

>    can't.
> =

> I think the first option is the one that actually works. Right now, to ge=
t =

> my machine to suspend successfully (with the current broken "suspend =

> everything"), I have to turn off the console much much _much_ too early. =

> That's what I'm trying to get away from.

Yeah, me too.  It should work for retro-cool serial consoles too.  ;)

- Dave
