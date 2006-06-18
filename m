From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 10:48:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606181016.47561.david-b@pacbell.net>
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



On Sun, 18 Jun 2006, David Brownell wrote:
> =

> However, I liked Ben's comment there:  making freeze() be a mode of
> suspend() processing ensures that the 95% (by my recent audit) of Linux
> drivers that really don't know anything about power management will be
> doing something sane, because they'll treat FREEZE requests by default
> the same way they treat SUSPEND ones.

The "sharign code" and "avoiding mistakes" argument is fine, but it's =

totally bogus in this case.

The thing is, if you want to, you can share it the other way around (ie =

make your "suspend()" routine first call the "freeze()" routine).

And there's a HUGE difference between "freeze()" and "suspend()". If you =

look at the only user that actually _wants_ this, look at disks, for =

example.

For suspend, you _want_ to spin down the disk. No ifs, buts or maybes =

about it. =


For freeze(), you absolutely do NOT want to spin down the disk - in fact, =

as far as the disk is concerned, a "freeze()" should be a total no-op =

(it's the disk _controller_ that cares).

So trying to make "suspend()" do a "freeze()" is fundamentally wrong. It =

is absolutely _not_ a case of "drivers will do something sane by default", =

it's exactly the reverse. Mixing the two makes drivers do _in_sane things =

by default.

The "most drivers" argument is also pretty bad. The fact is, most drivers =

probably don't need to do a whole lot for _either_ freeze nor suspend. The =

drivers that matter aren't "most drivers", it's the "special cases". =


And the special cases may not even be hard. For example, take the disk =

case above. Disks are generally _trivial_ to suspend. You just basicallyt =

tell them to. You're done. The thing is, trying to mix up freeze with =

suspend just fundamentally confuses and misses the whole point, and then =

you start passing in flags to separate the two cases.

But passing in flags ("we call the same routine, but you had better know =

that you should do two totally different things depending on the =

arguments") is _really_ bad for drivers. Driver writers simply don't =

understand why they are being called, usually. It needs to be explicit in =

the code, not implicit in some rules that most driver writers can (and do) =

ignore.

		Linus
