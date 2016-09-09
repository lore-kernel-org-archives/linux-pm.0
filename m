From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V4 2/4] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 09 Sep 2016 10:57:24 -0700
Message-ID: <87a8fharcr.fsf@eliezer.anholt.net>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org> <1473407397-29395-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473407397-29395-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0vgEAAoJELXWKTbR/J7olGwP/A1wSMEPup0hv26uG+JKQclD
G+VeC/o1DACeFo6sUwzF7Pv7e1krEUlw9i7XFfPaBcgUqibCKtmXBNR3JMeCKDTa
Eg6ycCChyAINGr23r1LeGMsy9waD0FDtlByfc1lP+/LrEUi1clY7v/bRVTnWYsQz
xHUR+83cD/xfc4LntAqmQsMUVSDu+BYChkD9mqVAomKUZChNAmFFNUP1b+5a7xel
59Q+lgLy668BO5gYnZqp1TT9bdjok0mLRokbTCUEzw07ozznzs8jqYPoELpnC1vp
Mxwjdl4m4lDZVGiPk3yuHtfJaflcvtCGQzXsheWqvZk/dcoUaoJPchRG+qWgffeE
HbPhtx+mXFm/SR2l4m0HFpYMx/lm2hI9GZ/Gs2X+BBXzyeqUxO1efOm37UJn1Nrt
LiwOMfK/dnWvBH2n2NUzXHRj42hw5VeV95/oaUS5RlWq/D4c6thiERR1z9/552cW
kM1+5yM/ad1/SHdJWC8OKxXlnjVda0TCu7TivX3a3KqkbH8T/fLXqz36LedqetK4
6h4oOWgVxoBJOCUU2rmCiSsi0S9VqBO5ZcaJSzRItK7Bsq6/AIEajbJXcNA57qk6
L1xB5ly2wKepF/1Jgw2pB3q9ykdihe13BjJ9gFqLXPaOoryXBQEmK00tlB5LDl8z
mwazFJfa2eHiUi6CorWT
=C2eo
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
