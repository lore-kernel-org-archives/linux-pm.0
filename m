From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 13:06:24 +0300
Message-ID: <8737r7gdwf.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com> <87bn5vgiwx.fsf@intel.com> <CAMz4ku+eBP1MU4kM4pP6k+SRbUXGS4m08GDdsGp7J-5a0DdPow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4ku+eBP1MU4kM4pP6k+SRbUXGS4m08GDdsGp7J-5a0DdPow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Baolin Wang <baolin.wang@linaro.org> writes:
> [ text/plain ]
> On 31 March 2016 at 16:18, Felipe Balbi <balbi@kernel.org> wrote:
>>
>> Hi,
>>
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>>>>>>
>>>>>> According to the spec we should always be talking about unit loads (1
>>>>>> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will n=
ot
>>>>>> work for SS capable ports and SS gadgets (we have quite a few of the=
m,
>>>>>> actually). You're missing the opportunity of charging at 900mA.
>>>>>
>>>>> I follow the DCP/SDP/CDP/ACA type's default current limitation and
>>>>> user can set them what they want.
>>>>
>>>> no, the user CANNOT set it to what they want. If you get enumerated
>>>> @100mA and the user just decides to set it to 2000mA, s/he could even
>>>> melt the USB connector. The kernel _must_ prevent such cases.
>>>>
>>>> In any case, DEFAULT_SDP_CUR_LIMIT shouldn't be a constant, it should =
be
>>>> variable because if you enumerate in SS, you _can_ get up to 900mA.
>>>
>>> Make sense. But these are just default values. They can be changed
>>> safely by power driver with 'usb_charger_set_cur_limit_by_type()'
>>> function to set 900mA.
>>
>> oh okay. Still, the default value should be a function of gadget->speed,
>
> Sorry, I did not get your suggestion, could you give me an example? Thank=
s.

int default_current_limit =3D 500;

if (gadget->speed >=3D USB_SPEED_SUPER)
	default_current_limit =3D 900;

>>>>>>> +
>>>>>>> +/* USB charger state */
>>>>>>> +enum usb_charger_state {
>>>>>>> +     USB_CHARGER_DEFAULT,
>>>>>>> +     USB_CHARGER_PRESENT,
>>>>>>> +     USB_CHARGER_REMOVE,
>>>>>>> +};
>>>>>>
>>>>>> userland really doesn't need these two ?
>>>>>
>>>>> We've reported to userspace by kobject_uevent in
>>>>> 'usb_charger_notify_others()' function.
>>>>
>>>> I mean as a type ;-) So userspace doesn't have to redefine these for
>>>> their applications.
>>>
>>> Make sense. I can introduce some sysfs files for userspace. Thanks for
>>> your comments.
>>
>> okay, my reply was a bit cryptic, but what I mean here is that enum
>> usb_charger_state could be moved your include/uapi header. My question
>> is, then, does userland need to have knowledge of enum
>> usb_charger_state ?
>
> I am not sure if userland need the enum usb_charger_state. But I
> remember you want to report the charger state to userland in previous
> email.

right, which means this enumeration definition could be placed in the
UAPI header. Unless, of course, we're reporting strings, rather than
integers, in the sysfs file.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/PahAAoJEIaOsuA1yqREEi4P/R8vYeENSFr9GV9ZCLnFx+K6
qtzFt7MBTFb+4L07Qprlw4e/FOjnfFSC/nWXlztVHqVdgFblKVbcsnAnMJhooMBC
8dIdlCy8fYE+8Ar4aRGhGldj1oF8hogi9A8ExKb0e010sdGPGDvWcPk00cUDpIbb
OWTwVnqhWctThRBeExrBj605ukOA6+wOPKoUSCPpgaC3NqDvkyq1i9hXT2iVTacZ
sJZvRLkCqk11rbWq3g5YrjSrSdVN6aY8yzrPHkPfpqOBO82093vhQiz+VSOQfMuQ
UewCbtNBmW75v0kWziFouvE6ngw6kWgkFAcMruXrCVjeoPksoiptbDK2IIjeoAGi
k/BzMfs9QJR7mqfiYY2xLChEo4xJxekoQxDMHbP7VVW8RZyTztKHADjHTC4zfEyO
kMK3gc1CNK+FXpMJRXbYFFX9/5Dy0jrvFLYYd7n8o2kHVHOKV5x2zxdkffYP/g57
1et4vJ6qKnanzPIKDRcZw1wNunOOR3GeKsISwFOtDe3OMz+f13UeV3XznKV12Klj
BJIwKaDtN01/maqop8gBOfoA2E42UmmPGLrM/qfGAZVuvPswJiMYIuiAlBA90LTA
DO9ifiDhLMz4eOsiSMGel3rUlCkgDsnmhlN7Rpj+Y9mTdKY2ZCs2rDAtF7gYNgvK
awDFErQ2sy2+iimQgI5c
=HuOi
-----END PGP SIGNATURE-----
--=-=-=--
