From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Mon, 12 Dec 2016 22:45:14 +0100
Message-ID: <20161212214514.GA17631@katana>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-pm@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Niklas,

thanks for this work!

> +/*
> + * Linear approximation for temperature
> + *
> + * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
> + *
> + * The constants a and b are calculated using two triplets of int values PTAT
> + * and THCODE. PTAT and THCODE can either be read from hardware or use hard
> + * coded values from driver. The formula to calculate a and b are taken from
> + * BSP and sparsely documented and understood.
> + *
> + * Examining the linear formula and the formula used to calculate constants a
> + * and b while knowing that the span for PTAT and THCODE values are between
> + * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
> + * Integer also needs to be signed so that leaves 7 bits for decimal
> + * fixed point scaling, which amounts to a decimal scaling factor of 100.
> + */
> +
> +#define SCALE_FACTOR 100
> +#define SCALE_INT(_x) ((_x) * SCALE_FACTOR)
> +#define SCALE_MUL(_a, _b) (((_a)*(_b)) / SCALE_FACTOR)
> +#define SCALE_DIV(_a, _b) (((_a)*SCALE_FACTOR)/(_b))
> +#define SCALE_TO_MCELSIUS(_x) ((_x) * 10)

Spaces around operators everywhere, please.

I wonder about SCALE_MUL; isn't that more like "unscaling" because _a
and _b are already scaled?

And since _b is always a constant, couldn't we simply drop this macro
and simply do _a * _b (with _a being scaled already and _b not)?

Regards,

   Wolfram


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTxpqAAoJEBQN5MwUoCm2cuEP/0KoIJXzBWDbBngLHRIzn88O
vLG0IMj0neB30TV+TLnFYbBMN9nb14cMSKlvB/uI3gNkk07CuFlJ90JlSm6RgRXs
/22L1VGjmub0ki8v0/6ZUzW490u6oFsFaX2ZPiHLq0o/S5FPaD6fbworCyrwDxzU
+cKny4fsgsShASFElbB5SrjMHYPSLs6S0BHUWfbiyP6WFIsZ03RzSKFXykspLc3g
rapmld+SgIL6FbxhvGylUt80f1wGN7BJJTtTXRDlBgLeWmduXwHtuo/Spf7IB9b0
HZXrV5ZQ2XdGMkzAONxcpcBmnG6k5a2/ieG3qSC1GGsMunvTqy/iajizJ47VRcuL
OEFlZRm5eg9pNbRrmDVpYBpd/b5m0CxJ/bN5NFkvRDjFL4eHomMRjjbEWohGtVLH
Lh4D78kds6rhV/Znh2LTX4w70dMkd5cqOKxm4r/4VBz2fZEAAVuqLOYlKz3Mt672
BglnaOZa5O3AuTZRux/ZEHlR/M4d0xbum+nudYstNO3A/bTladmjUOU7AejRyycG
lRDC0fvhpJvfLs+xapHvCWG/pvJXUxkiLGi/brQYHkNyKO0hqa2fbaJx6b7nBgRZ
mkXdoPIz6rjRWypRRN4bxIP/PuFgaOLRUsdN8LaiQebz387H/veiumXlSBqE0lgB
CquAHYDDwkJPRM+zwokw
=KSZ6
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
