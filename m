From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 06 Apr 2016 15:55:55 +0300
Message-ID: <87oa9m28x0.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org> <20160406071956.GA21101@shlinux2.ap.freescale.net> <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com> <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <871t6j2ai2.fsf@intel.com> <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM4PR04MB213054CF3F597CE2E6FE976F899F0-WOempg8NbQQzjTQnahXoOs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga@samsung.com" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches@opensource.wolfsonmicro.com" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org> writes:
>> >> On 6 April 2016 at 15:19, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >> > On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
>> >> >>
>> >> >> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
>> >> >>       struct usb_ep *(*match_ep)(struct usb_gadget *,
>> >> >>                       struct usb_endpoint_descriptor *,
>> >> >>                       struct usb_ss_ep_comp_descriptor *);
>> >> >> +     /* get the charger type */
>> >> >> +     enum usb_charger_type (*get_charger_type)(struct usb_gadget
>> >> >> + *);
>> >> >>  };
>> >> >
>> >> > Since we already have get_charger_type callback at usb_charger
>> >> > structure, why we still need this API at usb_gadget_ops?
>> >>
>> >> In case some users want to get charger type at gadget level.
>> >>
>> > Why gadget needs to know charger type? I also don't catch the intent
>> > of
>>=20
>> because some gadgets need to call usb_gadget_vbus_draw(), although for
>> that they need power in mA rather.
>
> In below change of usb_gadget_vbus_draw(), already can get charger type
> via usb_charger_get_type().
>
> static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigne=
d mA)
>  {
> +       enum usb_charger_type type;
> +
> +       if (gadget->charger) {
> +               type =3D usb_charger_get_type(gadget->charger);
> +               usb_charger_set_cur_limit_by_type(gadget->charger, type, =
mA);
> +       }
> +
>         if (!gadget->ops->vbus_draw)
>                 return -EOPNOTSUPP;
>         return gadget->ops->vbus_draw(gadget, mA);
>
> Could you detail in what situation gadget->ops-> get_charger_type() is us=
ed?

isn't it right there in the code ? Isn't usb_gadget_vbus_draw() calling
it ? What did I miss here ?

>> > This api, as my understanding, gadget only need report gadget state
>> changes.
>> > All information required for usb charger is charger type and gadget
>> state.
>>=20
>> you're making an assumption about how the HW is laid out which might not
>> be true.
>>=20
>
> What other information you refer to here? Or what I am not aware of?

what I'm trying to say is that you're assuming gadgets don't need to
know anything other than charger type and gadget state (suspended,
resume, enumerated, default state, addressed, etc), but that might not
be true for all UDCs. You can't make that assumption that charger type
and gadget state is enough. The real question is what do we need *now*,
but still keep in mind that what we need *now* might be valid 2 years
from now, so API needs to be a little flexible.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBQdcAAoJEIaOsuA1yqREtH4QAKyfZz6UdEH6HbGbeVqYjhUc
qJJZiMk7lp9FpZIkFdTTSILEkHfYy26PRc5di6rsuwmsOIZOKx1r9iLFPYYJQy8P
IhOuk7SvP5oGe5Tsadt+qb+IQoqKezhndMjTr41bdWy6NhkPpuzYxTqrD4JpWWfZ
vcZxWeTFIM9fjJaNHFiLFsVKvYIBhfsPIty9gJ3LPThhSdyuVXg96DpdTeJbkHNT
WDx/W6iCcSNiNMIeg+Wn3sHzDgvgJp9vZN8eHbsbiIKGtGuv0mJ0bfxIbsG1bgM0
CIDylERz7umOzqNo/MPBu+B2KlJwBqtT2b9mue0OCW2SxRFXXlhNTTuWx0UzYwAq
JDWbC1xzVpCY8z0KNtk/nkcK6tiwTvis46xZjIUhND67TMbKKGoOF1JzztIw+qab
m/4d2iupYdKXtAlNgBMivnvHgyYCXAdsOG0ic5TgOhM4IjtKyDDdJ5y5Up/kANy8
f4Ycc9/0+iDjXtncBbapgzSOqfy5xS57sXOb2HLUDgx3quHGgu8f2NDGSg+fMH50
DnrEfy1HmYJ49zoJ8oN7duzSuyifCuo3evB7xCgRC7CDSY6yR2PzvpLAOGmdD0D/
nfnIwpsF0EseuNnyMvloxWPgkzIYN7Etwuvki2qdULp32+8FaSUWCXeLJwlEgOXf
M0hbzXuI+JzBqLA5uP7n
=/7Tr
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
