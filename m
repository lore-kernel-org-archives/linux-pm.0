From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 19:48:22 -0700
Message-ID: <200606141948.23107.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<200606151154.50022.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606151154.50022.ncunningham@linuxmail.org>
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
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 June 2006 6:54 pm, Nigel Cunningham wrote:

> > And quite frankly, until we do it the way I say we should do it, I don't
> > think you can _ever_ do things well. For example, the whole thing where=
 we
> > have hacks to try to avoid suspending the device that is the disk to
> > suspend to all comes from this same problem.
> =

> There I'm not so sure - I think the issue there is that we didn't
> distinguish between 'stop activity' and 'power down'.

Wheras I'd say the issue is just that pm_message_t has been a
confusing thing from day one ... it took the place of a parameter
which originally indicated a target _system_ state, but which was
widely misinterpreted as a PCI_Dx state, and is currently ignored
by all except maybe 5% of the device drivers in Linux (so that
opinions about its semantics can be rather varied).


> If I'm up =

> with the play, that's being addressed in those new patches to
> add a _FREEZE state.

The only new thing discussed in that area is a new PM_EVENT_PRETHAW,
to address a device state machine botch that's specific to the current
resume-from-swsusp logic.  Real system suspend states (standby, STR)
don't create those specific issues.


Actually it would be interesting to hear counter-arguments to this
position:

	We already HAVE that two-phase thing going on, at
	least for swsusp.  In phase I a PM_EVENT_FREEZE
	gets sent.  Then in phase II a PM_EVENT_SUSPEND gets
	tries to really suspend things.

One counter-argument might be that "phase I.5 resumes those devices"
is a problem.  Another might be that "FREEZE should not be sent to
the console(s), the swap device, or their parents".  I suspect there
are a few more issues mixed up in there too.

- Dave
