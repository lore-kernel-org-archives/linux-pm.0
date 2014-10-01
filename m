From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND V9 1/6] power: reset: Add generic SYSCON register
 mapped reset
Date: Wed, 1 Oct 2014 17:18:47 +0200
Message-ID: <20141001151847.GC969@earth.universe>
References: <1412119508-22864-1-git-send-email-fkan@apm.com>
 <1412119508-22864-2-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412119508-22864-2-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: linux@roeck-us.net, dbaryshkov@gmail.com, catalin.marinas@arm.com, dwmw2@infradead.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patches@apm.com, linux-pm@vger.kernel.org, will.deacon@arm.com
List-Id: linux-pm@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2014 at 04:25:03PM -0700, Feng Kan wrote:
> Add a generic SYSCON register mapped reset mechanism.
>=20
> Signed-off-by: Feng Kan <fkan@apm.com>

I have merged the driver and its documentation to battery-2.6.git.
This should make it possible for the changes in arch/arm to be
merged via ARM maintainers in 3.19.

Please fix Guenter's comments in an incremental patch.

-- Sebastian

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJULBtXAAoJENju1/PIO/qaXt0QAKfkOi4VdkhHh1accK88okd2
+p+kTrPg59ThLxj/Idk3Ag/nq1F8YDWnTr81PPgjrErWFslBp0G0hVdr5WECIzNL
DIcpn3vzUgHD24Es1//PIDZ9Jw+HErJL2X3fsnKSOYkKr+UlLI01AJd7Kcu4Ht5g
hoTeVj9T316KlcTh/fSkQCN6k01+XcOCN83mUshi0hbsVdE7H+6k/anot+W7aqDG
4EwmmqFdfj1hA87T8eQD0wrRRhItueK12/XSuPdClNRJmNUrK4rDV1B7IXK/S7Lk
Z17AlZvL6LGM58+LPXDl7zuYcc60xdUwtZgaIBT1N8ptXYqRZn9sMaumo9gLMAmU
xVHw4QsBJ4KSa/2Nx9FbmJ99gWOgElfz+ex5j0upBckYTBglWb4T82H/yseUPD2O
BAO16C7rbluODx6N4T6rI3V5T3XgoRdvH8D7xcEYa/avE2Nj6LpC2tF91cJ8myBo
Ev8FgISgsN7Snsqg6fD91zDyj8XhEgF7nuHSRTfZgtcLC8BwLsgvbJP2WFtPE2V6
EUKvnfi0JIXD+K0w1v7X68ZZUkgnseww4Xmp1U7OK7JpgOWiB3kRPb7dK49DAhIe
Z4QF4QoUkKDUAzZe3IXkztobknYjLUHpqAdDwLO0J2onpAioncQfCFyhFt4s+Qwt
M3aGjXZ6f81rUDSAo/zH
=OrXN
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
