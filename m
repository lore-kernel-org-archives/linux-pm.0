From: Felipe Balbi <balbi@kernel.org>
Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 06 Apr 2016 16:58:03 +0300
Message-ID: <87egai261g.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org> <20160406071956.GA21101@shlinux2.ap.freescale.net> <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com> <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <871t6j2ai2.fsf@intel.com> <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com> <87oa9m28x0.fsf@intel.com> <AM4PR04MB2130E03385128C1CD22553E7899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB2130E03385128C1CD22553E7899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, Baolin Wang <baolin.wang@linaro.org>, Peter Chen <hzpeterchen@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Jun Li <jun.li@nxp.com> writes:
>> >> >> > Since we already have get_charger_type callback at usb_charger
>> >> >> > structure, why we still need this API at usb_gadget_ops?
>> >> >>
>> >> >> In case some users want to get charger type at gadget level.
>> >> >>
>> >> > Why gadget needs to know charger type? I also don't catch the
>> >> > intent of
>> >>
>> >> because some gadgets need to call usb_gadget_vbus_draw(), although
>> >> for that they need power in mA rather.
>> >
>> > In below change of usb_gadget_vbus_draw(), already can get charger
>> > type via usb_charger_get_type().
>> >
>> > static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget,
>> > unsigned mA)  {
>> > +       enum usb_charger_type type;
>> > +
>> > +       if (gadget->charger) {
>> > +               type =3D usb_charger_get_type(gadget->charger);
>> > +               usb_charger_set_cur_limit_by_type(gadget->charger, typ=
e,
>> mA);
>> > +       }
>> > +
>> >         if (!gadget->ops->vbus_draw)
>> >                 return -EOPNOTSUPP;
>> >         return gadget->ops->vbus_draw(gadget, mA);
>> >
>> > Could you detail in what situation gadget->ops-> get_charger_type() is
>> used?
>>=20
>> isn't it right there in the code ? Isn't usb_gadget_vbus_draw() calling
>> it ? What did I miss here ?
>
> Well, that's true, so my real meaning is why gadget need get charger type
> via another new api gadget->ops->get_charger_type().

because of semantics. usb_gadget_vbus_draw() is *only* supposed to
connect a load across vbus and gnd so some battery can be charged. Also,
we need to abstract away this ->get_charger_type() operation because it
might be different for each UDC.

$subject has a fragility, however: It's assuming that we should always
call ->get_charger_type() before ->vbus_draw(), but that's a good
default, I'd say.

>> >> > This api, as my understanding, gadget only need report gadget state
>> >> changes.
>> >> > All information required for usb charger is charger type and gadget
>> >> state.
>> >>
>> >> you're making an assumption about how the HW is laid out which might
>> >> not be true.
>> >>
>> >
>> > What other information you refer to here? Or what I am not aware of?
>>=20
>> what I'm trying to say is that you're assuming gadgets don't need to know
>> anything other than charger type and gadget state (suspended, resume,
>> enumerated, default state, addressed, etc), but that might not be true f=
or
>> all UDCs. You can't make that assumption that charger type and gadget
>> state is enough. The real question is what do we need *now*, but still
>> keep in mind that what we need *now* might be valid 2 years from now, so
>> API needs to be a little flexible.
>
> Get your point, flexible, I just thought create an api without any user
> for existing case/spec, wouldn't it be better to let the real user add it
> later when it's needed.

that sure is a fair point.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBRXsAAoJEIaOsuA1yqREYj4P/RFFMxZ+RNMNa3TfoVsj7dtZ
WlYosaTbneTJ0LL/qkqx2OlfEfHyt24PN6xMXnNxx/DD8ste6zc+HxyKc8+Y6VQu
YzEt7wCOhtte8vvJB82co+JUraO21S4aLa9I/6Gtq5odBBiPyDosnmYlusT0geEy
T8qmwjWT5tLsG9gqMcyLbrhhu4hnTPpaeLb2bbPRgEXzHWi6vPbIqyCpAHyLfQ0j
7ZANyA5eychiq24OPSmZmt9sEyriFxKRacr3fbt2yUDyL+K0ItR5ore8+kLNs2P+
JM9EY4C0bc3pyttjIY1AjVnz98Lz+Dy2PpVnJvmQEdL0fjiLynWbtiq/GyHutUb2
ay87fr/+3NxV5QTrl+6wBj486xFSo51yegfj3bw3lP6grtSuwHWsffD8v3wjHuI9
i7HccRYS8Yu0WHjDm363yhXEQ1J/BS3MBR5l3vL+dW8j/XU3dX8VkPeXSsBZOrzN
BMxF7nQ/lpoK0zJI9bf1XG3GEk0t1qeJBQsSVJMxicdTpjkyqzNO9pBgg2n+WDWH
FqE4u6fdhNsF3pfO3MYQvUw7IitfpiBpQvDk9q/FR4NB7e5/iUaQB8kJqqrZ0pc4
7Ca94b+3WBFHkE4EJCkro1D/5/Q0Hqj/k0cOp3wHDvWbi0v6jUOY9nbY8WoKhs9B
Q1raQNevLrrIOa+DaF3R
=lbXJ
-----END PGP SIGNATURE-----
--=-=-=--
