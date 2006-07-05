From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 5 Jul 2006 13:12:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607051305070.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060627060810.GD4264@neo.rr.com>
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
	<200607051140.14194.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607051140.14194.david-b@pacbell.net>
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



On Wed, 5 Jul 2006, David Brownell wrote:
> =

> I expect this is what you meant, but one issue I've observed
> on at least one platform is that after swsusp resume the preempt
> count is goofed ... it's one too big.  Which in a recent test, meant
> that resume failed because pci_set_power_state() got called in a
> context that couldn't msleep().  And in previous tests has led to
> similar failures, since resume() calls all expect sleeping is OK
> (since that's part of that API contract).

Yes. =


I had a patch that did

	system_state =3D SYSTEM_BOOTING;
	..
	system_state =3D SYSTEM_RUNNING;

around the final stages of suspend/resume, because the resume stage really =

_does_ end up looking like the boot: single CPU, various special code etc.

And that gets rid of some of the warnings, and is arguably a valid thing =

to do (exactly because it's "true" to some degree that we're in the bootup =

state).

At the same time, it's certainly equally arguable (or more so) that the =

warnings are actually valid, even during bootup, and the code that causes =

them should be fixed.

> The last time I saw this problem I threw in a hack to drop that
> count before starting the device resume calls, but I'm rather
> curious why it happens at all.  Does this ring bells for anyone?

Some of the warnings will trigger for doing things like taking a semaphore =

with interrupts disabled, or with a spinlock held (which will raise the =

preemption count).

Again, the warning is indubitably technically _correct_, but it's also =

equally arguably true that when you're in the final single-threaded state =

(which is equal to bootup), it's also correct to say that you know that no =

semaphores should actually ever trigger, and it's often better to re-use =

the same code that works in the general case, even if the boot phase (or =

suspend/resume phase) doesn't need the locking.

So I could go either way. The "system_state" thing above has the advantage =

that it works, is simple, and shuts up arguably spurious warnings. On the =

other hand, I also can't argue _too_ strongly against anybody that says =

that you shouldn't do certain things during the early bootup or late =

shutdown, exactly because you're running in a degenerate state.

So "fix the code instead" is clearly also a good thing to do, I'm just not =

sure that it's always worth the pain (and often duplicated code).

		Linus
