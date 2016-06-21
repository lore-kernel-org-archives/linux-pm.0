From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 1/4] gadget: Introduce the usb charger framework
Date: Tue, 21 Jun 2016 17:50:16 +0300
Message-ID: <871t3qmw9j.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <831e03e8935b4c62e1e6bf94c93e0a08a73d89b2.1466497505.git.baolin.wang@linaro.org> <87eg7qon3r.fsf@linux.intel.com> <CAMz4kuJHPqvYiUGi8Ar5cR_8dENddvVjNEuG1wJVt3E3vp1UOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJHPqvYiUGi8Ar5cR_8dENddvVjNEuG1wJVt3E3vp1UOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>>> This patch introduces the usb charger driver based on usb gadget that
>>> makes an enhancement to a power driver. It works well in practice but
>>> that requires a system with suitable hardware.
>>>
>>> The basic conception of the usb charger is that, when one usb charger
>>> is added or removed by reporting from the usb gadget state change or
>>> the extcon device state change, the usb charger will report to power
>>> user to set the current limitation.
>>>
>>> The usb charger will register notifiees on the usb gadget or the extcon
>>> device to get notified the usb charger state. It also supplies the
>>> notification mechanism to userspace When the usb charger state is chang=
ed.
>>>
>>> Power user will register a notifiee on the usb charger to get notified
>>> by status changes from the usb charger. It will report to power user
>>> to set the current limitation when detecting the usb charger is added
>>> or removed from extcon device state or usb gadget state.
>>>
>>> This patch doesn't yet integrate with the gadget code, so some functions
>>> which rely on the 'gadget' are not completed, that will be implemented
>>> in the following patches.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>> Tested-by: Li Jun <jun.li@nxp.com>
>>> ---
>>>  drivers/usb/gadget/Kconfig       |    7 +
>>>  drivers/usb/gadget/udc/Makefile  |    1 +
>>>  drivers/usb/gadget/udc/charger.c |  770 ++++++++++++++++++++++++++++++=
++++++++
>>>  include/linux/usb/charger.h      |  191 ++++++++++
>>>  include/uapi/linux/usb/charger.h |   31 ++
>>>  5 files changed, 1000 insertions(+)
>>>  create mode 100644 drivers/usb/gadget/udc/charger.c
>>>  create mode 100644 include/linux/usb/charger.h
>>>  create mode 100644 include/uapi/linux/usb/charger.h
>>>
>>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>>> index 2057add..89f4e9b 100644
>>> --- a/drivers/usb/gadget/Kconfig
>>> +++ b/drivers/usb/gadget/Kconfig
>>> @@ -134,6 +134,13 @@ config U_SERIAL_CONSOLE
>>>       help
>>>          It supports the serial gadget can be used as a console.
>>>
>>> +config USB_CHARGER
>>> +     bool "USB charger support"
>>
>> you didn't build test all possibilities, did you?
>>
>> I have a feeling this won't link if USB_GADGET=3Dm. Can you test that?
>
> OK.
>
>>
>>> diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/=
charger.c
>> [...]
>>> +struct class *usb_charger_class;
>>
>> We already have a UDC class, do we really, really need another class
>> here?
>
> We want to manage the usb charger devices by this class and one usb
> charger device is not equal with one usb device which managed by UDC

Can you explain this statement? If charging is done via a USB peripheral
port, why don't we have a 1:1 mapping between charger and UDC?

> class, so can we use UDC class to manage charger devices?
> By the way, you also suggested to use the 'class' things instead of
> 'bus' in previous mail.

true, I did say that. It seems clearer, however, that we don't need this
virtual device here.

>>> +subsys_initcall(usb_charger_class_init);
>>
>> this should always work as module_init(). Please make sure that's the
>> case.
>
> we should make sure the charger class has been allocated before user
> try to add a new gadget to the udc class. So it should be issued
> before 'module_init()' (many usb drivers are at module_init level).

=2DEPROBE_DEFER?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaVQoAAoJEIaOsuA1yqREuJAP/23RKKzh6UmMO87AvyZ/ypt7
G3X+v/D00cnFx0g2d7ctpgzyHIM6qTXo85Z2BzDdtB4U0PQkT3sWzfdgRrEUb9Z8
lNNtH1LsYxkPr2AZ1J6JWqjyzPeNODOxS/9YBU2eqRru5CfR0JAszCaRCVn4AAHe
VtKtO1yRzKFsnAYXS+JgdIPQAvRuHMHS8XmxgSSAh5rZsKjNgO2Lvl92mA+hJ/hJ
S0onrXIU3rmLS94gFWW9R+eiqWJwDXMog5SVpaMIdSK9kt9m5iwBVh8RlChOw8nA
5O4oFRYfOCXg3temTgA+7z1mkPJyVzpVn/dxHcPg1AgCnTJ099pKCQNtdCCmMEzE
4lfnV/pU6qT2qds2vgHIREvq0Z5tyzD5H6vdUUEQT7otlxwKhnlpT77tF5862B/z
K2ZDZHz95XF07WmuDOCLGp1wx+ADfX7DDq3CZdkNF7qWXBVILmep2O/IYiQyKD9p
fPEvGJmBKLwDCyNWxZ2pg4F8csDLcg5GA2DOPmopLhYjOTsKJAwyUHacSBZlBZL7
43exkZy7rIJSnEfLbIHqsR4cvFLBDPtHNsIJirz8GtN2zOKooICOJqknW4Q6b0oe
JjnOzZZ1wmCKArolbt4SFgcvKWtYFd54q1l+G2kAopEZn6t4OedPyykO2v1kCvw4
YqIOHv1Rpfwhux11IGHS
=UPvc
-----END PGP SIGNATURE-----
--=-=-=--
