From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:16:15 +0200
Message-ID: <200707060916.16368.rjw@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<E1I6NgZ-0000F6-00@dorka.pomaz.szeredi.hu>
	<20070705220444.GD3881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705220444.GD3881@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 6 July 2007 00:04, Pavel Machek wrote:
> Hi!
>=20
> > > > > > > I have discussed the benefits elsewhere. =A0As for the dead=
locks -- do=20
> > > > > > > you still observe them if you use the version of the freeze=
r which=20
> > > > > > > doesn't freeze kernel threads?
> > > > > >=20
> > > > > > In general the only way to guarantee there are no deadlocks i=
s to
> > > > > > construct the graph of dependencies between tasks. =A0Those d=
ependencies
> > > > > > are not in practice observable from outside the tasks, so it =
is
> > > > > > virtually impossible to construct the graph.
> > > > >=20
> > > > > In which way can user space tasks depend on each other in a way=
 that
> > > > > allows a them members of that cycle to be in uninterruptible sl=
eep?
> > > >=20
> > > >  - process A calls rename() on a fuse fs
> > > >  - process B, the fuse server, starts to process the rename reque=
st
> > > >  - process B is frozen before it can reply
> > > >=20
> > > > Now process A is unfreezable.  We cannot make rename() restartabl=
e,
> > > > hence it cannot be interruptible.
> > >=20
> > > Yes, we are claiming fuse is very special in this regard, and perha=
ps
> > > even broken.
> > >=20
> > > Let's see. If I SIGSTOP the fuse server, I can get unrelated tasks
> > > unkillable (even for SIGKILL!) forever.
> >=20
> > Actually fuse allows SIGKILL, because it's always fatal, and the
> > syscall may not be restarted.
>=20
> Okay, and you should handle refrigerator in the same paths where you
> handle SIGKILL. Just add try_to_freeze() there...

In fact the problem is more complicated than that, because some tasks may
be waiting on VFS locks related to FUSE.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
