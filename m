From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 09:42:58 +0300
Message-ID: <87poubgnbh.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbcCaGo4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Mar 2016 02:44:56 -0400
In-Reply-To: <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Baolin Wang <baolin.wang@linaro.org> writes:
>>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>>> index af5d922..82a5b3c 100644
>>> --- a/drivers/usb/gadget/Kconfig
>>> +++ b/drivers/usb/gadget/Kconfig
>>> @@ -133,6 +133,13 @@ config U_SERIAL_CONSOLE
>>>       help
>>>          It supports the serial gadget can be used as a console.
>>>
>>> +config USB_CHARGER
>>> +     bool "USB charger support"
>>> +     help
>>> +       The usb charger driver based on the usb gadget that makes an
>>> +       enhancement to a power driver which can set the current limitat=
ion
>>> +       when the usb charger is added or removed.
>>
>> sure you don't depend on anything ?
>
> It just depends on USB_GADGET.

okay, that's cool :-)

>>> +
>>> +#define DEFAULT_CUR_PROTECT  (50)
>>
>> Where is this coming from ? Also, () are not necessary.
>
> Just want to protect the default current limitation. If that does not
> need, I'll remove it.

It's your HW :-) You tell me if it's really necessary. But, hey, if you
get enumerated @500mA, this is the host telling you it _CAN_ give you
500mA. In that case, why wouldn't you ?

>>> +#define DEFAULT_SDP_CUR_LIMIT        (500 - DEFAULT_CUR_PROTECT)
>>
>> According to the spec we should always be talking about unit loads (1
>> unit load is 100mA for HS/FS/LS and 150mA for SS). Also, this will not
>> work for SS capable ports and SS gadgets (we have quite a few of them,
>> actually). You're missing the opportunity of charging at 900mA.
>
> I follow the DCP/SDP/CDP/ACA type's default current limitation and
> user can set them what they want.

no, the user CANNOT set it to what they want. If you get enumerated
@100mA and the user just decides to set it to 2000mA, s/he could even
melt the USB connector. The kernel _must_ prevent such cases.

In any case, DEFAULT_SDP_CUR_LIMIT shouldn't be a constant, it should be
variable because if you enumerate in SS, you _can_ get up to 900mA.

>>> +#define DEFAULT_DCP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>> +#define DEFAULT_CDP_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>> +#define DEFAULT_ACA_CUR_LIMIT        (1500 - DEFAULT_CUR_PROTECT)
>>> +#define UCHGER_STATE_LENGTH  (50)
>>
>> what is this UCHGER_STATE_LENGTH ? And also, why don't you spell it out?
>> Is this weird name coming from a spec ? Which spec ?
>
> It is used to indicate the array size to save the charger state to
> report to userspace. I should move it to where it is used.

and ARRAY_SIZE(arr) is not enough ?

>>> +static DEFINE_IDA(usb_charger_ida);
>>> +static struct bus_type usb_charger_subsys =3D {
>>> +     .name           =3D "usb-charger",
>>> +     .dev_name       =3D "usb-charger",
>>> +};
>>> +
>>> +static struct usb_charger *dev_to_uchger(struct device *udev)
>>
>> nit-picking but I'd rather call this struct device *dev. Also, I'm not
>
> OK.
>
>> sure this fits as a bus_type. There's no "usb charger" bus. There's USB
>> bus and its VBUS/GND lines. Why are you using a bus_type here ?
>
> I want to use bus structure to manage the charger device. Maybe choose
> class to manage them?

I guess a class would fit better in this case.

>>> +{
>>> +     return container_of(udev, struct usb_charger, dev);
>>> +}
>>> +
>>> +static ssize_t sdp_limit_show(struct device *dev,
>>> +                           struct device_attribute *attr,
>>> +                           char *buf)
>>> +{
>>> +     struct usb_charger *uchger =3D dev_to_uchger(dev);
>>> +
>>> +     return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
>>> +}
>>> +
>>> +static ssize_t sdp_limit_store(struct device *dev,
>>> +                            struct device_attribute *attr,
>>> +                            const char *buf, size_t count)
>>> +{
>>> +     struct usb_charger *uchger =3D dev_to_uchger(dev);
>>> +     unsigned int sdp_limit;
>>> +     int ret;
>>> +
>>> +     ret =3D kstrtouint(buf, 10, &sdp_limit);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     ret =3D usb_charger_set_cur_limit_by_type(uchger, SDP_TYPE, sdp_l=
imit);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return count;
>>> +}
>>> +static DEVICE_ATTR_RW(sdp_limit);
>>
>> why RW ? Who's going to use these ? Also, you're not documenting this
>> new sysfs file.
>
> Cause we have show and store operation for SDP type. If users want to
> know or set the SDP current, they can use the sysfs file.
> I'll add the documentation for it.

