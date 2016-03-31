From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 11:18:06 +0300
Message-ID: <87bn5vgiwx.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>>>>
>>>> According to the spec we should always be talking about unit loads (1
>>>> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
>>>> work for SS capable ports and SS gadgets (we have quite a few of them,
>>>> actually). You're missing the opportunity of charging at 900mA.
>>>
>>> I follow the DCP/SDP/CDP/ACA type's default current limitation and
>>> user can set them what they want.
>>
>> no, the user CANNOT set it to what they want. If you get enumerated
>> @100mA and the user just decides to set it to 2000mA, s/he could even
>> melt the USB connector. The kernel _must_ prevent such cases.
>>
>> In any case, DEFAULT_SDP_CUR_LIMIT shouldn't be a constant, it should be
>> variable because if you enumerate in SS, you _can_ get up to 900mA.
>
> Make sense. But these are just default values. They can be changed
> safely by power driver with 'usb_charger_set_cur_limit_by_type()'
> function to set 900mA.

oh okay. Still, the default value should be a function of gadget->speed,
IMO ;-)

>>>>> +
>>>>> +/* USB charger state */
>>>>> +enum usb_charger_state {
>>>>> +     USB_CHARGER_DEFAULT,
>>>>> +     USB_CHARGER_PRESENT,
>>>>> +     USB_CHARGER_REMOVE,
>>>>> +};
>>>>
>>>> userland really doesn't need these two ?
>>>
>>> We've reported to userspace by kobject_uevent in
>>> 'usb_charger_notify_others()' function.
>>
>> I mean as a type ;-) So userspace doesn't have to redefine these for
>> their applications.
>
> Make sense. I can introduce some sysfs files for userspace. Thanks for
> your comments.

okay, my reply was a bit cryptic, but what I mean here is that enum
usb_charger_state could be moved your include/uapi header. My question
is, then, does userland need to have knowledge of enum
usb_charger_state ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/N0+AAoJEIaOsuA1yqREBoYP/2f90uB+sSP7RobSC+fZgsBU
0oKk4l0SJfCSBiOVqiy0LMXCOCAPTJ/AKyECCCi4wH19pSeCnCYFl7DEbk4fH8lA
LG0/KhBYx9hQ5Tw1jbnhVrCLq/uNtshCHMH3ginle3yq42JG8HkrgcxwgW0Nz2TX
Wjn0+kvw3/rqwJ6teRJsi+L1nMzZ0q8Rak/RK4Fv8QyKWO2y3KSHa6uQkfM2EoIo
iUmemFHUbmtBInng1S4no6xPrWvnunHM6N4EWlCklA82qbrXTJM0T90r8cGJluT8
AhQxw7dOzmy8a4qRqGi4MKSlYavWkexq5aLippr/B4kI5u8ksrkZE7VgKsvKEW24
CpRpqlyXCuEcZ4nLz7rzwiGvMf1nqmxtw/uag/607WeiT1oFmvBEVEEe7c0jtsUl
dWEhuIwAmLfWvFklnNlmeFQQyUuF8ZnXQg0/1lYJAzUahT0lcwWFU+8Npd9pm1LP
5EpGAZ4o/oOhWvSAd4+iJtCY8h02QNHAO+vSC0i3OXxv+GoEE7YGpYJ2IsWINS0N
8LLbRe56h2xrucOFBCya+QLeFBJtj2J2Jhvx1th5oZT+9kf6NIZRcIxRsI0EWN6c
cnmFXMID5acZlHCMAH/cBoWkZGFDBmf8sDTcRmVmuzgD8pJSyDLDFJkpCt2SeTTR
84tsSQ0dd2PE08YHuAAf
=5m61
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
