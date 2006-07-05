From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 5 Jul 2006 16:03:29 -0700
Message-ID: <200607051603.29787.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607051140.14194.david-b@pacbell.net>
	<Pine.LNX.4.64.0607051305070.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607051305070.12404@g5.osdl.org>
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

On Wednesday 05 July 2006 1:12 pm, Linus Torvalds wrote:
> =

> On Wed, 5 Jul 2006, David Brownell wrote:
> > =

> > I expect this is what you meant, but one issue I've observed
                    ^ "NOT" ... omitted by editing error, sorry
> > on at least one platform is that after swsusp resume the preempt
> > count is goofed ... it's one too big.  Which in a recent test, meant
> > that resume failed because pci_set_power_state() got called in a
> > context that couldn't msleep().  And in previous tests has led to
> > similar failures, since resume() calls all expect sleeping is OK
> > (since that's part of that API contract).
> =

> Yes. =

> =

> I had a patch that did
> =

> 	system_state =3D SYSTEM_BOOTING;
> 	..
> 	system_state =3D SYSTEM_RUNNING;
> =

> around the final stages of suspend/resume, because the resume stage reall=
y =

> _does_ end up looking like the boot: single CPU, various special code etc.
> =

> And that gets rid of some of the warnings, and is arguably a valid thing =

> to do (exactly because it's "true" to some degree that we're in the bootu=
p =

> state).

Didn't try that.  In this case, debug diagnostics confirmed that what
was happening was pretty strange (to me):  the preempt count was goofed.
It was correct as the snapshot was being taken, but wrong after that
snapshot got resumed.


> At the same time, it's certainly equally arguable (or more so) that the =

> warnings are actually valid, even during bootup, and the code that causes =

> them should be fixed.

In this case, the warnings were clearly valid, and I'm perplexed at
what was making the preempt count go bad.


> > The last time I saw this problem I threw in a hack to drop that
> > count before starting the device resume calls, but I'm rather
> > curious why it happens at all.  Does this ring bells for anyone?
> =

> Some of the warnings will trigger for doing things like taking a semaphor=
e =

> with interrupts disabled, or with a spinlock held (which will raise the =

> preemption count).

Preempt count corruption.  :(

Unfortunately right now I don't have a clue as to what did that, only
a workaround of forcing it to a sane value (decrement before resuming
the devices).  I'm kind of hoping someone else has noticed similar bugs,
and gotten beyond them.

- Dave
