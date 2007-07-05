From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 11:31:39 +0200
Message-ID: <E1I6NgZ-0000F6-00__37649.1587762304$1183628262$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041045150.25704-100000@netrider.rowland.org>
	<18060.14856.824473.325660@cargo.ozlabs.ibm.com>
	<200707050858.03638.oliver@neukum.org>
	<E1I6MWb-0008Tq-00@dorka.pomaz.szeredi.hu>
	<20070705091801.GB3084@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20070705091801.GB3084@elf.ucw.cz> (message from Pavel Machek on
	Thu, 5 Jul 2007 11:18:01 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > > > I have discussed the benefits elsewhere. =C2=A0As for the deadl=
ocks -- do=20
> > > > > you still observe them if you use the version of the freezer wh=
ich=20
> > > > > doesn't freeze kernel threads?
> > > >=20
> > > > In general the only way to guarantee there are no deadlocks is to
> > > > construct the graph of dependencies between tasks. =C2=A0Those de=
pendencies
> > > > are not in practice observable from outside the tasks, so it is
> > > > virtually impossible to construct the graph.
> > >=20
> > > In which way can user space tasks depend on each other in a way tha=
t
> > > allows a them members of that cycle to be in uninterruptible sleep?
> >=20
> >  - process A calls rename() on a fuse fs
> >  - process B, the fuse server, starts to process the rename request
> >  - process B is frozen before it can reply
> >=20
> > Now process A is unfreezable.  We cannot make rename() restartable,
> > hence it cannot be interruptible.
>=20
> Yes, we are claiming fuse is very special in this regard, and perhaps
> even broken.
>=20
> Let's see. If I SIGSTOP the fuse server, I can get unrelated tasks
> unkillable (even for SIGKILL!) forever.

Actually fuse allows SIGKILL, because it's always fatal, and the
syscall may not be restarted.

> That's very special, and maybe even a FUSE bug. And that is also
> what makes FUSE special w.r.t. s2ram.

What makes fuse special is that some file operations are synchronous
and non-restartable.  That's just how the UNIX filesystem API works
and is hardly a bug in fuse.

> So no, you can't claim "FUSE is just IPC". It is very special IPC.

I did say it's special.  Sure, it has some "interesting" properties,
and with a bit of malice you can do very ugly things with it.  If you
are interested, read Documentation/filesystems/fuse.txt, especially
the "Tricky deadlock" section ;)

Miklos
