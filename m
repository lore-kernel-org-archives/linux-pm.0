From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 05 Oct 2016 21:44:39 +1100
Message-ID: <87a8ej9iso.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <CAMz4ku+wWcSPCA1_UYKNqJv4rRDEm5WYUc8AVT6xPJ651-rzmg@mail.gmail.com> <87twdo7ouz.fsf@notabene.neil.brown.name> <CAMz4kuLXyLK2jFmaoxxceq01FT4fo+N-iAtCLPyQzJh5R24uOw@mail.gmail.com> <CAMz4kuLHEv16yBDxW=peVyPB3_K27QUDyKHT0ecBZxAQR-2VXA@mail.gmail.com> <878tu3p78u.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbcJEKpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 06:45:11 -0400
In-Reply-To: <878tu3p78u.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.orgL

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05 2016, Felipe Balbi wrote:

> Hi Baolin,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>>>> But you do!
>>>> The mA number from the USB configuration is passed to usb_gadget_vbus_=
draw.
>>>> Your patch passes that to usb_charger_set_cur_limit_by_type()
>>>> which calls __usb_charger_set_cur_limit_by_type() which will set the
>>>> cur_limit for whichever type uchger->type currently is.
>>>>
>>>> So when it is not relevant, your code *does* set some current limit.
>>>
>>> Suppose the charger type is DCP(it is not relevant to the mA number
>>> from the USB configuration ), it will not do the USB enumeration, then
>>> no USB configuration from host to set current.
>>
>> From the talking, there are some issues (thanks for Neil's comments)
>> need to be fixed as below:
>> 1. Need to add the method getting charger type from extcon subsystem.
>> 2. Need to remove the method getting charger type from power supply.
>> 3. There are still some different views about reporting the maximum
>> current or minimum current to power driver.
>>
>> Now the current v16 patchset can work well on my Spreadtrum platform
>> and Jun's NXP platform, if you like to apply this patchset then I can

I'm really curious how much testing this has had.  Have you actually
plugged in different cable types (SDP DCP DCP ACA) and has each one been
detected correctly?  Because I cannot see how that could happen with the
code you have posted.

>> send out new patches to fix above issues. If you don't like that, I
>> can send out new version patchset to fix above issues. Could you  give
>> me some suggestions what should I do next step? Thanks.
>
> Merge window just opened, nothing will happen for about 2 weeks. How
> about you send a new version after merge window closes and we go from
> there? Fixing 1 and 2 is needed. 3 we need to consider more
> carefully. Perhaps report both minimum and maximum somehow?
>
> Neil, comments?

This probably seems a bit harsh, but I really think the current patchset
should be discarded and the the project started again with a clear
vision of what is required.  What we currently have is too confused.

To respond to the points:
>> 1. Need to add the method getting charger type from extcon subsystem.

Yes.  This should be the only way to get the charger type.

>> 2. Need to remove the method getting charger type from power supply.

Also need to remove the ->get_charger_type() method as there is no
credible use-case for this.

>> 3. There are still some different views about reporting the maximum
>> current or minimum current to power driver.

I think those were resolved.  There was some confusion over whether a
particular power manager wanted to be told the maximum or the minimum,
but I think both have a clear use case in different hardware.

Also: We don't want another notifier_chain.  The usb_notifier combined
with the extcon notifier are sufficient.  Possibly it would be sensible
to replace the usb notifier with a new new notifier chain, but don't add
something without first cleaning up what is there.

Also: resolve the question of whether it could ever make sense to have
 more than one "usb_charger" in a system.  If it doesn't, make it an
 obvious singleton.  If it does, make it clear how the correct
 usb_charger is chosen.

Also: think very carefully before exposing any details through sysfs.
  Some of the details are already visible, either in sys/class/extcon
  or sys/class/power_supply.  Don't duplicate without good reason.


NeilBrown



>
> --=20
> balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX9NmXAAoJEDnsnt1WYoG5HAMQAKCZypvbj8J3FubAT/rKCmSq
d3sysnDDI/tHl7ohNNc+U4r4eFeV98NTHq2S2qGzBghGHtjyVIsWNXF6Z6MMtmpx
dm4qV+Y6KOCyGciBngg8XpZVLPP4U5sW43Coq+iexKh2qq9GYx3OF1WzzwQigqWk
VEnrxSmO87QVzeaOMJgAwY5dLDtdfeAs18A7gpDWJZrm92Zg89Xy1OY+M1yUh9Tj
3Pnnt4ENsERwUvit5nLGsa+EbcAly1/Ki4AiT6dj9XvqyR7l8InTM3tvXWzACN6Q
5t/gIJXAX3ZwDfMgAM3GGLvuM3kionNOr1Fp0vuf5ACXFitFqIIMgGJRAoURlUtw
uzTI7/WR6EkfIykAknPOc6DYpuXgac8i8D/R+EZ6AWOSjcfBeoE89EbOLxHf3/Gc
NeoB5npsfTe3EFTEPTtgFqjAoZQoyP+Ty0ZU0zKcmH5dPLEsE98D8qXPoaD2wRnu
L4Ao3VbOHyXxpa3jpY7+WjAswZZxK6RY1I6wqN1tn0tzJ1dlO2wvLR3vWvb9f2SB
PftHb8jz7JtjoEQ4cNSgnPgJ4VcsXuKB6acy9w7osZMO16PIt7O4FcI7VC0lVMNe
1U0GoxvI9nYzvOjNDgN+SVGQA8Q5xDfCJQanqk/S9GQXYdRcfmGLu8/IiW/2u9uZ
7cmmCmZrgjbiskCN9YiD
=fM4D
-----END PGP SIGNATURE-----
--=-=-=--
