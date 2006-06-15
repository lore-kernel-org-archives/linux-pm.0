From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 10:39:21 +0200
Message-ID: <20060615083921.GB9423@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<200606151154.50022.ncunningham@linuxmail.org>
	<200606141948.23107.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606141948.23107.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org


> Actually it would be interesting to hear counter-arguments to this
> position:
> =

> 	We already HAVE that two-phase thing going on, at
> 	least for swsusp.  In phase I a PM_EVENT_FREEZE
> 	gets sent.  Then in phase II a PM_EVENT_SUSPEND gets
> 	tries to really suspend things.
> =

> One counter-argument might be that "phase I.5 resumes those devices"
> is a problem.  Another might be that "FREEZE should not be sent to
> the console(s), the swap device, or their parents".  I suspect there
> are a few more issues mixed up in there too.

This is FAQ:

Q: I do not understand why you have such strong objections to idea of
selective suspend.

A: Do selective suspend during runtime power managment, that's
okay. But
its useless for suspend-to-disk. (And I do not see how you could use
it for suspend-to-ram, I hope you do not want that).

Lets see, so you suggest to

* SUSPEND all but swap device and parents
* Snapshot
* Write image to disk
* SUSPEND swap device and parents
* Powerdown

Oh no, that does not work, if swap device or its parents uses DMA,
you've corrupted data. You'd have to do

* SUSPEND all but swap device and parents
* FREEZE swap device and parents
* Snapshot
* UNFREEZE swap device and parents
* Write
* SUSPEND swap device and parents

Which means that you still need that FREEZE state, and you get more
complicated code. (And I have not yet introduce details like system
devices).

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
