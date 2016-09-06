From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 06 Sep 2016 10:40:48 +0300
Message-ID: <87poohmq67.fsf@linux.intel.com>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8760q9a8m6.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <nfbrown-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

NeilBrown <nfbrown-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org> writes:
> Firstly, you have made the current limit associated with each cable type
> configurable (__usb_charger_set_cur_limit_by_type).   This is nonsense.
> The standard (e.g. BC-1.2) declares what the current limits are.  There
> is no reason for those not to be hard coded.

I had raised the same concern WRT configuration current limits.

> Secondly, you treat each charger type as having a single "cur_limit" and
> utilize that limit by telling the PMIC to draw that much current.
> Again, this is inconsistent with the specification.
> BC-1.2 defines, for each charger type, a minimum and maximum current
> level.
> The minimum should always be available.   Attempting to draw more than
> that (but less that the max) might work or might cause the charger
> to shut down, but you can be sure that the charger will respond to the
> increased load by first reducing the voltage, and will not shut down
> until the voltage has dropped below 2V.
> If you try to draw more current than the maximum, then the charger might
> shut down before the voltage drops below 2V.

Very well put :-)

> Given this understanding of the current available from the charger,
> there are two approaches the PMIC might take.
> 1/ if the PMIC is able to exercise fine control over the current it
>   draws, and if it can monitor the voltage on the charger, then it
>   could gradually increase the power being requested until the voltage
>   drops below some threshold (e.g. 4.75V), and then (probably) back off
>   a little.  It should only increase at most up to the maximum, even if
>   the voltage remains high.  It should probably start at zero rather
>   than at the minimum.  This allows for lossage elsewhere.

That's what most charging control SW I've seen in the past ends up
doing. Correct

> 2/ If the PMIC cannot measure voltage, or doesn't have sufficiently fine
>    control of the current requested, then it should request only the
>    minimum available current.  Any more is not safe.

correct

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXznMAAAoJEMy+uJnhGpkGgLkP/20Tgt73necOGMLB0R6fgJq8
OGJFz/RnmDyoXLDMWjWM3vOAxUUvKvMkhNgiaJlNTCB3RYHhX+SrsIyl5o7Rr051
MFn1Gci/7KpzpLf3bq6b7kO1X9IRdhdv2ENEZLA0sX2N4PlP4wtMeKOtzrzKZfqN
hv9sKaIcgxj2Y1l8dd8+9nsB9pnit/9uKIGwCFxoSTv54elLB6ZLYzm9dVNwqSRc
6y30yJ9yjYiO2ymGmE8m08vovYBn5nfGQYhPl8U0fjAHKDAU/pfpIaaLXB9qyVQd
cgsZKGkZyOkyVdzg+uu6TGP1jZSIIn0ErFbp6g0Sa06r3HaVrt3MR3FqnSoUU/OS
LAz3ygBBaZwMjD02DC9H5bewiwT808RHAGHrt5HpEdzxk7G83Oo10ja5d3KpcyS0
xUTbjm32TMnB8EKh+pgbCL+6ZGiMTTsUsQO+NORRn3OlcD5Nprz1f6erpyra5kiO
fTDEkJ3oPLnjgH5C3DChW/oMsZIut++KB5JD89fmXiGzjnXqgMQQhqp02Fd3WrKg
wChz5/Xv1qzI+N66qZqVT9yD/DkiCjbB/9jnifJ39WFENz78IlRo10ECayZFC3gQ
xlouNFMj8sJFa60GFdiljq0Wo7kdp7V5o6goatMDKv/jTT6iBulfQXZ+7lnt2hzi
4PjS6mccfmAXBHKaOTr5
=r/Fs
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
