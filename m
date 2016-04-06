From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 06 Apr 2016 15:21:41 +0300
Message-ID: <871t6j2ai2.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org> <20160406071956.GA21101@shlinux2.ap.freescale.net> <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com> <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM4PR04MB2130F58AA1018FFD367C89E0899F0-WOempg8NbQQzjTQnahXoOs9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga@samsung.com" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches@opensource.wolfsonmicro.com" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org> writes:
>> -----Original Message-----
>> From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-
>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Baolin Wang
>> Sent: Wednesday, April 06, 2016 6:47 PM
>> To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org=
>;
>> Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Dmitry Eremin-Solenikov
>> <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Peter Chen
>> <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>; Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>;
>> r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>; Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; Ma=
rk
>> Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Charles Keepax
>> <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>; patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxxddQ6fo/n9Y@public.gmane.org=
om;
>> Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=
>;
>> device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org; LKML <linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger framework
>>=20
>> On 6 April 2016 at 15:19, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
>> >>
>> >> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
>> >>       struct usb_ep *(*match_ep)(struct usb_gadget *,
>> >>                       struct usb_endpoint_descriptor *,
>> >>                       struct usb_ss_ep_comp_descriptor *);
>> >> +     /* get the charger type */
>> >> +     enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
>> >>  };
>> >
>> > Since we already have get_charger_type callback at usb_charger
>> > structure, why we still need this API at usb_gadget_ops?
>>=20
>> In case some users want to get charger type at gadget level.
>>=20
> Why gadget needs to know charger type? I also don't catch the intent of

because some gadgets need to call usb_gadget_vbus_draw(), although for
that they need power in mA rather.

> This api, as my understanding, gadget only need report gadget state chang=
es.
> All information required for usb charger is charger type and gadget state.

you're making an assumption about how the HW is laid out which might not
be true.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBP9WAAoJEIaOsuA1yqREvBoP/0bM1+kVTc3WqDt1FmbXMppG
ltlJAxWespz9QrAGDXs1ZNMTz5AVeTh88VMcJsP6AmiMu8069x+pwYOJDmonmbt3
xkk+v3y4BpvfMmRiY+Uy//Fk7Eccd3NUgVFg2W6WTIClvYjK6aoawaZNlGOC4N2B
dWH0/YyKtL29GCkllsdsI9WnK9hN/zZRKo+1Ph03iIX5XPsac7eFFFSwEsOHXfoP
Sp2yMOrdetrVCTYUELqIUAvrWwuRzEt+ZtA1E0yJ1uFlKzXiSefnFC0Z9AzI2baB
62O3we34nOPUh5tldc1Kla5SThVXX093pU0/YbG0nd4CgA+EDr3ElDYXEwU1zlCZ
S8yOmri2jWZflLi+f9BEP65krikT0FcQvg6JosdUxB1KCaPf9kOeZ37/z1UHKVIJ
RUMPrYCNH2lX0KAHVzqyvBDd3AyKukQLHQwlVWwLaDnKGCO9V5vqf/4vYURXhHX0
+n9XohBQoZ0NV8XhxeOxMn+1aVIZwtnxOVfafd36f4sR8v51QLhoKPDiJvs75vFi
b2DDVUoLqT8pfBstAPtGCYHSvq390k+uHeg1xz6Mm4DLO9NlCSGmfcr4mzNiPSSn
jn2hk1esNUFP/TAwuhQDOWo27tNV3z4sbBb/D+3GJQ8vWbZsib2eqclTroyGBPrm
Uag0Oj3SJRyFH0U9Xy0s
=9iiG
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
