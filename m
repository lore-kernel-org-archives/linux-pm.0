From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [2.6.24-rc1 regression] suspend fails
Date: Fri, 26 Oct 2007 20:16:01 +0400
Message-ID: <200710262016.02237.arvidjaar__947.411094284867$1193415434$gmane$org@mail.ru>
References: <200710252147.22814.arvidjaar@mail.ru>
	<200710252244.50711.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8657481882883777780=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710252244.50711.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============8657481882883777780==
Content-Type: multipart/signed; boundary="nextPart15304514.GKZ33QxuK2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart15304514.GKZ33QxuK2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 October 2007, Rafael J. Wysocki wrote:
> On Thursday, 25 October 2007 19:47, Andrey Borzenkov wrote:
> > I can no more suspend with 2.6.24-rc1. 2.6.23 is fine. Here is kernel
> > log; config attached
>
> Please try the patch from:
> http://marc.info/?l=linux-mm-commits&m=119318609013090&w=2
>

Yes, that fixed it.

--nextPart15304514.GKZ33QxuK2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHIhLCR6LMutpd94wRAoPFAKChcx7RhAW1GeLBa/VngBc5fokU5gCdFbNi
VE+dN25KIYwX8F1UofRTQ0Q=
=P3A2
-----END PGP SIGNATURE-----

--nextPart15304514.GKZ33QxuK2--

--===============8657481882883777780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8657481882883777780==--
