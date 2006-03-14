From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 22:22:42 +0100
Message-ID: <20060314212242.GM1782@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603140036.17051.rjw@sisk.pl> <20060314203350.GG1782@elf.ucw.cz>
	<200603142213.03000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200603142213.03000.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

On =DAt 14-03-06 22:13:02, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Tuesday 14 March 2006 21:33, Pavel Machek wrote:
> > > > We need to be able to rollback the state of the filesystem in mem=
ory and on=20
> > > > disk to the point where the last checkpoint was made. Memory woul=
d be=20
> > > > straight forward if we want to do it dumbly and slowly - just rel=
oad the=20
> > > > whole check pointed image. If we want to be more efficient, we'd =
want to just=20
> > > > load the pages that had changed (Mark on (first) write?). But fil=
esystems=20
> > > > seem to be a whole different story. Do any of the commonly used f=
ses have=20
> > > > support for checkpointing and rollback back at the moment?
> > >=20
> > > I'm not sure if we need a rollback as such.  What we need is to mak=
e sure
> > > the filesystems state will be consistent before as well as after we=
 have
> > > "reloaded" the snapshot.
> >=20
> > Even if you make sure *kernel* is consistent with changed filesystem,
> > userland is going to be badly confused. Imagine what will happen with
> > memory mapped files, for example.=20
>=20
> Something like what happens when you suspend with a mounted CD
> and mmapped files from there, then you replace the CD while suspended
> and resume.  Not a wise thing to do, but I think people will do such th=
ings
> from time to time and we'd better be prepared to handle them nicely.

But... we can't prevent userspace from segfaulting in such case... can
we?

> > I'm not sure how it could work...
>=20
> IMO memory mapped files are the most difficult problem here,
> but the rest seems to be doable in general.

It seems to be the same problem with removable media... You could
replace mounted CDrom while running. (Not all CDroms support door
lock.)
								Pavel
--=20
14:        {
