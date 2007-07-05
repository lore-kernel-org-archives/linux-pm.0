From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 13:58:25 +0200
Message-ID: <200707051358.26963.rjw__1024.23358844153$1183636293$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<20070705091801.GB3084@elf.ucw.cz>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
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

On Thursday, 5 July 2007 11:31, Miklos Szeredi wrote:
> > > > > > I have discussed the benefits elsewhere. =C2=A0As for the dea=
dlocks -- do=20
> > > > > > you still observe them if you use the version of the freezer =
which=20
> > > > > > doesn't freeze kernel threads?
> > > > >=20
> > > > > In general the only way to guarantee there are no deadlocks is =
to
> > > > > construct the graph of dependencies between tasks. =C2=A0Those =
dependencies
> > > > > are not in practice observable from outside the tasks, so it is
> > > > > virtually impossible to construct the graph.
> > > >=20
> > > > In which way can user space tasks depend on each other in a way t=
hat
> > > > allows a them members of that cycle to be in uninterruptible slee=
p?
> > >=20
> > >  - process A calls rename() on a fuse fs
> > >  - process B, the fuse server, starts to process the rename request
> > >  - process B is frozen before it can reply
> > >=20
> > > Now process A is unfreezable.  We cannot make rename() restartable,
> > > hence it cannot be interruptible.
> >=20
> > Yes, we are claiming fuse is very special in this regard, and perhaps
> > even broken.
> >=20
> > Let's see. If I SIGSTOP the fuse server, I can get unrelated tasks
> > unkillable (even for SIGKILL!) forever.
>=20
> Actually fuse allows SIGKILL, because it's always fatal, and the
> syscall may not be restarted.
>=20
> > That's very special, and maybe even a FUSE bug. And that is also
> > what makes FUSE special w.r.t. s2ram.
>=20
> What makes fuse special is that some file operations are synchronous
> and non-restartable.  That's just how the UNIX filesystem API works
> and is hardly a bug in fuse.
>=20
> > So no, you can't claim "FUSE is just IPC". It is very special IPC.
>=20
> I did say it's special.  Sure, it has some "interesting" properties,
> and with a bit of malice you can do very ugly things with it.  If you
> are interested, read Documentation/filesystems/fuse.txt, especially
> the "Tricky deadlock" section ;)

Very well.

Don't you think, however, that it can be modified a little to play well,
for example, with the freezer?

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