but why would the user change it ? Here's the thing: you have a few
posibilities for this:

a) you are connected to a dedicated charger

	In this case, you can get up to 2000mA depending on the charger.

	If $this charger can give you or not 2000mA is not detectable,
	so what do charging ICs do ? They slowly increase the attached
	load accross VBUS/GND and measure VBUS value. When IC notices
	VBUS dropping bit, step back to previous load.

	This means you will always charger with maximum rating of DCP.

	Why would user change this ? More is unsafe, less is just
	stupid.

b) you are connected to a host charging port and get enumerated with
your 500mA configuration.

	you *know* 500mA is okay, but you _can_ get more (it is a
	charging port after all). So charging IC will connect a 500mA
	load and step upwards until VBUS drops a little, just like (a)
	above.
=20=20=20=20=20=20=20=20
	This means you will always charger with maximum rating for this
	host charging port.

	Why would user change this ? More is unsafe, less is just
	stupid.

c) you are connected to a standard port and get enumerated with your
500mA configuration.

        you *know* 500mA is okay. So you connect a 500mA load and get it
        over with.

	This means you will always charger with maximum rating for this
	SDP.

	Why would user change this ? More is unsafe, less is just
	stupid.

d) you are connected to a standard port and get enumerated with your
100mA configuration.

	you *know* 100mA is okay. So you connect a 100mA load and get it
	over with.

	This means you will always charger with maximum rating for this
	SDP.

	Why would user change this ? More is unsafe, less is just
	stupid.

do you see what I mean ? It's pointless to let this
be-writeable. Whatever value user writes will either be unsafe or
sub-optimal.

Just trust the charging IC to do a good job.

>>> +     &dev_attr_sdp_limit.attr,
>>> +     &dev_attr_dcp_limit.attr,
>>> +     &dev_attr_cdp_limit.attr,
>>> +     &dev_attr_aca_limit.attr,
>>> +     NULL
>>> +};
>>> +ATTRIBUTE_GROUPS(usb_charger);
>>
>> static ?
>
> This macro will add 'static' automatically. So don't need to add.

indeed, thanks.

>>> +
>>> +/* USB charger state */
>>> +enum usb_charger_state {
>>> +     USB_CHARGER_DEFAULT,
>>> +     USB_CHARGER_PRESENT,
>>> +     USB_CHARGER_REMOVE,
>>> +};
>>
>> userland really doesn't need these two ?
>
> We've reported to userspace by kobject_uevent in
> 'usb_charger_notify_others()' function.

I mean as a type ;-) So userspace doesn't have to redefine these for
their applications.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/MbzAAoJEIaOsuA1yqREIAUP/2lBneNcUDDSL2/G9y9eFrFt
3oq8iqMNGSYTVnzCIZEbvpFhDQcWv6i1Hf/gnPwIizMKoPvKltUCaOcwD9FDXu+R
GGfVOYx/emE7Xra3e6Wlcy0hOKA+X4KnIRrk8oH7Kg5OKnLaRYX+l9SYVQcISsL1
BedQ9E6dNm2IXYOu8mdXVlUTTqi6qcopANq0B9zMX5aNs00/y3v8xVWzFyZo5uod
9rw/0l1fQnGS/F1xf01vwd/UPPP83EBVhKL2TgqayOOk5SNsAbpPxMNjI74COwme
EoCA/y5pJZn9yR1vlW1qcw4g0mRkQMM2zwJzXYL+7Qx3Ssw7gT6+fe+yiRO+QHVm
/kDHRp+O+MASdl6bgZy55jX4v1bh7DvIjQcyvIUmPzlBNdoU7l1ghrnz5JNEcx89
4kYPU2k+L9WKrqmYa9RcfLEVGXkX+bJR2I3vWaOT1ECd837l3LH0aeb4c8jBpBLy
yqM2nuGnlcOCODeh230r6XKeESBNXSgXrF4IOBygtygYOt9JUUTkIe8pV6sz++eO
7YDh6yKUCpFM+O46aj8MppmXiONjjIOnD8P11EKfcoZqhTEzmZzgrnJ4lT8E2f3K
8T9miIn+b19PoQCz2JI+iFAZlhWqQd3EZzo1wkI1DNQ1VsjTvZkEGkPNvVaPaR9s
0GN3umMxFom3lBCrPTSA
=DXwN
-----END PGP SIGNATURE-----
--=-=-=--
