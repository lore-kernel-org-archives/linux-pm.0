From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: windfarm got signal
Date: Thu, 22 Jun 2006 22:33:26 +1000
Message-ID: <200606222233.32609.ncunningham@linuxmail.org>
References: <1150847482.16662.13.camel@johannes>
	<1150974836.16258.29.camel@johannes>
	<1150976092.16258.33.camel@johannes>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1191775827=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150976092.16258.33.camel@johannes>
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
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

--===============1191775827==
Content-Type: multipart/signed; boundary="nextPart2446602.GpVZGZnpZJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2446602.GpVZGZnpZJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 22 June 2006 21:34, Johannes Berg wrote:
> On Thu, 2006-06-22 at 13:13 +0200, Johannes Berg wrote:
> > Thanks, I'll look and submit a patch. It does try_to_freeze() but also
> > checks for pending signals.
>
> Ah. The code is just in the wrong order:
> while (!kthread_should_stop()) {
>   try_to_freeze();
>   ...
>   schedule_timeout_interruptible(...);
>   if (signal_pending())
>     break;
> }
>
> Would it be correct to just move the try_to_freeze() before the
> signal_pending() statement?

Hmm. Will kthread_should_stop() be set if it should really exit? If so,=20
perhaps you can just remove the signal_pending() check. Otherwise, you'd wa=
nt=20
to change the signal_pending() test to something like the "if=20
(signal_pending() && !try_to_freeze())" to avoid any possibility of a race.=
=20
(In this case, you should be able to remove the try_to_freeze() from above).

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2446602.GpVZGZnpZJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEmo4cN0y+n1M3mo0RAufRAKDyX5r92PjokKKpvbhE67TnTqK3ZwCfRWOM
fbnGCwyPzbWboZecwujNucA=
=m8cM
-----END PGP SIGNATURE-----

--nextPart2446602.GpVZGZnpZJ--

--===============1191775827==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1191775827==--
