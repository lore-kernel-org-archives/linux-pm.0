From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Tue, 27 Sep 2016 13:46:13 +0200
Message-ID: <CAJZ5v0j3fJ7pDoR+LhY6x1T0yQEhq6omFL7-BrBcMy68eFiMMg@mail.gmail.com>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan> <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan> <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
 <CAJZ5v0iEchM2ye==020gLj2bZc3ddCFa29jQZh6c+9X+OhfcoQ@mail.gmail.com>
 <594f5012-5157-bfdd-f715-bea8caa824c3@lwfinger.net> <CAJZ5v0g++0JaPUEaQy54_fcA5tv5TuNZw+5mbmo47OY-dD8HoQ@mail.gmail.com>
 <e42f36f7-5bf4-fdc4-12a7-a2d6a645e82e@lwfinger.net> <CAJZ5v0hzRCqsE-Wg4aTPPF_+=o+io_P8M-D4_pu5qpDxaXAy5A@mail.gmail.com>
 <2326a7dd-675f-752b-f100-5dce6e4c93fd@lwfinger.net> <003001d2186d$02c34820$0849d860$@net>
 <785b1633-5f1d-7cfe-5a9f-cfbb82a4a754@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37246 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbcI0LqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 07:46:21 -0400
In-Reply-To: <785b1633-5f1d-7cfe-5a9f-cfbb82a4a754@lwfinger.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Sep 27, 2016 at 10:48 AM, Larry Finger
<Larry.Finger@lwfinger.net> wrote:
> On 09/26/2016 10:12 PM, Doug Smythies wrote:
>>
>> On 2016.09.26 18:31 Srinivas Pandruvada wrote:
>>>
>>> On Mon, 2016-09-26 at 19:48 -0500, Larry Finger wrote:
>>>>
>>>> On 09/26/2016 07:21 PM, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Tue, Sep 27, 2016 at 1:53 AM, Larry Finger wrote:
>>>>> But for both we need a reproducer anyway.
>>>>
>>>> I do not have a reliable reproducer. The condition has always
>>>> happened when
>>>> running a high-compute job such as a 'make -j8' on the kernel, or
>>>> building the
>>>> RPM for openSUSE's implementation of VirtualBox. The latter is what
>>>> I'm using
>>>> for most of my testing.
>>
>>
>> Run some CPU stressor and get all your CPU's going at 100% load.
>> And watch your core temperatures while you do so.
>
>
> for i in 1 2 3 4; do while : ; do : ; done & done
>
> triggered the fault in a few minutes.
>>
>>
>>>
>>>>> It also would be good to rule out the thermal throttling (as per
>>>>> the Srinivas' comments).
>>
>>
>> It is almost certainly thermal throttling, or similar causing
>> Clock modulation, of it seems 50%.
>
>
> While the infinite loops were running, the temps were:
>
> finger@linux-1t8h:~/rtlwifi_new> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +83.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 0:         +83.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 1:         +74.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)

It looks like the trip point (high) temperature was exceeded causing
thermal throttling to kick in.

> After the fault occurs, I get
>
> finger@linux-1t8h:~/rtlwifi_new> sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +44.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 0:         +43.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 1:         +41.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)

So after that it stays at 400 MHz forever, right?

>>>>>
>>>>> For now, please tell me what's in
>>>>> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
>>>>
>>>> 800000
>>>
>>> Your effective freq is lower than 800MHz. One of the possible reason is
>>> thermal throttling.
>>>
>>> What distro you are using?
>>
>>
>> And what make and model of LapTop?
>
>
> Toshiba Tecra A50-A with CPU Model: 6.60.3 "Intel(R) Core(TM) i7-4600M CP=
U @
> 2.90GHz. That is a dual-core unit with hyperthreading.
>
> @Rafael: As I write this, the system has been running the infinite loop t=
est
> for almost 5 hours with kernel 4.7. I will leave that running while I'm
> gone, but I am certain that it is OK.

OK, and what temperatures do you see while doing this?

Thanks,
Rafael
