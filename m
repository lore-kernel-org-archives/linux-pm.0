From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 13/14] power: reset: Add Intel PIIX4 poweroff driver
Date: Wed, 19 Oct 2016 04:52:44 +0200
Message-ID: <20161019025244.agynpetclhimk3tr@earth>
References: <20160919234242.23xyy2y3zjvuhate@earth>
 <20160928153056.28719-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eu5fzwnauerbpg6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935225AbcJSCwu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 22:52:50 -0400
Content-Disposition: inline
In-Reply-To: <20160928153056.28719-1-paul.burton@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--3eu5fzwnauerbpg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2016 at 04:30:56PM +0100, Paul Burton wrote:
> Add a driver which allows powering off the system via an Intel PIIX4
> southbridge, by entering the PIIX4 SOff state. This is useful on the
> MIPS Malta development board, where it will power down the FPGA based
> board until its ON/NMI button is pressed, or the QEMU implementation of
> the MIPS Malta board where it will cause QEMU to exit.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-pm@vger.kernel.org

Thanks, queued.

-- Sebastian

--3eu5fzwnauerbpg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBt/8AAoJENju1/PIO/qaKngQAISzQ5ysV+Sm8/0fFDv4/ICC
f69gYtzf3wJvBoP12/3CcbibuxlkQfVl4ADYqEyCSiTbJFUXmw1j4ELeqNcjfjX6
vNo4lj0qDMZUeOwsQCOJysCsRW0G6qxBd8HBkH3gdT/5UFYYyI8DmhsBtWJw/wgI
EJ1EJzhv2ZN+BUlBPPrrpPIJMNdhvJmPTZTIUOnZbxHV9ybiR3pHZinzIPIAvnpc
ijEVqgjKMu8jjeoOzSIQXGzOubCWkyl5hUD9B3LBz4KvUGL4uZa7P6j9oeQBxO2Y
66Pac+SMWR6VOxcM/qBB37J4nQdyAIdw5+YthtBzy5ShBtE+pwVTIH2ty2pApUy9
T3uCS2GlSH5CvNH5mvSrAKUk3XKzcnBQREg6BNXD20Wki7vxrUZAE7eZ8ymap2SI
7tbq7WSz4JtXqWFp+b64TjMGlb6J+lv/RVUkkJ7OMwHdgWlDg9mlCJ7DQpi+JQ8s
4bJOBno7Wik/yxdMtdnDIJ6nmlmJ3aYt3pfHhvrsgHcLEu/SyHBHTZnrpgSynkbm
eRCVuHcl4Yij8K/0PRIPELlgZE2EA1H/puFBCbiL5AIMHWnCJQsicVvcc5gxFkFZ
kO3BDipXGWvSRL9kv9+SgLJEmkZ0tXw2RR/kYQfBPFAWLv+rEJX2SwR2tflAXofx
80lXFgykTW3LxHhUXwFS
=5I6j
-----END PGP SIGNATURE-----

--3eu5fzwnauerbpg6--
