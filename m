From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] thermal: new asus driver
Date: Wed, 21 Aug 2013 14:54:36 -0500
Message-ID: <CAMP44s1_ZN0ZewJre41Bp50OmwM8djM2uR_xGybQLLgke2w2VA@mail.gmail.com>
References: <1375829300-14081-1-git-send-email-felipe.contreras@gmail.com>
	<1376551353.2335.117.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:51742 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3HUTyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2013 15:54:37 -0400
In-Reply-To: <1376551353.2335.117.camel@rzhang-lenovo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, corentin.chary@gmail.com, Matthew Garrett <matthew.garrett@nebula.com>

On Thu, Aug 15, 2013 at 2:22 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E4=BA=8C, 2013-08-06 at 17:48 -0500, Felipe Contreras wrote:
>> Simple driver to enable control of the fan in ASUS laptops. So far t=
his
>> has only been tested in ASUS Zenbook Prime UX31A, but according to s=
ome
>> online reference [1], it should work in other models as well.
>>
> I'd rather prefer to do this in the vendor driver like asus-laptop.c.
> Say, it is the asus-laptop driver that knows the fan control ability =
of
> the platform and register to the thermal framework.

But asus-laptop doesn't work on this machine. I presume asus-wmi
wouldn't work on some other machines.

I think this is a completely different thing.

>> +static int fan_get_cur_state(struct thermal_cooling_device *cdev,
>> +             unsigned long *state)
>> +{
>> +     struct acpi_object_list params;
>> +     union acpi_object in_objs[1];
>> +     unsigned long long value;
>> +     acpi_status r;
>> +
>> +     params.count =3D ARRAY_SIZE(in_objs);
>> +     params.pointer =3D in_objs;
>> +     in_objs[0].type =3D ACPI_TYPE_INTEGER;
>> +     in_objs[0].integer.value =3D 0;
>> +
>> +     r =3D acpi_evaluate_integer(NULL, "\\_TZ.RFAN", &params, &valu=
e);
>> +     if (r !=3D AE_OK)
>> +             return r;
>> +
>> +     *state =3D value;
>> +
>> +     return 0;
>> +}
>> +
>> +static int fan_set(struct thermal_cooling_device *cdev, int fan, in=
t speed)
>> +{
>> +     struct acpi_object_list params;
>> +     union acpi_object in_objs[2];
>> +     unsigned long long value;
>> +
>> +     params.count =3D ARRAY_SIZE(in_objs);
>> +     params.pointer =3D in_objs;
>> +     in_objs[0].type =3D ACPI_TYPE_INTEGER;
>> +     in_objs[0].integer.value =3D fan;
>> +     in_objs[1].type =3D ACPI_TYPE_INTEGER;
>> +     in_objs[1].integer.value =3D speed;
>> +
>> +     return acpi_evaluate_integer(NULL, "\\_SB.PCI0.LPCB.EC0.SFNV",=
 &params, &value);
>> +}
>> +
> I checked a couple of BIOS, and it seems that both of these two metho=
ds
> can be invoked by ATKD.WMNB indirectly.
> So I'm wondering if it is proper to invoke these two methods directly=
,
> and if these are some features/functionalities that are still missing=
 in
> the asus-laptop driver.

I don't know what that means. From what I can see asus-laptop is not
meant to work on all ASUS laptops, and indeed it doesn't work on this
one.

--=20
=46elipe Contreras
