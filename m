From: NeilBrown <nfbrown@novell.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 06 Sep 2016 15:40:49 +1000
Message-ID: <8760q9a8m6.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:43157 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbcIFFlP (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Tue, 6 Sep 2016 01:41:15 -0400
In-Reply-To: <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Baolin Wang <baolin.wang@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>, "Bird, Timothy" <Tim.Bird@am.sony.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29 2016, Baolin Wang wrote:

> Hi Felipe,
>
> On 11 August 2016 at 11:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Hi Felipe,
>>
>> On 1 August 2016 at 15:09, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> Currently the Linux kernel does not provide any standard integration of=
 this
>>> feature that integrates the USB subsystem with the system power regulat=
ion
>>> provided by PMICs meaning that either vendors must add this in their ke=
rnels
>>> or USB gadget devices based on Linux (such as mobile phones) may not be=
have
>>> as they should. Thus provide a standard framework for doing this in ker=
nel.
>>>
>>> Now introduce one user with wm831x_power to support and test the usb ch=
arger,
>>> which is pending testing. Moreover there may be other potential users w=
ill use
>>> it in future.
>>
>> Could you please apply this patchset into your 'next' branch if you
>> have no comments about it? Thank you.
>
> Since there are no other comments about this patchset for a long time,
> could you please apply this patchset? Thanks.

Sorry, I should have replied earlier.  Tim Bird mentioned on the
ksummit-discuss list that there was a frustration with this not making
progress so I decided to contribute what I could now.

I think this patch set is attempting to address an important problem
that needs solving.  However I think it gets some key aspects wrong.
Maybe they can get fixed up after the patchset is upstream, maybe they
should be fixed first - I have no strong opinion on that.

My main complaints involve the detection and handling of the different
charger types - DCP, CDP, ACA etc.
The big-picture requirement here that the PHY will detect the physical
properties of the cable (e.g. resistance to ground on ID) and determine
the type of charger expected.  This information must be communicated to
the PMIC "power_supply" device so it can regulate the power being drawn
through the cable.

The first problem is that there are two different ways that the
distinction between DCP, CDP, ACA etc can be represented in Linux.  They
are cable types in the 'extcon' subsystem, and they are power_supply
types in the 'power_supply' subsystem.  This duplication is confusing.
It is not caused by your patch set, but I believe your patchset needs to
work with the duplication and I think it does so poorly.

In my mind, the power_supply should *not* know about this distinction at
all (except possibly as an advisor attribute simiarly to the current
battery technology attribute).  The other types it knows of are "AC",
"USB", and "BATTERY".  The contrast between these is quite different
From=20the contrast between DCP, CDP, ACA, which, from the perspective of
the power supply, are almost irrelevant.  Your patchset effectively
examines the power_supply_type of one power_supply, and communicates it
to another.  It isn't clear to me how the first power_supply gets the
information, or what the relationship between the two power_supplies is
meant to be.

It makes much more sense, to me, to utilized the knowledge of this
distinction that extcon provides.  A usb PHY can register an extcon,
declare the sorts of cables that it can detect, and tell the extcon as
cables appear or disappear.  The PMIC power_supply can then register with
that extcon for events and can find out when a cable is attached, and
what sort of cable.
Your usb-charging framework would be well placed to help the
power_supply to find the correct extcon, and possibly even to handle the
registration for events.

Your framework does currently register with extcon, but only listens for
EXTCON_USB cables.  I don't think that cable type is (reliably) reported
when a DCP (for example) is plugged in.

Here there is another problem that is not of your making, but still
needs fixing.  Extcon declares a number of cable types like:

/* USB external connector */
#define EXTCON_USB              1
#define EXTCON_USB_HOST         2

/* Charging external connector */
#define EXTCON_CHG_USB_SDP      5       /* Standard Downstream Port */
#define EXTCON_CHG_USB_DCP      6       /* Dedicated Charging Port */
#define EXTCON_CHG_USB_CDP      7       /* Charging Downstream Port */
#define EXTCON_CHG_USB_ACA      8       /* Accessory Charger Adapter */
#define EXTCON_CHG_USB_FAST     9
#define EXTCON_CHG_USB_SLOW     10

However it doesn't define what those mean, so we are left to guess.
They each correspond to bits in a bitmap, so a cable can have multiple type=
s.
I think the best interpretation is that:

 EXTCON_USB means that the cable carries USB data from a host.
 EXTCON_USB_HOST means that that cable carries USB data to a host.
 EXTCON_CHG_* means that power is available as described in the
 standards.
 (what EXTCON_CHG_USB_FAST and EXTCON_CHG_USB_SLOW mean is not at all
 clear).

There is some support for this in the code, but it is not universally
acknowledged.  For a USB charging framework to be genuinely useful, it
must (I think) make sure this issue gets clarified, and the various
cable types used properly.

Once the cable/charger type has been determined, the PMIC power_supply
needs to use this information.  Your current patches make use of this
information in ways that are wrong in two respects.

Firstly, you have made the current limit associated with each cable type
configurable (__usb_charger_set_cur_limit_by_type).   This is nonsense.
The standard (e.g. BC-1.2) declares what the current limits are.  There
is no reason for those not to be hard coded.

Secondly, you treat each charger type as having a single "cur_limit" and
utilize that limit by telling the PMIC to draw that much current.
Again, this is inconsistent with the specification.
BC-1.2 defines, for each charger type, a minimum and maximum current
level.
The minimum should always be available.   Attempting to draw more than
that (but less that the max) might work or might cause the charger
to shut down, but you can be sure that the charger will respond to the
increased load by first reducing the voltage, and will not shut down
until the voltage has dropped below 2V.
If you try to draw more current than the maximum, then the charger might
shut down before the voltage drops below 2V.

Given this understanding of the current available from the charger,
there are two approaches the PMIC might take.
1/ if the PMIC is able to exercise fine control over the current it
  draws, and if it can monitor the voltage on the charger, then it
  could gradually increase the power being requested until the voltage
  drops below some threshold (e.g. 4.75V), and then (probably) back off
  a little.  It should only increase at most up to the maximum, even if
  the voltage remains high.  It should probably start at zero rather
  than at the minimum.  This allows for lossage elsewhere.

2/ If the PMIC cannot measure voltage, or doesn't have sufficiently fine
   control of the current requested, then it should request only the
   minimum available current.  Any more is not safe.

So your USB charging framework should communicate the MIN and MAX as
specified in the standard, and allow the PMIC to use that information as
appropriate.
A library routine to support the incremental increase in current drain
would probably be appreciated by PMIC driver writers.


A more details discussion of this problem-space can be found at
   https://lwn.net/Articles/693027/
and an analysis of the functionality currently available in the kernel
(which adds a number of specifics to the above) can be found at
   https://lwn.net/Articles/694062/

NeilBrown



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXzlbhAAoJEDnsnt1WYoG5kAwP/RESKKG7HTS5tX5qq9Ax+HLt
wkicRXxDYUi83MGXrPW7TJJW+uNdAs/Yw4179jZl7So/iKHVKVsXX9r3c20BaCeg
S5/P9kxtorImgpaQUpqqYC4zmRMcdrTRb9Y2o1cim1zqrSUNGWrIT5n+vRKiYqK8
1TNREfLXfLIyhbS7TunRFYKJ2DEryuWflkRFhhsI6Bw/E+JnZMz1VSN2PHKY5KuL
I6ZOpVI/Y8VKzJ/l+c93RU7Vzw2O0xshYRLuqbUTHRHx3XlO0W7TOLLPXfm+5O0k
iD9Zs/Gl8/xYbSIqsRPBCbQutbgAev6hoNt5AMFpAG/pNyFRECVJBVAznBcFGPE6
6EOCCN4346rPNx2mb+IVzJmBHLbZzl35xS853SaCkjhyVsIdhMISKYe2j31XUoLE
CkcflUCMJONw/6JohTEDp9i22NoAIasaEPdkS8P8qWw7ih8deaVXWKpxCwgQfZor
/xd1YBbzFgXsWNCwskYadSt9kssBtyUoCtLMXgP9baJYzHBUy8HlaYbnCYpG6egH
fNQxcV/6n0l6qHxT3FVDMhvKbKzmw3+I9UsKnVgPLB+shbgNOQIKjIksiaoJ7M9o
KrQW2SREyOFrfBBR8BayejqhXzij5jk1nuTwsMrYNOZM/65IwfsBHzUpnzXfTUy/
catYe/duocZLixBb8c92
=71uu
-----END PGP SIGNATURE-----
--=-=-=--
