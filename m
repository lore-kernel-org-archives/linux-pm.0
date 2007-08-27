From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
	support on x86_64 (updated)
Date: Mon, 27 Aug 2007 10:28:08 +0200
Message-ID: <20070827082808.GH2060@elf.ucw.cz>
References: <200708241206.57178.rjw@sisk.pl> <20070824204632.GA5008@ucw.cz>
	<200708252027.26721.rjw@sisk.pl> <200708252242.06197.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708252242.06197.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-08-25 22:42:05, Rafael J. Wysocki wrote:
> On Saturday, 25 August 2007 20:27, Rafael J. Wysocki wrote:
> > On Friday, 24 August 2007 22:46, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > >=20
> > > > Make it possible to restore a hibernation image on x86_64 with th=
e help of a
> > > > kernel different from the one in the image.
> > > >=20
> > > > The idea is to split the core restoration code into two separate =
parts and to
> > > > place each of them in a different page. =A0The first part belongs=
 to the boot
> > >=20
> > > What happens in case where both parts want to be
> > > at the same place? (Like kernel being restored is 4KB smaller, so t=
hat
> > > routines now collide?)
> >=20
> > Bad things, but I can't see how to avoid that reliably.
>=20
> Below is an analogous patch without this problem.  The slightly ugly th=
ing
> about it is that all pages in the temporary mapping have the NX bit cle=
ard
> now, so that we can run some code out of one of them.  Still, IMO, that=
 isn't
> really important, because the temporary page tables are dropped as soon=
 as
> we jump to restore_registers.
>=20
> Greetings,
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Make it possible to restore a hibernation image on x86_64 with the help=
 of a
> kernel different from the one in the image.
>=20
> The idea is to split the core restoration code into two separate parts =
and to
> place each of them in a different page. =A0The first part belongs to th=
e boot
> kernel and is executed as the last step of the image kernel's memory re=
storation
> procedure. =A0Before being executed, it is relocated to a safe page tha=
t won't be
> overwritten while copying the image kernel pages.
>=20
> The final operation performed by it is a jump to the second part of the=
 core
> restoration code that belongs to the image kernel and has just been res=
tored.
> This code makes the CPU switch to the image kernel's page tables and
> restores the state of general purpose registers (including the stack po=
inter)
> from before the hibernation.
>=20
> The main issue with this idea is that in order to jump to the second pa=
rt of the
> core restoration code the boot kernel needs to know its address. =A0How=
ever, this
> address may be passed to it in the image header. =A0Namely, the part of=
 the image
> header previously used for checking if the version of the image kernel =
is
> correct can be replaced with some architecture specific data that will =
allow
> the boot kernel to jump to the right address within the image kernel. =A0=
These
> data should also be used for checking if the image kernel is compatible=
 with
> the boot kernel (as far as the memory restroration procedure is concern=
ed).
> It can be done, for example, with the help of a "magic" value that has =
to be
> equal in both kernels, so that they can be regarded as compatible.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
ACK.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
