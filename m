From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
Date: Fri, 3 Jun 2016 04:38:53 +0200
Message-ID: <20160603023853.GD8921@earth>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57409633.8060605@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Chris Brand <chris.brand@broadcom.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Sat, May 21, 2016 at 10:09:07AM -0700, Florian Fainelli wrote:
> Le 11/05/2016 14:36, Chris Brand a =E9crit :
> > This driver supports reset on both BCM21664 and BCM23550.
> > Code is being moved from arch/arm/mach-bcm/board_bcm21664.c
> >=20
> > Signed-off-by: Chris Brand <chris.brand@broadcom.com>

> Sebastian, Dmitry, I know we are in the merge window, let me know if you
> would want me to take this patch and the 5 others in the next arm-soc
> pull request, or if you prefer to take this one in your own tree.

Feel free to queue it via arm-soc with

Acked-By: Sebastian Reichel <sre@kernel.org>

If I didn't overlook it, it's missing DT documentation, though.

-- Sebastian

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUO26AAoJENju1/PIO/qaZPcP/2gZa+TYc7gQxES7TDUsNnLU
OKTIRQPXId7lzwIZG3LaBrMvjfsavxMEtohGV+Ccj7i1xYImr8RogrRGsAVDi4OL
1/jx/WezJGgqoyfXS8V9PM99qcHZjvW4lijZwpw5EVUy4TjcIaRI3IrhNUrlxS8V
Pc6dm3/Rwf6WgbVGpQrD/wF48hIL9FVBbmNSLKKBA3/9OiiVW9v5vmcDvAvmY+UD
H42nCBIr5aEGdXoZHjvuQ3LY+GOUBNqASL2HqYbn6+Wfr60a3anBvZTaJP0PJUrs
IJ0Rg3WWZqVA8X/lOVoKyNAwL+TRFm+km7q5qtDzk4TD3YSqBIT1TSy4kfsmPRGd
b/vdvO4ARs4en9Z3g1doHBU8Ttmouw5WExEuruU34L5rzk0xXOGxBTn+/CZnEgl2
MhlMaAcE2iBQRT+kbooOhp3CzFI+/BIQyAwYUYLNGOX4w2TKC+YaABs2rrzNqHK6
Edmc/iCsxN+ZFF7GWwX663q+D85JtiaOUuw0jqltMZsO+ReQJHSgbP4UMKYOSHBF
zmLtzBzXrIL1DGV41ruHt4u9343SboKczaHU1UK/gISH+ezfMptp6pa9i7RFDAmV
M5r5GSxBTQ8bwDjN00xdTK2KwWQpp8VMovRfHdvUDiR6BEVF/aWNbgMucNBy+BSB
uK2rEyMu90Ak7qplRqRB
=+JU8
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
