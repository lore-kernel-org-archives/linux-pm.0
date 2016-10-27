From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Fri, 28 Oct 2016 09:00:36 +1100
Message-ID: <87k2cttptn.fsf@notabene.neil.brown.name>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53953 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942164AbcJ0WBC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Oct 2016 18:01:02 -0400
In-Reply-To: <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Thu, Oct 27 2016, Baolin Wang wrote:

> Hi Felipe,
>
> On 19 October 2016 at 10:37, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Currently the Linux kernel does not provide any standard integration of this
>> feature that integrates the USB subsystem with the system power regulation
>> provided by PMICs meaning that either vendors must add this in their kernels
>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>> as they should. Thus provide a standard framework for doing this in kernel.
>>
>> Now introduce one user with wm831x_power to support and test the usb charger,
>> which is pending testing. Moreover there may be other potential users will use
>> it in future.
>>
>> Changes since v17:
>>  - Remove goto section in usb_charger_register() function.
>>  - Remove 'extern' in charger.h file.
>>  - Move the kfree() to usb_charger_exit() function.
>>
>> Changes since v16:
>>  - Modify the charger current range with introducing the maximum and minimum
>>  current.
>>  - Remove the getting charger type method from power supply.
>>  - Add the getting charger type method from extcon system.
>>  - Introduce new usb_charger_get_current() API for users to get the maximum and
>>  minimum current.
>>  - Rename some APIs and other optimization.
>>
>> Changes since v15:
>>  - Add charger state checking to avoid sending out duplicate notifies to users.
>>  - Add one work to notify power users the current has been changed.
>>
>> Changes since v14:
>>  - Add kernel documentation for struct usb_cahrger.
>>  - Remove some redundant WARN() functions.
>>
>> Changes since v13:
>>  - Remove the charger checking in usb_gadget_vbus_draw() function.
>>  - Rename some functions in charger.c file.
>>  - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tags/usb-for-v4.8
>>
>> Changes since v12:
>>  - Remove the class and device things.
>>  - Link usb charger to udc-core.ko.
>>  - Create one "charger" subdirectory which holds all charger-related attributes.
>>
>> Changes since v11:
>>  - Reviewed and tested by Li Jun.
>>
>> Changes since v10:
>>  - Introduce usb_charger_get_state() function to check charger state.
>>  - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
>>  in case will be issued in atomic context.
>
> Could you apply this patchset into your branch if there are no other
> comments? Thanks.

Some of my previous comments are still outstanding.  You seem to have
just brushed them off without apparently understanding.
And no-one else seems to care enough to try to bridge the gap...

Let me try again.

1/ I think we agreed that it doesn't make sense for there to be
 two chargers registered in a system.
 However usb_charger_register() still allows that, and assigns
 and arbitrary name to each based on discovery order.
 This *cannot* make sense.

2/ Why do you have usb_charger_set_current()??
  No code ever calls it.
  This updates the min and max current which are defined in a
  standard.  It never makes sense to change the min and max
  for a particular cable type.

3/ usb_charger_notify_state() does nothing if the state doesn't change.
  When the extcon detects an SDP, it will be called to set the state
  to USB_CHARGER_PRESENT.  The value of cur.sdp_max will be whatever
  it happened to be before, which is probably wrong.
  When after USB negotiation completes,
  usb_charger_set_cur_limit_by_gadget()
  will call into usb_charger_notify_state() to set USB_CHARGER_PRESENT
  again, but with a new current.  This will be ignored, as the state is
  already USB_CHARGER_PRESENT.

 (as an aside
 +enum usb_charger_state {
 +	USB_CHARGER_DEFAULT,
 +	USB_CHARGER_PRESENT,
 +	USB_CHARGER_REMOVE,
 +};

 looks odd.  It should probably by
    USB_CHARGER_UNKNOWN
    USB_CHARGER_PRESENT
    USB_CHARGER_ABSENT

 "REMOVE" isn't a state.  "REMOVED" might be.
 )

4/ I still strongly object to the ->get_charger_type() interface.
 You previously said:

     No. User can implement the get_charger_type() method to access the
     PMIC registers to get the charger type, which is one very common method.

 I suggest that if the PMIC registers report the charger type, then the
 PMIC driver should register an EXTCON and report the charger type
 through that.  Then the information would be directly available to
 user-space, and the usb-charger framework would have a single uniform
 mechanism for being told the cable type.

 Related:  I don't like charger_type_show().  I don't think
 the usb-charger should export that information to user-space because
 extcon already does that, and duplication is confusing and pointless.

 And I just noticed you have a ->charger_detect() too, which seems
 identical to ->get_charger_type().  There is no documentation
 explaining the difference.

5/ There is no convincing example usage of this framework.
  wm8931x_power.c just scratches the surface.
  If it is so good, it should be easy to convert a lot of other
  drivers over to it.  If you did that it would be much easier
  to see how it works and what the strengths/weaknesses were.


NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYEnkFAAoJEDnsnt1WYoG5fxQP/0az6Vy+c2uh8OF8NVnK4/OQ
pP18vqU+pM/F8BSCfkKV5ehjGoyddY1rirPCJlBFLtld2Nt6fu0Obaf7m7S8d3MX
AN8Z52DrOTWxdGvMtr7nnzQS5BCKIevCq0HMoJ26mGCrlvYgE/VnZO2ejFeDoWcp
ueK/GXn6N36leaaBn2FL3T3j0QpWZJJ7oOmDqFCGz7l9+P2+7LFksC8jDOtyWMki
l0exXl3SXL8qwjaYSZQ9KDuUY5hAsQPqF1CYlBfwsHK4jevlHLhyaY9rheQDuugM
k/V/5vm+hwc5Gb9K4wGX0IT7yUnlawssyGygfkkEBVUC4gIWyM6C7Q3MZghSuNir
fTYyrDV46ptQlU9o3BGEMq9wdVJskshM/wJVJR28sf2ZRNvQXGDcaTR5tA40bMkt
SaSZufLktS5VwVphcw76NPP0oRE7W/Ibpf7pk3kX0GLNxp+FpCejJ8Cq/UtlJDg1
IkQZ8cayYgPAnK1TBRKANdUi58beG1V6Z+Jd5+EQDxMi3HiO3eBT8+Dl5Uo1oA5K
iCHmlJcI7l+8xsDWb6VfQ+q2GCbMJ3/fQdP5eE3uLdQeVhf5bpW6oznxgraGG/6H
61zzm9ZS+8hyLhVlh+nOz8cc0gXXTGvMysd8g2tIIRmQkIB4f6MTE1/gB/SRYJB2
FFd1ULMLKBwhdw6wGGPb
=BXKz
-----END PGP SIGNATURE-----
--=-=-=--
