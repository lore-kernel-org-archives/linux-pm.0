From: Johannes Berg <johannes@sipsolutions.net>
Subject: shrinking memory for suspend?
Date: Mon, 30 Apr 2007 16:24:36 +0200
Message-ID: <1177943076.5102.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7954848993893682203=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============7954848993893682203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jZcm0uklYyCM2mQBE7mv"


--=-jZcm0uklYyCM2mQBE7mv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Paul Mackerras noticed that even for suspend to ram we currently free
some memory in suspend_prepare. Is that necessary because we freeze
userspace so devices can allocate a bit of memory for suspend? Why do we
freeze userspace anyway?

johannes

--=-jZcm0uklYyCM2mQBE7mv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNfwk/ETPhpq3jKURAlSCAKCde8Ks6wfE5dKFBsmTQFGFw1XRdwCdFDzw
LHlBxCGMyb1apRSo/AhGvNs=
=Lb4q
-----END PGP SIGNATURE-----

--=-jZcm0uklYyCM2mQBE7mv--


--===============7954848993893682203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7954848993893682203==--
