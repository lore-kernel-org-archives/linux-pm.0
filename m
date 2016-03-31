From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Thu, 31 Mar 2016 09:18:21 +0300
Message-ID: <87y48zgogi.fsf@intel.com>
References: <cover.1458822334.git.baolin.wang@linaro.org> <20160325070937.GA22398@peterchendt> <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com> <AM4PR04MB1665C9DAC2519CDCFEF92DDC89870@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuKkZ1GAjEoi7KB8EwjPQvW2Lf28VPzMgW2QdD=Ro4jzSQ@mail.gmail.com> <AM4PR04MB16657BE747BA7451511420D189980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLh9XfuL7kK4v2eJMU=QpdZx3d8KpMfH5Df2iZK=PLCqQ@mail.gmail.com> <AM4PR04MB1665F6673ABDDD08AAF68CE489980@AM4PR04MB1665.eurprd04.prod.outlook.com> <CAMz4kuLY8vO5qnkuY+kv91zKpdxBBSDeLZXFvD1LjnS3R3UccA@mail.gmail.com> <AM4PR04MB1665E85D823D5AB59B54B56D89980@AM4PR04MB1665.eurprd04.prod.outlook.com> <878u10jjie.fsf@intel.com> <CAMz4kuJhrfE_6s2y9Cdo8t3Z3mvKf9rYs-kkRfBFD_SNL7pv=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuJhrfE_6s2y9Cdo8t3Z3mvKf9rYs-kkRfBFD_SNL7pv=g@mail.gmail.com>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "r.baldyga@samsung.com" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches@opensource.wolfsonmicro.com" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> [ text/plain ]
> On 30 March 2016 at 19:24, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>> >> >> >
>>>> >> >> > Seems you don't want to guarantee charger type detection is do=
ne
>>>> >> >> > before gadget connection(pullup DP), right?
>>>> >> >> > I see you call usb_charger_detect_type() in each gadget usb
>>>> >> >> > state
>>>> >> >> changes.
>>>> >> >>
>>>> >> >> I am not sure I get your point correctly, please correct me if I
>>>> >> >> misunderstand you.
>>>> >> >> We need to check the charger type at every event comes from the
>>>> >> >> usb gadget state changes or the extcon device state changes, whi=
ch
>>>> >> >> means a new charger plugin or pullup.
>>>> >> >>
>>>> >> >
>>>> >> > According to usb charger spec, my understanding is you can't do
>>>> >> > real charger detection procedure *after* gadget _connection_(pull=
up
>>>> >> > DP), also I don't
>>>> >>
>>>> >> Why can not? Charger detection is usually from PMIC.
>>>> >
>>>> > Charger detection process will impact DP/DM line state, see usb
>>>> > charger spec v1.2 for detail detection process, section 4.6.3 says:
>>>> >
>>>> > "A PD is allowed to *disconnect* and repeat the charger detection
>>>> > process multiple times while attached. The PD is required to wait for
>>>> > a time of at least TCP_VDM_EN max between disconnecting and restarti=
ng
>>>> > the charger detection process."
>>>> >
>>>> > As Peter mentioned, the charger detection should happen between VBUS
>>>> > detection and gadget pull up DP for first plug in case. So when&after
>>>> > gadget connect (pullup DP), you should already know the charger type.
>>>>
>>>> Make sense. In our company's solution, charger detection can be done by
>>>> hardware from PMIC at first, then it will not affect the DP/DM line wh=
en
>>>> gadget starts to enumeration.
>>>
>>> I see, charger type detection is done automatically by PMIC when VBUS
>>> is detected in your case, you just assume the process is complete
>>
>> assuming this finishes before gadget starts is a bad idea. It would've
>> been much more robust to delay usb_gadget_connect() until we KNOW
>> charger detection has completed.
>
> It is hardware action to detect the charger type quickly. It actually
> *gets* the charger type and does not means *detect* charger type in
> 'usb_charger_detect_type()' function. Maybe I need to change the
> function name as 'usb_charger_get_type()'.

yes.

> If some udc drivers want to detect charger type in
> 'gadget->ops->get_charger_type()' callback, they should avoid
> impacting DP/DM line state at the right gadget state. Thanks.

they shouldn't detect is get_type(), the semantics doesn't work. If, at
some point, we have to do SW detection of the charger, then a new
=2D>charger_detect() method will have to be added.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/MEtAAoJEIaOsuA1yqREczsQAIUxKA5T+vxl+AMvAdDNUXLb
FK8LO4vubXsGTRrxuEXaG0mm6BOajMiYrQPZZ7+/EbxgEIW1nw8NTChYIR036KvD
PUJ1EbyEWj5YiJ5l/c62H3ZnR7UBMkgOg8n7R+SrYCC/H2IGeVXZgD/rgQDwvWCy
ZxCSE9/HBhV/gj9bxONZH/6ANKFfzOm/A7ZtOY8PgzOaalusbYgnBb+1AYCn1/LS
6QXiNlZQGRFYlsVADRMLRjFeHKtpp21drgTRqtHDYshKvZQULAe6Eo7NYbSlwsfu
qmjqiIs+d1SeCOXii4tOqv5OYw0Yol4Gr+MRZ7GCJSJuqbDHbkvqZ2SzKfcez9Kw
q8U+Ma9Eh08yLVaR9PdpjFZDsq9J+8hCo5YNbiL7AVU3K+LjRo5cAzZjgF99AcqC
sebadGyGBx/YGOgIfnTX4r7pSzaTAWvumuYSA6xKSTQQsww96ilfausg6gIulxZF
5p5G2jw5ZEOgRCyxWBei23cCt6viIha78xtPljscwDnpWBN1gOIKFBFPRJ1IAtWl
lw4s07ZkaeVN+8EKPO1j6QV4pACiWY5xSfiGtkfQ+Vtfnj2qSTFo0CYbz4sTcVBZ
IWPaS0TPf/wd6U0qOy05jgYbYBS6/h4eY0z+WKai+HIGp2PEFuwbrmrLeTgxEGVu
xAZm0VoKkEqG20MtAl+b
=HMbA
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
