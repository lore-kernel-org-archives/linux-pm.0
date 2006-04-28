From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Fri, 28 Apr 2006 11:19:01 +0200
Message-ID: <200604281119.02575.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl> <200604271727.39194.rjw@sisk.pl>
	<20060427205533.GA10737@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060427205533.GA10737@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday 27 April 2006 22:55, Pavel Machek wrote:
> > On Tuesday 25 April 2006 12:31, Rafael J. Wysocki wrote:
> > > On Tuesday 25 April 2006 12:04, Pavel Machek wrote:
> > > > > > Okay, so it can be done, and patch does not look too bad. It =
still
> > > > > > scares me. Is 800MB image more responsive than 500MB after re=
sume?
> > > > >=20
> > > > > Yes, it is, slightly, but I think 800 meg images are impractica=
l for
> > > > > performance reasons (like IMO everything above 500 meg with the=
 current
> > > > > hardware).  However this means we can save 80% of RAM with the =
patch
> > > > > and that should be 400 meg instead of 250 on a 500 meg machine,=
 or
> > > > > 200 meg instead of 125 on a 250 meg machine.
> > > >=20
> > > > Could we get few people trying it on such small machines to see i=
f it
> > > > is really that noticeable?
> > >=20
> > > OK, I'll try to run some tests on a machine with smaller RAM (and s=
lower CPU).
> >=20
> > Done, although it was not so easy to find the box.  This was a PII 35=
0MHz w/
> > 256 MB of RAM.
> >=20
> > I invented the following test:
> > - ran KDE with 4 desktops,
> > - ran Firefox, OpenOffice.org 1.1 (with a simple spreadsheet), and GI=
MP (with
> > 2 pictures) each on its own desktop,
> > - ran the memory meter from the KDE's Info Center and two konsoles
> > on the remaining desktop - one konsole with a kernel compilation and =
the
> > other with a root session used for suspending the box (the built-in s=
wsusp
> > was used),
> > so the box's RAM was almost fully occupied with ~30% taken by the pag=
e cache.
> >=20
> > Then I suspended the box and measured the time from the start of resu=
me
> > (ie. leaving GRUB) to the point at which I had all of the application=
 windows
> > fully rendered on their respective desktops (I always switched the de=
sktops
> > in the same order, starting from the memory meter's one, through the =
OOo's
> > and Firefox's, finishing on the GIMP's one and I always switched the
> > desktop as soon as the window(s) on it were fully rendered).
> >=20
> > I ran it a couple of times on the 2.6.17-rc1-mm2 kernel with and with=
out
> > the patch and the results (on the average) are the following:
> >=20
> > (a) 25-28s with the patch
> > (b) 30-33s without it
>=20
> Ook, thanks for testing. I guess it is ready for -mm when Nick is
> happy with it ...

OK, I'm waiting for Nick to respond, then. :-)

Still I'd like to change one more thing in the final patch.  Namely,
instead of this:

@@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
=A0=A0=A0=A0=A0=A0=A0=A0case SNAPSHOT_UNFREEZE:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!data->frozen)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0b=
reak;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (data->ready && in_suspe=
nd) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err=
or =3D -EPERM;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bre=
ak;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0down(&pm_sem);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0thaw_processes();
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0enable_nonboot_cpus();

I'd like to do:

 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen)
 			break;
+               	if (data->ready)
+			swsusp_free();
 		down(&pm_sem);
		thaw_processes();
		enable_nonboot_cpus();

so unfreeze() won't return the error.

Greetings,
Rafael
