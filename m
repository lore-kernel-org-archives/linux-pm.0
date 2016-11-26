From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Sat, 26 Nov 2016 11:44:46 +1100
Message-ID: <87bmx39iip.fsf@notabene.neil.brown.name>
References: <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com> <87a8dbni27.fsf@notabene.neil.brown.name> <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com> <87eg2ek7ye.fsf@notabene.neil.brown.name> <20161114120430.hpnetdedyofhlkad@sirena.org.uk> <87mvh1iw32.fsf@notabene.neil.brown.name> <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk> <87fumqhadm.fsf@notabene.neil.brown.name> <20161121171712.wo2qsnnqnnsnej26@sirena.org.uk> <87y40ccv94.fsf@notabene.neil.brown.name> <20161125130035.xf57xe5ajx6zfnqq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51183 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbcKZApH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Nov 2016 19:45:07 -0500
In-Reply-To: <20161125130035.xf57xe5ajx6zfnqq@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>

--=-=-=
Content-Type: text/plain

On Sat, Nov 26 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Tue, Nov 22, 2016 at 09:40:07AM +1100, NeilBrown wrote:
>
>> I agree that the question of where the responsibility for information
>> aggregation lies is open for discussion. If fact all details on how
>> things should work are always open for discussion.
>> I don't agree that this is the main different between our positions,
>> though I can see how you might get that impression.
>
>> You could even fix them so they look *exactly* like the notifiers that
>> Baolin is proposing.  This is my key point.  It is not the end result
>> that I particularly object to (though I do object to some details).  It
>
> Ah, OK.  This really hadn't been at all clear - both Baolin and I had
> the impression that the it was both that were blockers for you.  What
> were the details here?

I don't really like the idea of a separate "usb charger" object.  It
looks too much like a "midlayer" and they tend to get in the way.  But
if a convincing case could be made that changing from the current design
to that aspect of the proposed design brings measurable benefits, then I
would certainly assess that case on its merits.  No such case was made,
and the patchset didn't seem to even acknowledge the existing design.

When I said "I do object to some details" it was details of the end
result, not details of what took responsibility of information
aggregation (in case that wasn't clear).  Those details were everything
that duplicated existing functionality, or ignored existing
functionality, or was simply unworkable.  e.g. the lack of proper
integration with extcon, the new sysfs attributes, the name-lookup
mechanism.  Probably others.

>
>> is the process of getting to the end result that I don't like.  If the
>> current system doesn't work and something different is needed, then the
>> correct thing to do is to transform the existing system into something
>> new that works better.  This should be a clear series of steps.  Each
>
> Sometimes there's something to be said for working out what we want
> things to look like before setting out to make these gradual
> refactorings and sometimes the refactorings are just more pain than
> they're worth, especially when they go across subsystems.  In this case
> I do worry about the cross subsystem aspect causing hassle, it may be
> more practical to do anything that represents an interface change by
> adding the new interface, converting the users to it and then removing
> the old interface.

Yes, you need a clear vision of the goal.  You also need a clear vision
of the starting point. There was no evidence of the latter.
Yes, sometimes you need to create a new thing and transition users over,
then discard the old.  There was no discarding of the old.

>
> At the very least the series should grow to incorporate conversion of
> the existing users though.  Baolin, I think this does need adding to the
> series but probably best to think about how to do it - some of Neil's
> suggestions for incremental steps do seem like they should be useful
> for organizing things here, probably we can get some things that can be
> done internally within individual drivers merged while everything else
> is under discussion.

I would be very encouraged to see those simple things done first!
Seeing the series grow isn't much fun, but seeing preliminary work land
certainly is.

>
>> But I think here my key point got lost too, in part because it was hard
>> to refer to an actual instance.
>> My point was that in the present patch set, the "usb charger" is given
>> a name which is dependant on discovery order, and only supports
>> lookup-by-name.  This cannot work.
>
> There's two bits here: one is the way names are assigned and the other
> is the lookup by name.  I agree that the lookup by name isn't
> particularly useful as things stand, that could just be dropped until
> some naming mechanism is added.  We'd be more likely to use phandles in
> DT systems, I don't know what ACPI systems would look like but I guess
> it'd be something similar.
>
>> If they supported lookup by phy-name or lookup-by-active (i.e. "find me
>> any usb-charger which has power available"), or look up by some other
>> attribute, then discover-order naming could work.  But the only
>> lookup-mechanism is by-name, and the names aren't reliably stable.  So
>> the name/lookup system proposed cannot possibly do anything useful
>> with more than one usb_charger.
>
> Baolin, I think adding a DT binding and lookup mechanism makes sense
> here - do you agree?

We already have a lookup mechanism for a battery charger to find the phy
that it gets current from: devm_usb_get_phy_by_phandle() (or even
devm_usb_get_phy() if there is known to only be one phy).  We would need
a case to be made that the existing mechanism cannot be used before we
consider "adding a DT binding and lookup mechanism".

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlg42v8ACgkQOeye3VZi
gbmcJA//Xk9fxXpx8fUlFk/BnV+QkNN5a/d54wykywCx9hhDHTDpL+EPmzmRMISB
zX0n0SX2uBOxoXsy/oNQqepV0RBGhoZh/dxN9E1JEFmjJcW07yK72rJrLfhPq9sy
1B5YkR51d1tkh7zwW3Bym7mAR4fq3PHPQ1Dz0hTuteRMPiOWIdqKsMzxS/iKBYBx
FTQxTNeceBGuZLAMqEpRp4ugyMb9KaTxt4/LpNJNv5zwESwhtgdozOsOVe9GSvzD
AXRLecywjtfmxdCZ1Ylf5U/sMyHx+8KXfBQLBvWvmuYJO6JK2ugbewAcOoXDU9EB
2YmpKm1JYqGfU8v9nGKZ6I9QbhwFeUpX3IotSeYJjqJtb6vVJV37xFCuvOaPg82C
Fk7TU/hhV3wF7b8EwV8iFxUucQ+K4YlV5JfC8YPrS05ZXJ53xEHi3ipaoW9Ulg0x
E2qPTkP0IXFtRawwJwqdVFRiS1IFE/FgLOVKTjRWOZXhzlTwKhyg204YYqjkFlqv
xVEJ8QtLkyNoq5qGKZy68ATKMM8Aj2hlWhQ4t/6WK2HeVZbflp1cAToBmVuTVxxm
kJ9Iirmu11T8NxjW0CnWZrQfqUJL07ek4ZuN8TqUWbgt7l0qtSCuF64R17dpAP2v
fPXcNmNQYWDLkT1ARd8ZunULhMoxQ+VCBVNzBvuapLX2nOu5Q/U=
=/jpI
-----END PGP SIGNATURE-----
--=-=-=--
