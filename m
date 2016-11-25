From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Fri, 25 Nov 2016 13:00:35 +0000
Message-ID: <20161125130035.xf57xe5ajx6zfnqq@sirena.org.uk>
References: <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
 <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
 <87eg2ek7ye.fsf@notabene.neil.brown.name>
 <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
 <87mvh1iw32.fsf@notabene.neil.brown.name>
 <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk>
 <87fumqhadm.fsf@notabene.neil.brown.name>
 <20161121171712.wo2qsnnqnnsnej26@sirena.org.uk>
 <87y40ccv94.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oucud47wnig4mqbi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44186 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbcKYNBZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 08:01:25 -0500
Content-Disposition: inline
In-Reply-To: <87y40ccv94.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>


--oucud47wnig4mqbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2016 at 09:40:07AM +1100, NeilBrown wrote:

> I agree that the question of where the responsibility for information
> aggregation lies is open for discussion. If fact all details on how
> things should work are always open for discussion.
> I don't agree that this is the main different between our positions,
> though I can see how you might get that impression.

> You could even fix them so they look *exactly* like the notifiers that
> Baolin is proposing.  This is my key point.  It is not the end result
> that I particularly object to (though I do object to some details).  It

Ah, OK.  This really hadn't been at all clear - both Baolin and I had
the impression that the it was both that were blockers for you.  What
were the details here?

> is the process of getting to the end result that I don't like.  If the
> current system doesn't work and something different is needed, then the
> correct thing to do is to transform the existing system into something
> new that works better.  This should be a clear series of steps.  Each

Sometimes there's something to be said for working out what we want
things to look like before setting out to make these gradual
refactorings and sometimes the refactorings are just more pain than
they're worth, especially when they go across subsystems.  In this case
I do worry about the cross subsystem aspect causing hassle, it may be
more practical to do anything that represents an interface change by
adding the new interface, converting the users to it and then removing
the old interface.

At the very least the series should grow to incorporate conversion of
the existing users though.  Baolin, I think this does need adding to the
series but probably best to think about how to do it - some of Neil's
suggestions for incremental steps do seem like they should be useful
for organizing things here, probably we can get some things that can be
done internally within individual drivers merged while everything else
is under discussion.

> But I think here my key point got lost too, in part because it was hard
> to refer to an actual instance.
> My point was that in the present patch set, the "usb charger" is given
> a name which is dependant on discovery order, and only supports
> lookup-by-name.  This cannot work.

There's two bits here: one is the way names are assigned and the other
is the lookup by name.  I agree that the lookup by name isn't
particularly useful as things stand, that could just be dropped until
some naming mechanism is added.  We'd be more likely to use phandles in
DT systems, I don't know what ACPI systems would look like but I guess
it'd be something similar.

> If they supported lookup by phy-name or lookup-by-active (i.e. "find me
> any usb-charger which has power available"), or look up by some other
> attribute, then discover-order naming could work.  But the only
> lookup-mechanism is by-name, and the names aren't reliably stable.  So
> the name/lookup system proposed cannot possibly do anything useful
> with more than one usb_charger.

Baolin, I think adding a DT binding and lookup mechanism makes sense
here - do you agree?

--oucud47wnig4mqbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYODXvAAoJECTWi3JdVIfQbEIH/1Uq7KErVYfQuSD2rujLvjXG
vo1rtY9RAfyFoSAPxyGRteKh2tcuUYeOPYAEIMbb7vV+ZdoMF3u13zUsfbf5FAKK
TcQDpr67yLhL+cDEKMk/P60ezDDCh0xWG246ymJ5DvImXFp+3JrFTUsyZDglVSKd
0NTae6Yk5bUjO/CRh5puyy3lUsvjodZhrfpel92LYUKeMuBWg4VwgHlhejSz546m
E5e/HqCM53zLeccrR/16H5drDXOXjF0FqcL+i5W8F+4s+wMUwTHLVFST0oAtxhBk
rsU//1XWrl33Ma4qLbDcy5aUveyonBXSqwGGOZnwTx+FWD5wnhwTWFHUQJYQ1OE=
=cl0H
-----END PGP SIGNATURE-----

--oucud47wnig4mqbi--
