From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 22:57:48 +0100
Message-ID: <200603142257.49487.rjw@sisk.pl>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603142213.03000.rjw@sisk.pl> <20060314212242.GM1782@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060314212242.GM1782@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 14 March 2006 22:22, Pavel Machek wrote:
> On =DAt 14-03-06 22:13:02, Rafael J. Wysocki wrote:
> > On Tuesday 14 March 2006 21:33, Pavel Machek wrote:
> > > > > We need to be able to rollback the state of the filesystem in m=
emory and on=20
> > > > > disk to the point where the last checkpoint was made. Memory wo=
uld be=20
> > > > > straight forward if we want to do it dumbly and slowly - just r=
eload the=20
> > > > > whole check pointed image. If we want to be more efficient, we'=
d want to just=20
> > > > > load the pages that had changed (Mark on (first) write?). But f=
ilesystems=20
> > > > > seem to be a whole different story. Do any of the commonly used=
 fses have=20
> > > > > support for checkpointing and rollback back at the moment?
> > > >=20
> > > > I'm not sure if we need a rollback as such.  What we need is to m=
ake sure
> > > > the filesystems state will be consistent before as well as after =
we have
> > > > "reloaded" the snapshot.
> > >=20
> > > Even if you make sure *kernel* is consistent with changed filesyste=
m,
> > > userland is going to be badly confused. Imagine what will happen wi=
th
> > > memory mapped files, for example.=20
> >=20
> > Something like what happens when you suspend with a mounted CD
> > and mmapped files from there, then you replace the CD while suspended
> > and resume.  Not a wise thing to do, but I think people will do such =
things
> > from time to time and we'd better be prepared to handle them nicely.
>=20
> But... we can't prevent userspace from segfaulting in such case... can
> we?

If we know the filesystem is gone before the applications have a chance
to do anything, like on resume, we can.  Eventually we can just kill all =
of the
processes that use memory mapped files from the missing filesystem.
That would be a bit drastic, though. ;-)

> > > I'm not sure how it could work...
> >=20
> > IMO memory mapped files are the most difficult problem here,
> > but the rest seems to be doable in general.
>=20
> It seems to be the same problem with removable media... You could
> replace mounted CDrom while running. (Not all CDroms support door
> lock.)

Yes, but there are two distinct classes of cases:
(1) we know the media has been removed before any process tries to access=
 it
(eg. the related bus driver detects the disconnect, like USB)
(2) we have no means to detect the removal of the media except for trying=
 to
access it.

For the class (1) of events we can do some clean-up work,at least in prin=
ciple,
and we are talking of such a case, IMO.

Greetings,
Rafael
