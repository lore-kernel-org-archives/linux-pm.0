From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ab8500_fg.c: only request threaded IRQs when necessary
Date: Sat, 7 Mar 2015 20:47:04 +0100
Message-ID: <20150307194704.GD5233@earth>
References: <1424104368-11202-1-git-send-email-Valentin.Rothberg@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424104368-11202-1-git-send-email-Valentin.Rothberg@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Valentin Rothberg <Valentin.Rothberg@lip6.fr>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Feb 16, 2015 at 05:32:48PM +0100, Valentin Rothberg wrote:
> All 5 IRQ handlers of the driver are requested as threaded interrupt
> handlers.  However, only 1 handler can block.  The remaining 4 handlers
> defer the actual handling to a workqueue.  Hence, 4 of 5 IRQ handlers
> have a considerable overhead, since they are executed in a kernel thread
> to schedule another kernel thread (workqueue).
>=20
> This change splits up the 5 interrupt handlers into top halves (_th) and
> bottom halves (_bh) and resolves the aforementioned overhead by only
> requesting threaded interrupts (i.e., bottom halves) when necessary.
>=20
> Signed-off-by: Valentin Rothberg <Valentin.Rothberg@lip6.fr>

Thanks, queued:

http://git.infradead.org/battery-2.6.git/commit/02232be7a2bf6e2dd5e4a6c3a81=
470a09ecc7fdd

-- Sebastian

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+1W2AAoJENju1/PIO/qaCVoP/jroNlhHPywSxqSFYzWMjhGo
MC1ykqoKQ7uqRPFH4A3WY8YaY6ChKU27XmHnDohaZGqdRPYUi0Os4bPj7lsEHKe1
GvcTciFgWKGBC8xyVtO3FgRxqx1z/8csrNh1bh69YAvHPjz6iu1VKs9q1wQj+4id
WW+K31iD2ZLpIcqD2R1lFthouxU9UlrkCyAYAwDl/TlrDESCbswa5wlrY+MAWPRy
V2dV+sqRPyZVTjg9oO2f1XL6lurYrkcTGUSx5OP7BB8R8emg9vPFfqzy6w6FNcjr
AIZBjI6VEc5rPI8DOMUILujLl/3FfBIUI8lsdWTDzQ3MpUluPSJ4A/kzEx6qZWLO
q0CJ3+fwkPwkEs6i3BScvpaAWqpEx3ysOnxCC2qFEpoMG1KO0piJRUC3s16wKtyX
hNuiKAiWvpnRxlJATlOcjxd66/GoVaUfFUpEBj8lky1nx7/s5gwo8oH1BMVBP4Vo
5yyAZhu0iRVNEcHACIPmKXfdmiRKT19W0VME1Hl/Q33lRbYTk1WLyasimSc+Zyif
tP+FV67LT30XY6j/MkpgWMPcmfyKueXqL/vENA9rr1jHozkSR0mrwm9S7AdTWm+u
2DnhWhHFMBrQCDa1SEkOk7VPDszTcuOTLqTamSVu2xl7HkTPUAL9gZHfJ4R5T5Tm
PjAErnvEsI8ZRz/YjyRv
=YbUQ
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
