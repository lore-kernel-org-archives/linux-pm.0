From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 17:31:33 +0200
Message-ID: <1177083093.5902.3.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420065731.GA5831@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2062326145558298131=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420065731.GA5831@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============2062326145558298131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZuA7wSiEkcRRQXBt/Qdb"


--=-ZuA7wSiEkcRRQXBt/Qdb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-20 at 06:57 +0000, Greg KH wrote:

> Can't you just make this a "weak" symbol and override it in your ppc
> code if you really need it, and make a "real" function here in this file
> for all other arches?

I'm not opposed to that. How do I do that?

johannes

--=-ZuA7wSiEkcRRQXBt/Qdb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGKNzV/ETPhpq3jKURApSwAKCaTI4lMEHB21P1nn5TyqZKor4KPwCfbGrq
QSAPQQ/dBq/SpviGTxDErJM=
=ahJY
-----END PGP SIGNATURE-----

--=-ZuA7wSiEkcRRQXBt/Qdb--


--===============2062326145558298131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2062326145558298131==--
