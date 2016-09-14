From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 14 Sep 2016 16:11:58 +0200
Message-ID: <87r38mzi35.fsf@notabene.neil.brown.name>
References: <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <20160909110727.GI27946@sirena.org.uk> <87pooc7n3t.fsf@notabene.neil.brown.name> <20160912122549.GZ27946@sirena.org.uk> <87inu11c5l.fsf@notabene.neil.brown.name> <20160912152627.GA27946@sirena.org.uk> <877fag1b6r.fsf@notabene.neil.brown.name> <20160914111603.GU27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160914111603.GU27946@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Tue, Sep 13, 2016 at 10:00:28AM +0200, NeilBrown wrote:
>> On Mon, Sep 12 2016, Mark Brown wrote:
>
>> > That's not actually 100% clear to me - for what the wm831x is doing it
>> > probably *does* want the higher limit.  This is a system inflow limit
>> > (as it should be for this), at least the charger will adapt to voltage
>> > variations though other users in the system are much less likely to do
>> > so.
>
>> Not having very much electrical engineering background, I cannot say for
>> sure what will happen, but it seems likely that once the voltage drops
>> much below 4.75V, the charger won't be operating at peak efficiency,
>> which would be a waste.
>> I can easily imagine that the hardware would switch off at some voltage
>> level, rather than just making do with what is there.
>> So I'm skeptical of this approach, but I'm open to being corrected by
>> someone more knowledgeable than I.
>
> Yes, the idea is that the charger will back off charging and stop
> entirely if the rest of the system is consuming too much power to allow
> it to continue effectively.  The same thing happens with wall power, if
> a wall supply isn't able to power the charger (eg, because the rest of
> the system is running flat out) it'll have to cope with that.

Maybe you are correct.  I don't find your argument convincing, but maybe
that is because I don't want to...
Some facts though:
 1/ I had a report once from someone whose device stopped charging
   because it was pulling more current than the charger could supply.
   The voltage dropped below the 3.5V (I think) that the battery
   charging hardware needed, so it switched off.  It wouldn't switch
   back on again until explicitly told too.  It would then overload the
   charger again and switch off.
   Changing the code to put a lower limit on the current allowed the
   battery to be charged.  So empirical evidence suggests that the
   lower number should be used.

 2/ I hoped that
      Battery Charging Specification
      Revision 1.2
      December 7, 2010

    would say something definite, but I cannot find it.
    However,  "note 1" to "Table 5-2 Currents" says:
=20=20=20=20=20
        1) The maximum current is for safety reasons, as per USB 2.0 sectio=
n 7.2.1.2.1.
=20=20=20=20=20
    Which seems to say the maximum is just for safety, implying that the
    minimum is the important value.

 3/  Felipe Balbi <balbi@kernel.org>  appears to agree with my
   perspective.
      http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1224904.h=
tml
   does argument-by-authority work?


>
>> Looking at it from a different perspective, according to the patch set,
>> the limits that wm831x is able to impose are:
>
>>  +	0,
>>  +	2,
>>  +	100,
>>  +	500,
>>  +	900,
>>  +	1500,
>>  +	1800,
>>  +	550,
>
>> These are, from the battery charger spec, minimums rather than maximums.
>> e.g. a CDP provides at least 1500, and as much as 5000.  So it seems
>> that the wm831x was designed to be told the minimum guaranteed available.
>> But that is circumstantial evidence and might be misleading.
>
> AIUI this is conservatisim in the system design - another way of reading
> a spec with a range like this is that the consumer should aim for the
> lower limit, the provider should aim for the upper limit and that way if
> either of them has issues with tolerances things will still work out.
> It predates wide availability of CDP so I wouldn't be surprised if that
> bit were just an oversight.  Like I say this bit of hardware is totally
> separate to the battery charger.

Your last sentence is interesting .... I would reply "of course".
All the code we are talking about is only tangentially related to battery
charging.  It is about how much current can safely be pulled from a USB
port.  What that current is used for is a completely separate question.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2VquAAoJEDnsnt1WYoG5sqMP/2EOHzYXnk8qSaX1AyLUJRlk
7+NprCY29i8+rKuNmfZzfYOVtcoocSx3nam2akf34jiYyqMF896QKqNSZyQVoIN/
mo7gmMbkj0O9+dcg/uom2/A09jCh2NvsN33yY5Jw/bH5UNSAm/Q7euZhJuVqt4mt
UMNhohDxR8gw56ymE/RHY7fb6RR8LW8qSoVbFs/ixH1zhq0OstRH84Cuy7tU7Moq
fUGi4a3u81i5wkS6vYXC/fLHnJ1DE5RPauVqPOZ6DbkYGlhzUIw7rb0BRFfKnHUg
pKuBQTHzzfA2l7WcM0fYkm519oZKhzu9tNFMHUsSrXHO8WxkYBhNzyoEgTaC79uD
FidSNqUKIGCqAjQyEHvsa+cZTUuKGSP5gpr1JWt4d44uk03i/OpnshhVQP/pm/b/
SNacr8e8dQZ2tFqRsm+gw3krIG8vQRgYCLwfqB6ROWC+ahktdx3Qo5zrS8V9PQUn
zkJM4FO6ePzImVEUEM+hsc0Q+HWsycnb9F3vGZmoJQiHzaUoQo7a+eQp98CfDNwo
/F9Txa+wd9tRV6S7zA/PnBW7bhM3kLlcGta0sYdBO++SUX1o+eth0XtOGNr5nazb
KtF6f3YPJAq4UemJ3peIiwlWNUjZqGI7kYVALQVYMmf6yUd+ivuemZeEWcSYOWhc
w+FHxFon0YhviqRj86uo
=/Kic
-----END PGP SIGNATURE-----
--=-=-=--
