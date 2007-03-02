From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Thu, 1 Mar 2007 16:41:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703011631380.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070225175559.GC12392@stusta.de> <20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz> <20070227103021.GA2250@kernel.dk>
	<20070227103407.GA17819@elte.hu> <20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org



On Thu, 1 Mar 2007, Linus Torvalds wrote:
> =

> Once you have that, you now actually have a way to "correct" for that =

> known bug, and by correcting for the known bug, you now *can* separate th=
e =

> behaviour of the two bugs:
> =

>  - You can now re-do a totally mindless git bisection for the *other* bug=
, =

>    but what you now need to do is that at each bisection step, you look a=
t =

>    whether the bisection point has the known bug, and if so, you apply th=
e =

>    known fix for that known bug, and thus you can test the kernel =

>    *without* the interaction of the bug you already found.
> =

> This makes bisection a lot less automated (you have to apply the "fix" fo=
r =

> the other bug at each step)

Side note: it's still usually fairly easy. Especially if you have a known =

fix for the other bug, you can usually just do the equivalent of

	git cherry-pick <fixcommit>

at each point during this bisect (or just have a known patch that you keep =

applying and un-applying), and you're largely done.

Of course, if the area with the fix keeps changing, or if the fix is =

really intrusive and nasty, this gets hairy, but at least in this case the =

patch is fairly trivial and it shouldn't cause any trouble at all to do =

this.

The only real down-side is just the mindless extra work, and the possible =

added confusion you get from modifying the history at the points you're =

testing. "git bisect" is not necessarily happy about auto-picking a new =

bisection point with a dirty tree, for example, so before you mark =

something "good" or "bad", you should generally try to do so with a clean =

git tree (ie if you apply a patch at each stage, do "git reset --hard" to =

remove the patch before you do the "git bisect bad/good" stage).

Similarly, especially at the end of the bisection run, if you actually use =

"git cherry-pick" to *add* a commit, the bisection will now take that =

added commit into account when trying to pick the next commit to check, =

which is not what you really want. It probably doesn't matter that much =

during the early stages (when bisection is really jumping around wildly =

anyway, and one commit more or less doesn't really matter), but again, it =

might be a good idea to make a habit of undoing the cherry-pick, the same =

way you'd undo a patch (eg "git reset --hard HEAD^" would do it, if you =

have exactly one cherry-pick that you tested).

		Linus
