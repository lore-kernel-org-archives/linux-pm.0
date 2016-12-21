From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 21 Dec 2016 14:48:35 +1100
Message-ID: <878trarlgs.fsf@notabene.neil.brown.name>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com> <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJcXVammmYRkx+xHRoU9Bb10ck+S3L5VBknuKRXy=hGPA@mail.gmail.com> <87pokms19o.fsf@notabene.neil.brown.name> <CAMz4ku+Tqq4JrbbBBfUJSRs5Aw8s119HAQVaOcqZ-oCPXVV-7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbcLUDsz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 22:48:55 -0500
In-Reply-To: <CAMz4ku+Tqq4JrbbBBfUJSRs5Aw8s119HAQVaOcqZ-oCPXVV-7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Wed, Dec 21 2016, Baolin Wang wrote:

> Hi,
>
> On 21 December 2016 at 06:07, NeilBrown <neilb@suse.com> wrote:
>> On Tue, Dec 20 2016, Baolin Wang wrote:
>>
>>> Hi Neil,
>>>
>>> On 3 November 2016 at 09:25, NeilBrown <neilb@suse.com> wrote:
>>>> On Tue, Nov 01 2016, Baolin Wang wrote:
>>>>
>>>>
>>>>>> So I won't be responding on this topic any further until I see a genuine
>>>>>> attempt to understand and resolve the inconsistencies with
>>>>>> usb_register_notifier().
>>>>>
>>>>> Any better solution?
>>>>
>>>> I'm not sure exactly what you are asking, so I'll assume you are asking
>>>> the question I want to answer :-)
>>>>
>>>> 1/ Liase with the extcon developers to resolve the inconsistencies
>>>>   with USB connector types.
>>>>   e.g. current there is both "EXTCON_USB" and "EXTCON_CHG_USB_SDP"
>>>>   which both seem to suggest a standard downstream port.  There is no
>>>>   documentation describing how these relate, and no consistent practice
>>>>   to copy.
>>>>   I suspect the intention is that
>>>>     EXTCON_USB and EXTCON_USB_HOST indicated that data capabilities of
>>>>     the cable, while EXTCON_CHG_USB* indicate the power capabilities of
>>>>     the cable.
>>>>     So EXTCON_CHG_USB_SDP should always appear together with EXTCON_USB
>>>>     while EXTCON_CHG_USB_DCP would not, and EXTCON_CHG_USB_ACA
>>>>     would normally appear with EXTCON_USB_HOST (I think).
>>>>   Some drivers follow this model, particularly extcon-max14577.c
>>>>   but it is not consistent.
>>>>
>>>>   This policy should be well documented and possibly existing drivers
>>>>   should be updated to follow it.
>>>>
>>>>   At the same time it would make sense to resolve EXTCON_CHG_USB_SLOW
>>>>   and EXTCON_CHG_USB_FAST.  These names don't mean much.
>>>>   They were recently removed from drivers/power/axp288_charger.c
>>>>   which is good, but are still used in drivers/extcon/extcon-max*
>>>>   Possibly they should be changed to names from the standard, or
>>>>   possibly they should be renamed to identify the current they are
>>>>   expected to provide. e.g. EXTCON_CHG_USB_500MA and EXTCON_CHG_USB_1A
>>>
>>> Now I am creating the new patchset with fixing and converting exist drivers.
>>
>> Thanks!
>>
>>>
>>> I did some investigation about EXTCON subsystem. From your suggestion:
>>> 1. EXTCON_CHG_USB_SDP should always appear together with EXTCON_USB.
>>> ---- After checking, now all extcon drivers were following this rule.
>>
>> what about extcon-axp288.c ?
>> axp288_handle_chrg_det_event() sets or clears EXTCON_CHG_USB_SDP but
>> never sets EXTCON_USB.
>> Similarly phy-rockchip-inno-usb2.c never sets EXTCON_USB.
>
> Ha, sorry, I missed these 2 files, and I will fix them.
>
>>
>>>
>>> 2. EXTCON_CHG_USB_ACA would normally appear with EXTCON_USB_HOST.
>>> ---- Now no extcon drivers used EXTCON_CHG_USB_ACA, then no need to
>>> change.
>>
>> Agreed.
>>
>>>
>>> 3. Change EXTCON_CHG_USB_SLOW/FAST to EXTCON_CHG_USB_500MA/1A.
>>> ---- There are no model that shows the slow charger should be 500mA
>>> and fast charger is 1A. (In extcon-max77693.c file, the fast charger
>>> can be drawn 2A), so changing to EXTCON_CHG_USB_500MA/1A is not useful
>>> I think.
>>
>> Leaving the names a SLOW/FAST is less useful as those names don't *mean*
>> anything.
>> The only place where the cable types are registered are in
>>  extcon-max{14577,77693,77843,8997}.c
>>
>> In each case, the code strongly suggests that the meaning is that "slow"
>> means "500mA" and that "fast" means "1A" (or sometimes 1A-2A).
>>
>> With names like "fast" and "slow", any common changer framework cannot
>> make use of these cable types as the name doesn't mean anything.
>> If the names were changed to 500MA/1A, then common code could reasonably
>> assume how much current can safely be drawn from each.
>
> As I know, some fast charger can be drawn 5A, then do we need another
> macro named 5A? then will introduce more macros in future, I am not
> true this is helpful.

It isn't really a question of what the charger can provide.  It is a
question of what the cable reports to the phy.

Unfortunately I cannot find any datasheets on line to verify how these
devices work, but the code seems to suggest that they can detect and
report special charger types that provide 500mA and 1A respectively.
If the hardware exists that reports the functionality, it make sense to
use it.  Hopefully new hardware will follow the USB BC spec, so further
special cases won't be needed.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlhZ+5MACgkQOeye3VZi
gbnbdg//bGPhpUwBUMxkSQ6h5mfEsEnmZps3jdAHUCHtHOkeByq/eAQnXGQNZpo1
V5R/aVfNTIbbJ5rUraIe6Zq1yXhlS9D9DfpNRMjPWO0BZmwLWW46jeAquRMvdF0g
gT2qFTE8kcifxnoKuayaX2GIs5P6Rm1QNErl7jLzcqOOK0Ua14OaUpm65oc8oJB3
oEWOXmbYgn+/VWLtgj1yiE6PpEbHMUTXpXnM6e+vFHCfd7GaStgvdPZSDrGjB0DL
veR0mAQw3rl6HPaIE42P06mgeNtUgqeWOTML3RTUC0WedNteC+NJV8RnwQs1SUMx
1VMlN8vHHpTrkPgNrO4KXdyg0br972Tv1ecYzN7tPXccgTCxMK0fa3/P7no/MY3V
Ocfgu1Hl/91r5BhSZSXnF2dT7KGSqSDpzEeWYds8qREgfjsqm2vxRf/7/w35XByz
9acHCWeRU4CBvtbykyY1NtFjQPADOIwcDT+YDz9VKsGhGdvqMe02Vzvw2EYUX4t7
Fug+mN100+KsqNsiymaZI7rl71f+I/oeHLkHHDhNRSNJPYEyOoZHTGJqFSqkiZjp
kat8kNWt2owAwFETvW597lLCm6gNeRu9rtdYf0XeEX+BennF63hJHKO8aFOgKP/Z
bkEfEIIxayviMKqFlQjXvbfznQrwtB4FVJ50+s1Fd1dsAdTi8uk=
=m1Zm
-----END PGP SIGNATURE-----
--=-=-=--
