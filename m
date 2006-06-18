From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 11:18:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181113000.5498@g5.osdl.org>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Sun, 18 Jun 2006, Linus Torvalds wrote:
> =

> The "most drivers" argument is also pretty bad. The fact is, most drivers =

> probably don't need to do a whole lot for _either_ freeze nor suspend. Th=
e =

> drivers that matter aren't "most drivers", it's the "special cases". =


Btw, you've gotten off the basic reason we'd want to do this in the first =

place: keep the system alive throughout the process, so that you can do =

"printk()" and other debugging, even while you're suspending one device, =

without having to have horrible hacks about where to reach the console.

If you want to be able to debug as much of the suspend process as =

possible, you have two choices:

 - don't suspend devices until the very end (ie have a separate and =

   well-defined "freeze", which doesn't actually need to really shut =

   things off)

 - turn off all console activity and/or have horrible hacks that won't =

   work anyway to try to figure out when it can print things and when it =

   can't.

I think the first option is the one that actually works. Right now, to get =

my machine to suspend successfully (with the current broken "suspend =

everything"), I have to turn off the console much much _much_ too early. =

That's what I'm trying to get away from.

		Linus
