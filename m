From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Wed, 29 Jun 2016 15:06:46 +0300
Message-ID: <87twgcgpwp.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4kuJ990pfVxSz7sVEOOiL8gC+BAjJ=PLioez5_Y5c+OyxxQ@mail.gmail.com> <87eg7giexn.fsf@linux.intel.com> <CAMz4kuK30ZGdqgyHNj=xnVLSpceCFD4R8-LvqMS3EOUTUhcHtA@mail.gmail.com> <87bn2kieb6.fsf@linux.intel.com> <CAMz4kuL9pJzNsn7xXXCp4s9Rczm5vWhuWfF7VjkuxsMUzNZXZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuL9pJzNsn7xXXCp4s9Rczm5vWhuWfF7VjkuxsMUzNZXZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>>>>> For supporting the usb charger, it adds the usb_charger_init() and
>>>>>>> usb_charger_exit() functions for usb charger initialization and exi=
t.
>>>>>>>
>>>>>>> It will report to the usb charger when the gadget state is changed,
>>>>>>> then the usb charger can do the power things.
>>>>>>>
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>>> Reviewed-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>
>>>>>>> Tested-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>
>>>>>>
>>>>>> Before anything, I must say that I really liked this patch. It's
>>>>>> minimaly invasive to udc core and does all the necessary changes. If=
 it
>>>>>> wasn't for the extra charger class, this would've been perfect.
>>>>>>
>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>> completely?
>>>>>>
>>>>>>>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, =
unsigned mA)
>>>>>>>  {
>>>>>>> +     if (gadget->charger)
>>>>>>
>>>>>> I guess you could do this check inside
>>>>>> usb_gadget_set_cur_limit_by_type() itself.
>>>>>
>>>>> We will access the 'gadget->charger->type' member when issuing
>>>>> usb_gadget_set_cur_limit_by_type(), so I think I should leave the
>>>>> check here in next new version.
>>>>
>>>> Here's what I mean:
>>>>
>>>> int usb_charger_set_cur_limit(struct usb_gadget *gadget, unsigned int =
mA)
>>>> {
>>>>         struct usb_charger *charger;
>>>>         enum usb_charger_type type;
>>>>
>>>>         if (!gadget->charger)
>>>>                 return 0;
>>>>
>>>>         charger =3D gadget->charger;
>>>>         type =3D charger->type;
>>>>
>>>>         return __usb_charger_set_cur_limit(charger, type, mA);
>>>> }
>>>
>>> But that means we need to export  both 'usb_charger_set_cur_limit()'
>>> function and '__usb_charger_set_cur_limit()' function in charger.c
>>> file. Cause some user may want to set the current limitation by one
>>> charger type parameter (may be not from charger->type), like by
>>> issuing '__usb_charger_set_cur_limit(charger, SDP_TYPE, mA)'. How do
>>> you think about this situation? Thanks.
>>
>> if we have that requirement, that's totally fine. Just rename
>> __usb_charger_set_cur_limit() back to
>> _usb_charger_set_cur_limit_by_type() and expose both. But
>> set_cur_limit_by_type can assume its arguments are valid at all times.
>
> Make sense. I'll fix this issue in v14 version. Thanks.

there's one thing bothering me though:

gadget->charger is supposed to be "current detected charger" right? If
we have a single port tied to a single charger, in which case would we
*ever* need to change current limit of any charger type other than
"current charger" ?

IOW, why do we need _set_cur_limit_by_type() exported at all?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXc7nWAAoJEIaOsuA1yqREackP/3GhRlN1gavtNaMtBrJ0fItG
OHtk9tckBJXw/I2Gfx/lNpNbC6y7zkqUSX+dkBLSUNkR5HRK61uOam8sGlo4XYyK
87/3W8fL0rbQQddM1lLyXoJ9zwv0BHKIKu52fWgBd08Gp/vZ/8otv1xQX8nxisls
BpdyVMTcXiv6nV9UZtNlaj//8+XD2dF6Lx2neyCpYtYdsIDPrYB8wlR4ClTWuJGJ
abfhKqS/0zUnUi8xccPQpkn3XOzPGa6TtstbUklYAnPszWDcc0QIwrul2QokqcdQ
C6dcd46tY5uZ3yh/UibfSfpVoKLo3k9CU5zeaDsElojmhXdtlmGOZdHV5Oql2Pxh
QyqCjlXYfHRCpwwz8Ff8Xs8GRTuTN+BAxIkKcBgt+s/Kvn9Juj+1MuPcyQN8WdM/
TdySzUobK3B1YTLTaFdBCnPx4e7ZY18j6GnYDAijHUpTqlC8ZlJlYcmxG8XLvocA
VqjJw7tL2whUH/aHdfku1spD7nAvOxVkkWpDKs2ANyIXSPom4Led45rPEReiN00k
ZS1wgtN0Kvr12lY5r6EiHSixdGT3Uz7T5gaklAGivZKrENB1B4x1OYWU/mTtiRt/
RMlt71juzEZi83oUSM0W90Hn8DQGh4X0lXbmtFQaNgd7wNUdINcku4wenls1FYP1
hrhO+iUjrREeAg0ERKYt
=K8Xg
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
