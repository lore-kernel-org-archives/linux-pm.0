From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] Rt-tester makes freezing processes fail.
Date: Sat, 15 Jul 2006 08:38:49 +1000
Message-ID: <200607150838.53591.nigel@suspend2.net>
References: <200607140918.49040.nigel@suspend2.net>
	<20060713163743.e71975b0.akpm@osdl.org>
	<200607141017.27832.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526928012=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607141017.27832.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, tglx@timesys.com, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============1526928012==
Content-Type: multipart/signed; boundary="nextPart1615659.YCDIlZWo73";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1615659.YCDIlZWo73
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 14 July 2006 18:17, Rafael J. Wysocki wrote:
> On Friday 14 July 2006 01:37, Andrew Morton wrote:
> > On Fri, 14 Jul 2006 09:18:43 +1000
> >
> > Nigel Cunningham <nigel@suspend2.net> wrote:
> > > Compiling in the rt-tester currently makes freezing processes fail.
> > > I don't think there's anything wrong with it running during
> > > suspending, so adding PF_NOFREEZE to the flags set seems to be the
> > > right solution.
> > >
> > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > >
> > >  rtmutex-tester.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c
> > > 9971-rt-tester.patch-new/kernel/rtmutex-tester.c ---
> > > 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07
> > > 10:27:46.000000000 +1000 +++
> > > 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14
> > > 07:48:01.000000000 +1000 @@ -259,7 +259,7 @@ static int test_func(void
> > > *data)
> > >  	struct test_thread_data *td =3D data;
> > >  	int ret;
> > >
> > > -	current->flags |=3D PF_MUTEX_TESTER;
> > > +	current->flags |=3D PF_MUTEX_TESTER | PF_NOFREEZE;
> > >  	allow_signal(SIGHUP);
> > >
> > >  	for(;;) {
> >
> > I yesterday queued up the below patch.  Which approach is most
> > appropriate?
>
> I prefer the one that makes these threads freeze (ie. the Luca's patch).

Ok.

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1615659.YCDIlZWo73
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEuBz9N0y+n1M3mo0RAhltAJ9UxALBiWAhZhkj5Q+R89nXIUZ0/QCfR3XS
XAnsRxtK9OBhs/M+7pQB8V4=
=kcGL
-----END PGP SIGNATURE-----

--nextPart1615659.YCDIlZWo73--

--===============1526928012==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1526928012==--
