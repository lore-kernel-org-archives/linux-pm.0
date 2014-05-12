From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Mon, 12 May 2014 13:17:29 +0100
Message-ID: <20140512121729.GC12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <536D0AF4.1040705@arm.com>
 <20140509175005.GT12304@sirena.org.uk>
 <536D2533.6050100@arm.com>
 <20140509192921.GY12304@sirena.org.uk>
 <5370877C.40409@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qqIUvgzkb/SUnfPt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42016 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaELMRz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 08:17:55 -0400
Content-Disposition: inline
In-Reply-To: <5370877C.40409@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--qqIUvgzkb/SUnfPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2014 at 09:34:04AM +0100, Sudeep Holla wrote:
> On 09/05/14 20:29, Mark Brown wrote:
> >On Fri, May 09, 2014 at 07:57:55PM +0100, Sudeep Holla wrote:

> >>If some real platform that needs this support urgently, then we can think of
> >>similar short-term solution as part of adding support for cpufreq on that
> >>platform. Do you know any platform that needs this right now ?

...
> >There's some other non-public devices I am aware of - the whole reason I
> >wrote this series was for those.

> Correct all these are 32-bit platforms which are now in process of upstreaming.
> So far they had their own driver and never used the arm-big-little driver.
> And this current series deals with 64-bit platforms.

Except for the non-public devices on the end of the list there :)

> >There are real users who want to use this fairly urgently.  I can't be
> >specific, sorry.

> That's fine, I understand. But the main argument is that if these platforms
> will not add support for cpufreq upstream anytime soon, I don't see any value
> in rushing to this short term solution.

This all gets a bit circular though - the more patches people have to
carry to make upstream useful to them less useful working with upstream
seems to them, meaning the devices are less likely to appear upstream at
all at least in any sort of complete form.  One out of tree patch being
required isn't going to be a deal breaker by itself but they all add up
to a perception that upstream isn't useful.

There's definitely some taste considerations with how far you go to
cater for such systems - in this case I'd say it's just tweaking Kconfig
to allow people to use code that's already present rather than adding
really new code (there's the stubs but they're pretty insubstantial)
which means upstream doesn't have to carry anything that wasn't there
already.

--qqIUvgzkb/SUnfPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcLvWAAoJELSic+t+oim9ccUP+wQzPRq5Ghwkws9VNogKj+gT
O+UdkTY3FZ7EawQti7geup4AeX3RwHowkhFFH0Bn38wmXvgjW0zJobU3sdd3r/2p
uZlTgGuoEqmMS/xDjzwW6KlRum+wY5ZF8eMmf6jRy81AL1qghxn9mBNj2IHd/G01
slKW9sGqFMhcNEfPo7cQsKRSQDeOfFBRW3pv2hM1VMrQ3SCZ96oQn0E7g3Jthz9x
BoEbwTtMxLKMjBuikiBoVapzxzJpMOR2GIzagpYr1VGdd9i/CLD9yXy3BbaDURLh
/+7koOrl0P+Nb5wLtuAGY9tqfLCeXBPrEJWcZ+h8JVdC+LsuqyZ03abEyuwOe5EN
sTU6jiEz36gzOzCso4ejUDoRz31RVhYCLe4bPy9m5tQqCR5z9SrvZPvUXx/Ol8wa
oCVoXZyWwtfAXyTSilSkVuHIXuNHMNZsSuG8agbMD75iasYe3spDaN2hUTWFpY+M
DKAqBBJwcn7nAYawI8Cg1zxFDktIChgiLgGzVtn3HDNfCiL3xSWcKPE5UEXJjowp
bVI7HWz0ACucgmmAlbznlVkVV3B9zupjkGkpn7SI3a7Te8EFlt17B6HA1KDGesbK
AoYnJghAaAqa9nDCyXpI8zau8WGqADscncXL7XFslfPiVSHLBDA0QX/DzqDLYG6z
bWoBJORnC0izpwo9GzcO
=P9s5
-----END PGP SIGNATURE-----

--qqIUvgzkb/SUnfPt--
