From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch] power: ipaq-micro-battery: freeing the wrong variable
Date: Sun, 10 Apr 2016 18:27:46 +0200
Message-ID: <20160410162745.GC25923@earth>
References: <20160318090051.GA19233@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160318090051.GA19233@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Mar 18, 2016 at 12:00:51PM +0300, Dan Carpenter wrote:
> We accidentally free "micro_ac_power" which is an error pointer and it
> leads to an oops.  We intended to free "micro_batt_power".

Thanks, queued.

-- Sebastian

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXCn8BAAoJENju1/PIO/qaRYkP/A8SQvFNLDsjS9t5WeSTcTfh
SqSPVAczVbmQtH4dSA3K8UFZn6Oh3qTIGwi1x7LLKcO0ftbRIDC6OSNwteUiUdn6
adzoZ5qvRrnRm+9vU7PrmlDSQVu/LuywCWr9Wbjl5Th1hC5CkIxoFK9ghJhsy3Sq
YBPjouvgQ269Ii5LB2f+ZZ4gHr5E5v2QW9ejkfAXZ4sPO4AeSuNrmJwSqr7mS3le
UlLK1Qpmyhbe3WjK9M5cYNUkNwz1V1+iC9p6Q3mJzK1l+2kMXon34AMaGLRYuQhk
w6nElGTVmp68hQdBp2RCAgngTr2Jmoirbs2NF+jCs/WdAOgg4r69NxLMa6bTnHEd
oZMsURS0g2Ndg66nsAh1okMZX50rROqFOkwI5DHs75BiXGvOlUnx2gacFsWYXUyk
8daJnzKzJ0NkwDQywx7nk7rGiU0UbRNdGwW7SC6OK91d+Gqfj/4XZjt0fFxZb1dQ
l+i+47euxYmxtfu/Ue25+yWCsRVJuanO95y7fArc4WYuglnCDjoahKaMVk2Rca55
DieimTnBpqJ6sqqW9jaZdgl7GYlgVypf1l2cGQxvDMO1EC4IRJXoh5l11iXuKEYZ
qLu5viRAPJd3F3iBboE8x8vNc1w1sD562BFByAilCDtFRzipNAI1fObLyX11r2Ed
YttDaA7bVLL14sbxsjPs
=qbKa
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
