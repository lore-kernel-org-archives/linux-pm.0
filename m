From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Wed, 21 Dec 2016 16:59:29 +0100
Message-ID: <20161221155929.o4ihvqezbuqx2stl@earth>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
 <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth>
 <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="di4ctraqcqzg7vx5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--di4ctraqcqzg7vx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 02:37:39AM +0900, Roger Shimizu wrote:
> [...]
>
> >> +static void linkstation_reset(void)
> >> +{
> >> +     const unsigned divisor =3D ((tclk + (8 * cfg->baud)) / (16 * cfg=
->baud));
> >> +
> >> +     pr_err("%s: triggering power-off...\n", __func__);
> >> +
> >> +     /* hijack UART1 and reset into sane state */
> >> +     writel(0x83, UART1_REG(LCR));
> >> +     writel(divisor & 0xff, UART1_REG(DLL));
> >> +     writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> >> +     writel(cfg->magic[0], UART1_REG(LCR));
> >> +     writel(cfg->magic[1], UART1_REG(IER));
> >> +     writel(cfg->magic[2], UART1_REG(FCR));
> >> +     writel(cfg->magic[3], UART1_REG(MCR));
> >> +
> >> +     /* send the power-off command to PIC */
> >> +     if(cfg->cmd[0][0] =3D=3D 1 && cfg->cmd[1][0] =3D=3D 0) {
> >> +             /* if it's simply one-byte command, send it directly */
> >> +             writel(cfg->cmd[0][1], UART1_REG(TX));
> >> +     }
> >
> > I guess this optimization can be dropped and you can directly
> > call the for loop with uart1_micon_send().
>=20
> Same response regarding above two comments.
> The code is extensible because I want to extend in the future.
>=20
> Current implementation is just for Linkstation Pro / KuroBox Pro to be
> able to power-off.
> But for some other model of Linkstation, restart also need similar
> command via UART1.
>
> Just one example, Linkstation Pro is ARM based, but it was PowerPC based =
before.
> And the device support still exists in kernel tree:
>   arch/powerpc/platforms/embedded6xx/linkstation.c
>   arch/powerpc/platforms/embedded6xx/ls_uart.c
> It shows sending "C" to restart and sending "E" to power-off for
> PowerPC based Linkstation.
>=20
> I'm not actually interested in PowerPC based Linkstation, it's just an
> example to show the reason to be flexible.
>=20
> If other part is fine, may I send the v3 patch after merging
> linkstation-common.c into linkstation-reset.c?
> Thank you!

These models can just be added to qnap-poweroff, which handles
exactly this special case as far as I can see.

-- Sebastian

--di4ctraqcqzg7vx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhapuEACgkQ2O7X88g7
+pr8VhAAjqpg486H8n4fksHwoVEyK3VKnkKJA5L0fN247MSh/xyn2ubNNMVQyTFS
kyLvWS1A/amvoFSg6FlOd1mhzLLne6b18wbDlvoB9Hum5mQrjodrgowtfz5irLWF
VD6Clxjsuf0MBKjq9cF21HKj4VZFaBKC/ETkHhTGg+IhczR7T7xXtwhQInQ2hzrv
x8j6OtpiskyihJ2Tzv+MuPD+M6vvu7JSu7/mAxVgJzzIWJn8z2TRBo5Cb6dUF7xR
1U2HD/G17fWa09jXFXy75tX3QQDH1sFJQobYDb1sfZRapvdHZls17+0zxMu2D7Yx
/8PDZb7cCh0cctf/hDiTejMB3njWJB5skg70NmbrZjJmGZUs9lMuh8dTZqiPyYXg
bvVd/+ZPFNKJ2RtuzyLeV+MYGHhnlsTYlr6pkb6zoOBlyaCRpA6Xt3JjTedUcnPD
2LbkbSIiUAiTElavDYyNszDkNsBsufzstSD6CXxqRtk2crA1i+uclgkS4E6t5dE6
JM9vuop0RtoI4EqujLQ8eGMyzu7GvFCltx/cqTaeYNyNEjKf7iBFy/6y6ROBQDwe
G/PtEzmOkx7CFIhLLdFfc5p3p1Nwt2lWNZSLUBZwgix+iLMegeXpoZ9uFWa7I4u8
vegWBOIX2m35GD0dZBS1UuPXhwNoIbrcMMMz9xwwrzCJCPT2pkM=
=Vlo3
-----END PGP SIGNATURE-----

--di4ctraqcqzg7vx5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
