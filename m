From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:22:15 -0700
Message-ID: <200606211422.15429.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606202125460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202125460.5498@g5.osdl.org>
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

On Tuesday 20 June 2006 9:36 pm, Linus Torvalds wrote:
> =

> =

> For example, the _real_ suspend case (ie non-snapshotting case) has no =

> reason what-so-ever (apart from debuggability) to really stop any queues

Not quite true, as you touch on below ...


> etc. So if you want to do _real_ suspend, what you should do is exactly =

> what you propose: make it built up around the device model. Except you =

> don't actually need to empty or stop any queues, you just stop the device=
s =

> from handling them.
> =

> See? There's absolutely zero overlap in functionality. The two approaches =

> literally do totally different things. =

> =

> 			Linus
> =

> PS. The real reason to make queues be quiescent when doign suspend-to-RAM =

> is different: if you never come back from the suspend, you should try to =

> have what approaches a clean "dirty shutdown". =


Actually, even when you _do_ resume correctly you want the I/O queues
to have been shut down cleanly.  You need to think about intermediate
cases like removable media (partially covered in your "sync" case) and
the fact that there are other removable stateful peripherals than media.

- Dave


> So you actually do want to  =

> do "sync" and wait, not because you technically need to, but because it's =

> a whole lot safer if you end up disconnecting your machine from a power =

> source and forget about it.
> =

> PPS. And debugging. Suspend/resume is hard enough and error-prone enough =

> even without having to worry about the machine doing tons of stuff.
> =
