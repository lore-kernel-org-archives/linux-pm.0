From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 22 Nov 2016 09:40:07 +1100
Message-ID: <87y40ccv94.fsf@notabene.neil.brown.name>
References: <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com> <87a8dbni27.fsf@notabene.neil.brown.name> <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com> <87eg2ek7ye.fsf@notabene.neil.brown.name> <20161114120430.hpnetdedyofhlkad@sirena.org.uk> <87mvh1iw32.fsf@notabene.neil.brown.name> <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk> <87fumqhadm.fsf@notabene.neil.brown.name> <20161121171712.wo2qsnnqnnsnej26@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754583AbcKUWlH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 17:41:07 -0500
In-Reply-To: <20161121171712.wo2qsnnqnnsnej26@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>

--=-=-=
Content-Type: text/plain

On Tue, Nov 22 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Thu, Nov 17, 2016 at 05:46:13PM +1100, NeilBrown wrote:
>> On Thu, Nov 17 2016, Mark Brown wrote:
>
>> > To me that's pretty much what's being done here, the code just happens
>> > to sit in USB instead but fundamentally it's just a blob of helper code,
>> > you could replace the notifier with a callback if that's the big concern
>> > here.
>
>> It is a lot more than "just a blob of helper code".  It duplicates
>> existing infrastructure instead of fixing and using the
>> infrastructure.... but I've said all this before.  Repeatedly.
>
> My read on that is that the question of what we want to be responsible
> for aggregating the information about what power the system is allowed
> to draw from a given USB port hasn't been resolved yet and that apart
> from that you're fairly close.  It seems to me like that's really what
> the difference between your two positions is.  Fixing the existing
> notifiers implies that things have to be aggregated in the power supply
> drivers but Baolin is proposing doing that in the USB code instead.  It
> does seem at least worth considering if that's a good idea since the
> current situation doesn't look terribly thought through.

I agree that the question of where the responsibility for information
aggregation lies is open for discussion. If fact all details on how
things should work are always open for discussion.
I don't agree that this is the main different between our positions,
though I can see how you might get that impression.

I don't agree that "Fixing the existing notifiers implies that things
have to be aggregated in the power supply drivers".  That would be the
simplest way to fix them, but not the only way.  You could fix them so
that the usb driver sends notifications instead of the phy, and you
could fix them so that the information contained in the notification
being a power range instead the current ad-hoc inconsistent set of
information.

You could even fix them so they look *exactly* like the notifiers that
Baolin is proposing.  This is my key point.  It is not the end result
that I particularly object to (though I do object to some details).  It
is the process of getting to the end result that I don't like.  If the
current system doesn't work and something different is needed, then the
correct thing to do is to transform the existing system into something
new that works better.  This should be a clear series of steps.  Each
one makes a small, well defined, change.  Maybe it adds a new feature.
Maybe it refactors code without changing functionality.  Maybe it fixes a
bug.  Maybe it moves the responsibility for an action from *here* to
*there*.  Each step is clearly explained and convincingly justified.
This doesn't have to be a long justification.  Sometimes a single
sentence or a short paragraph is plenty.  Sometimes the change is so
obviously an improvement that no explanation is necessary.

Changing one step at a time make it easier to ensure that no
functionality is lost and that each change is actually needed.

If the patch series fixed the existing code and transformed it into
something better and more powerful, then it would be a lot easier to
have sensible discussions about individual patches, about which there
might be disagreement.

>
> There are a whole bunch of things that need to be sorted out whatever
> the decision is like the extcon related cleanups you mentioned in your
> mail the other day (steps 1 and 2), it seems like those could be moved
> forwards independently.

Agreed.

>
> By the way it occurred to me recently that we have a use case for
> multiple USB ports that could supply power - USB C.  Things with more
> than one port like things in a laptop form factor are going to want to
> be able to use all of them interchangably for power support (likely only
> one at a time, at least initially, but still more than one port).

Thanks!  It is so much easier to discusses these sorts of things where
there is a concrete reference point.

I wonder if each port would have its own current regulator, or if there
would be a single central one.  Maybe there would be a switch that
allowed power to flow in only from one port.
Would each "charger" need to get notifications from "its" port, or would
there be a single "charger" which got notifications from the
power-switch, which in-turn got notifications from each port?
Or would the battery-charger driver want to register with every port,
receive notifications, and be able to turn each one on or off?
Without concrete details of actual hardware, we can only guess.

But I think here my key point got lost too, in part because it was hard
to refer to an actual instance.
My point was that in the present patch set, the "usb charger" is given
a name which is dependant on discovery order, and only supports
lookup-by-name.  This cannot work.
If each USB-C port registers a usb_charger, they would be
"usb-charger.0", "usb-charger.1", "usb-charger.2", with no reliable
correlation between name and physical location.
If they supported lookup by phy-name or lookup-by-active (i.e. "find me
any usb-charger which has power available"), or look up by some other
attribute, then discover-order naming could work.  But the only
lookup-mechanism is by-name, and the names aren't reliably stable.  So
the name/lookup system proposed cannot possibly do anything useful
with more than one usb_charger.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYM3fHAAoJEDnsnt1WYoG5hGgP/0vQHtjOvUO4Y7ZfTc95jlmW
fySYQoYCiuLNZG8btHjccCU24uPSPh4O9tgn8reeIarB6IKJvkuQW6WQQtOI6Ayx
gTVosSYOVLdwArMXh1d0G/93n8lVD0IgmfZtwaIpHcn2L5/oSlnBRImkrchXTFgx
7bC6mQtoIcKcCPmuMSPFRxdNFHgWBNORcan4JyrkBH7QZu3Cx18yB3RTcIf0+vc5
TqPyKQoECihBSEvPW6eh4ejN0s+fcr8Tcs2on1p8tjyGaYrwLsFG8qjn+G2BjEGK
rPDiDyh/s56Eqz8rVLRx0j/ZUTe7JOCaNmlD1k9NIUmuy3OuOznBOw9rcsSFa9NE
7SmctVwqRWD5CqqG/xGfWP7FDqM9WlMGcD+11IJfs2fBCgReRdSZwgTJWoBjnpk5
1Mt074gUqd7/860flXQv7U1WSXe9dRCKSpJrCrUTXmB27K13fAoujKqansq/OFEz
H58YIiidAla+vaGHzfYJ6zfPqEfyv5y9OeQNx70mc1RAHnoUrzBLGn8zRK/RxsBy
wbyHBfaftzX/8SaA1ooy0givBw2hLsINmfdRKEPLfcy6d882+DjrmRBjqRovjP7B
52f++TL/rdVkuJNKnzSw30esbCJQUQ3eqLK8ukJLbhxs1kbtBbU87ogXGAugkiXH
p+b+w6Soe0F9otuu4Ht7
=IZmp
-----END PGP SIGNATURE-----
--=-=-=--
