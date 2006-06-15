From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 11:54:46 +1000
Message-ID: <200606151154.50022.ncunningham@linuxmail.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0614983757=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
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
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============0614983757==
Content-Type: multipart/signed; boundary="nextPart1854303.zol6ziSc8p";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1854303.zol6ziSc8p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 15 June 2006 10:07, Linus Torvalds wrote:
> On Thu, 15 Jun 2006, Pavel Machek wrote:
> > On St 14-06-06 15:59:00, Linus Torvalds wrote:
> > > There is no "console device".
> > >
> > > There are potentially _many_ console devices.
> >
> > With printks going to all of them?
>
> Yup.
>
> > My point is that you really want the console enabled in writing phase
> > of suspend-to-disk. And old setup got that detail right, while new
> > setup does not.
>
> I definitely agree that we can change things around a bit. I don't
> personally use suspend-to-disk, and I'm a bit tired of having people tell
> me STD works, when STR is what I have always cared about, so if the tables
> are turned for once, I won't be _too_ sorry.

Sorry to disappoint, but I've just started testing, and it works fine
with Suspend2, so I don't see any reason to believe swsusp won't
work as well. For the trace patch, I did need to add a trace section
to the x86_64 code (patch below). Now I'll see if I can reproduce the
unreliability I've been having, and see if the tracing works and helps.

> I have always argued that the suspend should be a two-phase thing: a
> "prepare to suspend" (that saves the device state) and then a "real
> suspend" (that actually turns off devices).

=46wiw, I agree. Wouldn't it also help with that acpi memory allocation
issue that's hung around for so long?

> And quite frankly, until we do it the way I say we should do it, I don't
> think you can _ever_ do things well. For example, the whole thing where we
> have hacks to try to avoid suspending the device that is the disk to
> suspend to all comes from this same problem.

There I'm not so sure - I think the issue there is that we didn't
distinguish between 'stop activity' and 'power down'. If I'm up
with the play, that's being addressed in those new patches to
add a _FREEZE state.

Regards,

Nigel

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 vmlinux.lds.S |    7 +++++++
 1 file changed, 7 insertions(+)
diff -ruNp 9931-x86-64-tracedata-section.patch-old/arch/x86_64/kernel/vmlin=
ux.lds.S 9931-x86-64-tracedata-section.patch-new/arch/x86_64/kernel/vmlinux=
=2Elds.S
=2D-- 9931-x86-64-tracedata-section.patch-old/arch/x86_64/kernel/vmlinux.ld=
s.S	2006-06-15 11:32:20.000000000 +1000
+++ 9931-x86-64-tracedata-section.patch-new/arch/x86_64/kernel/vmlinux.lds.=
S	2006-06-15 11:31:19.000000000 +1000
@@ -45,6 +45,13 @@ SECTIONS
=20
   RODATA
=20
+  . =3DALIGN(4);
+  __tracedata_start =3D.;
+  .tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {
+	*(.tracedata)
+  }
+  __tracedata_end =3D.;
+
 				/* Data */
   .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)


=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1854303.zol6ziSc8p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkL3pN0y+n1M3mo0RAstsAJ9HS4SvJYN2nsbM10kiIOd5Z6YDbwCgraAU
D0CbDdk0PUPAFqkUfOJNXRU=
=mY2T
-----END PGP SIGNATURE-----

--nextPart1854303.zol6ziSc8p--

--===============0614983757==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0614983757==--
