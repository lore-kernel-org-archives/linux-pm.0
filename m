From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 23:01:39 +0200
Message-ID: <200707052301.40303.rjw__19440.9436350272$1183668910$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052220.00555.rjw@sisk.pl>
	<E1I6Y5o-0001qm-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Y5o-0001qm-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 22:38, Miklos Szeredi wrote:
> > > > > > > Actually fuse allows SIGKILL, because it's always fatal, an=
d the
> > > > > > > syscall may not be restarted.
> > > > > >=20
> > > > > > I think you want to stick try_to_freeze() at the same places =
where you
> > > > > > do SIGKILL handling. That should solve the 'syslogd is unfree=
zeable'
> > > > > > problem.
> > > > >=20
> > > > > I could, but it would not solve the general problem. =C2=A0Name=
ly, that the
> > > > > presence of fuse imposes a certain ordering in which userspace =
tasks
> > > > > have to be frozen. =C2=A0And it is not possible to know this or=
dering.
> > > >=20
> > > > Actually, why do you need this? There is no absolute need that yo=
u
> > > > finish the request. You must either finish the request or let you=
rself
> > > > be frozen.
> > > >=20
> > > > A quick look through fuse reveals principally request_wait_answer=
()
> > > > And maybe a few other places. Is there some hidden reason you can=
not
> > > > handle being frozen here?
> > >=20
> > > Yes, fuse could handle being frozen there.  However that would only
> > > solve part of the problem: an operation waiting for a reply could b=
e
> > > holding a VFS mutex and some other task may be blocked on that mute=
x.
> > >=20
> > > How would you solve freezing those tasks?
> >=20
> > How probable is this situation?
>=20
> I guess it depends on usage patterns.
>=20
> I don't remember seeing any such cases, even though I have a permanent
> fuse mount, and I suspend regularly.  But the fs is probably totally
> idle during suspend in my case.
>=20
> But some people use fuse as a home or root filesystem and in those
> cases it can become quite likely to cause problems.

That means we need to prevent the freezer from sending freeze requests FU=
SE's
filesystem servers too early.

What about this (more or less):
1) We add a list of userland processes to the freezer that should not be =
frozen
in the first phase (ie. during the freezing of user space).  They will be=
 frozen
anyway along with the freezable kernel threads.
2) FUSE adds its filesystem servers to this list upon connecting to them
3) FUSE removes its filesystem servers from this list upon disconnecting

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
