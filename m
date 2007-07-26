From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue
	instead of busy looping
Date: Thu, 26 Jul 2007 14:43:11 +0200
Message-ID: <200707261443.12539.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <20070725142429.GA299@tv-sign.ru>
	<200707261424.49503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707261424.49503.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, Pavel Machek <pavel@ucw.cz>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Thursday, 26 July 2007 14:24, Rafael J. Wysocki wrote:
> On Wednesday, 25 July 2007 16:24, Oleg Nesterov wrote:
> > On 07/25, Rafael J. Wysocki wrote:
> > >
> > > On Wednesday, 25 July 2007 15:29, Oleg Nesterov wrote:
> > > > On 07/25, Rafael J. Wysocki wrote:
> > > > >
> > > > >  void refrigerator(void)
> > > > >  {
> > > > > @@ -50,6 +73,9 @@ void refrigerator(void)
> > > > >  	   processes around? */
> > > > >  	long save;
> > > > >
> > > > > +	refrigerator_called =3D 1;
> > > > > +	wake_up(&refrigerator_waitq);
> > > > > +
> > > >=20
> > > > This is a bit racy. Unless I missed something, the task should no=
t set
> > > > refrigerator_called =3D=3D 1 until it has PF_FROZEN.
> > >=20
> > > No, it's just to signal that the task has entered the refrigerator,=
 not that
> > > it has actually frozen.
> >=20
> > Yes, I see.
> >=20
> > > > Otherwise, try_to_freeze_tasks() can set refrigerator_called =3D=3D=
 0 after
> > > > refrigerator() sets it =3D=3D 1, the the main loop notices this u=
nfrozen task,
> > > > and goes to sleep.
> > >=20
> > > refrigerator_called is only reset after try_to_freeze_tasks() has f=
ound it
> > > equal to one.  There is only a small window between checking it in
> > > wait_event_timeout() and resetting it,
> >=20
> > Yes.
> >=20
> > > but then we go to send freeze requests
> > > to the remaining tasks and we count 'todo' from the start, so that =
shouldn't
> > > be a problem.
> >=20
> > ... and we find the task which is not frozen() yet, but which has alr=
eady passed
> > the "set condition and wakeup", increment todo, and wait for the even=
t. If it was
> > the last task, we will sleep until timeout.
> >=20
> > I agree, this is not fatal and unlikely, but still it is a race. I th=
ink it is
> > better to move this code down, after frozen_process().
>=20
> OK, I see your point.  The updated patch is appended.
>=20
> > (offtopic: strictly speaking, we don't even need the "refrigerator_ca=
lled", we
> >  only need the wait_queue_head_t. try_to_freeze_tasks() just adds the=
 "current"
> >  to wq at the very start of the main loop).
>=20
> Hmm, yes, I think so.
>=20
> Greetings,
> Rafael
>=20
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Use the observation that try_to_freeze() need not loop while waiting fo=
r the
> freezing tasks to enter the refrigerator and make it use a wait queue.
>=20
> The idea is that after sending freeze requests to the tasks regarded as
> freezable try_to_freeze() can go to sleep and wait until at least one t=
ask
> enters the refrigerator. =A0The first task that does it wakes up try_to=
_freeze()
> and the procedure is repeated. =A0If the refrigerator is not entered by=
 any tasks
> before TIMEOUT expires, try_to_freeze() increases the counter of expire=
d
> timeouts and sends freeze requests to the remaining tasks. =A0If the nu=
mber of
> expired timeouts becomes greater than MAX_WAITS, the freezing of tasks =
fails
> (the counter of expired timeouts is reset whenever a task enters the
> refrigerator).
>=20
> This way, try_to_freeze() doesn't occupy the CPU unnecessarily when som=
e
> freezing tasks are waiting for I/O to complete and we have more fine gr=
ained
> control over the freezing procedure.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Well, s/try_to_freeze()/try_to_freeze_tasks()/ all in the changelog above.

Greetings,
Rafael
