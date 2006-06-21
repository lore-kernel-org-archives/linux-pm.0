From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 20 Jun 2006 21:36:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606202125460.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<1150843494.1901.42.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201744220.5498@g5.osdl.org>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
	<1150858653.12507.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202008290.5498@g5.osdl.org>
	<1150862396.12507.103.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
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



On Tue, 20 Jun 2006, Linus Torvalds wrote:
> =

> It's a perfectly valid operation to create a snapshot AND CONTINUE =

> RUNNING! You can create a million snapshots, and only later decide that =

> you want to resume one of them after you've rebooted much later.

Btw, don't get me wrong. I know full well that for full running =

snapshotting you actually need to snapshot the disk contents too (or at =

least the filesystem image - you can do it with a "networked" filesystem =

and a filesystem snapshot capability).

That has no impact on my basic point: STD is not "suspend".

It really _is_ "snaphot", with some things done to limit the damage to =

"external" images like filesystems by basically making them read-only when =

creating the image, and restoring the image before turning them back into =

read-write.

To actually create a potential for doing "full snapshots" you'd have to do =

more work, but it could (and probably would) be done ON TOP OF a kernel =

level snapshot as created by the suspend-to-disk code.

I dare you to show _any_ "suspend" activity in suspend-to-disk. Because =

there is none. So I call total bull on your claim that it's 95% shared =

code.

For example, the _real_ suspend case (ie non-snapshotting case) has no =

reason what-so-ever (apart from debuggability) to really stop any queues =

etc. So if you want to do _real_ suspend, what you should do is exactly =

what you propose: make it built up around the device model. Except you =

don't actually need to empty or stop any queues, you just stop the devices =

from handling them.

See? There's absolutely zero overlap in functionality. The two approaches =

literally do totally different things. =


			Linus

PS. The real reason to make queues be quiescent when doign suspend-to-RAM =

is different: if you never come back from the suspend, you should try to =

have what approaches a clean "dirty shutdown". So you actually do want to =

do "sync" and wait, not because you technically need to, but because it's =

a whole lot safer if you end up disconnecting your machine from a power =

source and forget about it.

PPS. And debugging. Suspend/resume is hard enough and error-prone enough =

even without having to worry about the machine doing tons of stuff.
