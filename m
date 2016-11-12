From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH RFT] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Date: Sat, 12 Nov 2016 20:24:01 +0100
Message-ID: <40c3be7e-08c3-955c-746a-6906160e1e0a@rempel-privat.de>
References: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3142525858879874895=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <lw@karo-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3142525858879874895==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n857cjnomD4uG8GC0NDaBnJseOJm0VOum"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n857cjnomD4uG8GC0NDaBnJseOJm0VOum
Content-Type: multipart/mixed; boundary="1QPgVPpAmhabVHtlelcW9h4IUF2Jkwx5s";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>,
 =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <lw@karo-electronics.de>
Cc: Sascha Hauer <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Message-ID: <40c3be7e-08c3-955c-746a-6906160e1e0a@rempel-privat.de>
Subject: Re: [PATCH RFT] irqchip: mxs: Enable SKIP_SET_WAKE and
 MASK_ON_SUSPEND
References: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>

--1QPgVPpAmhabVHtlelcW9h4IUF2Jkwx5s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 11.11.2016 um 18:26 schrieb Stefan Wahren:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
>=20
> So enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND
> to let the irqchip core allows and handles the power management.
>=20
> This patch has been tested with a MX23 and a MX28 board. Any further
> tests especially with ASM9260 would be appreciated.

Hi, I wont be able to test this patch on ASM9260 until March.
Please roll it out, so far it looks ok for me.


> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/irqchip/irq-mxs.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> index 1730470..05fa9f7 100644
> --- a/drivers/irqchip/irq-mxs.c
> +++ b/drivers/irqchip/irq-mxs.c
> @@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d=
)
>  	.irq_ack =3D icoll_ack_irq,
>  	.irq_mask =3D icoll_mask_irq,
>  	.irq_unmask =3D icoll_unmask_irq,
> +	.flags =3D IRQCHIP_MASK_ON_SUSPEND |
> +		 IRQCHIP_SKIP_SET_WAKE,
>  };
> =20
>  static struct irq_chip asm9260_icoll_chip =3D {
>  	.irq_ack =3D icoll_ack_irq,
>  	.irq_mask =3D asm9260_mask_irq,
>  	.irq_unmask =3D asm9260_unmask_irq,
> +	.flags =3D IRQCHIP_MASK_ON_SUSPEND |
> +		 IRQCHIP_SKIP_SET_WAKE,
>  };
> =20
>  asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs =
*regs)
>=20


--=20
Regards,
Oleksij


--1QPgVPpAmhabVHtlelcW9h4IUF2Jkwx5s--

--n857cjnomD4uG8GC0NDaBnJseOJm0VOum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlgnbFEACgkQHwImuRkmbWkJ2gEAgUtETmE1itXT9mzvlGR7AC8b
D5TH3JnckBui3iP3jYEBAI1XOYqVX6ZMmIATP5ex9vPP4Rgmvpd4uNHAtSEuZt1S
=lYHk
-----END PGP SIGNATURE-----

--n857cjnomD4uG8GC0NDaBnJseOJm0VOum--


--===============3142525858879874895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3142525858879874895==--
