From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Wed, 16 Dec 2015 16:39:26 -0800
Message-ID: <87zix9rjr5.fsf@eliezer.anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <1450215622-27394-3-git-send-email-eric@anholt.net> <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net> <5670AAB2.1080102@gmail.com> <87mvtbkyd0.fsf@eliezer.anholt.net> <20151216011110.GA13147@earth> <CAJKOXPes85hu6Jnd5p6dqhgdBGF4kmZuJQekM73O83DuZvcyoQ@mail.gmail.com> <CAPDyKFqPk5XPPYMYe6HZc=b8-b-Y2VB6mQfZP8_TS8KOFZjsUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:42546 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbbLQAj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 19:39:29 -0500
In-Reply-To: <CAPDyKFqPk5XPPYMYe6HZc=b8-b-Y2VB6mQfZP8_TS8KOFZjsUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@ring0.de>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lee Jones <lee@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--=-=-=
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 16 December 2015 at 02:27, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2015-12-16 10:11 GMT+09:00 Sebastian Reichel <sre@ring0.de>:
>>> Hi,
>>>
>>> On Tue, Dec 15, 2015 at 04:53:31PM -0800, Eric Anholt wrote:
>>>> >> There are 6 power domain drivers in
>>>> >> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
>>>> >
>>>> > If we ever have to support a different architecture which happens to use
>>>> > a similar power domain, then we want it to be in a location which makes
>>>> > it easy for sharing it in the first place. As it stands today, it does
>>>> > not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
>>>> >
>>>> > Maybe there is room from a drivers/power/domains/ of some kind?
>>>
>>> I like the idea, but let's include generic power domain maintainers
>>> in this discussion, as I suggested here (I got a power domain driver
>>> patch for drivers/power just a few days ago):
>>>
>>> https://lkml.org/lkml/2015/12/15/815
>>>
>>> Also somebody would have to step up to maintain that directory.
>>
>> This could go into drivers/soc. We put there a lot of mach-specific
>> stuff which we want to make a little more generic (like generic enough
>> multiplatform, multiarchitecture etc). Rockchip has its own power
>> domains there. Dove and Mediatek seem as well but I am not sure. Some
>> other architectures keep this still in arm/mach (exynos, ux500, zx,
>> imx, s34c64xx, shmobile) but this looks more of like a legacy choice.
>
> Agree, drivers/soc is good.

OK, I've resent with a move to drivers/soc/bcm/.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcgQ+AAoJELXWKTbR/J7oubQQAKbCOi3iC5BGy1g3/rUlSiMm
5uTsfOe5ltjX2DDcXdRZTubpad5kDt95JY2e9lzdOH+ua1xkTwKOEOUYRCK4YjfJ
dnvJcfOAoqtvMrbs8y78QJBv/o/eiuDZfbFFUBv2iKWJ+nsORSQI7728laoUObbs
XWEptek7VZuG3hs2xTdcFd5/U7ho0hNOj17dUBQg2AABFcO9kflBryv/ngTwMqSl
he3uLoiIobj/bTUcLNFnXYXwk+3AOnjP8amsGfRuoberuhLRFZNkYEd3TimvoSv6
fyx05Agvabusmpq8s++3bMTorVc5HpI5XmMKR1+NTcpcSv1wqvXebpSZl+ArTNsZ
qjUC+GcEas0URTb9v+IwDTGhdJz3OJ5MtSJoZtsyN08QDLwhm9lzxc2sUDC4+5CT
fe6YO6n2JSiqrs+sRRAUa0u3QiU3BliWR1Am7bgqjijP8K8cVMvX2PXwTTey0svL
MRj4FwVuqJm6666FCedQiDtaLMnvVsENEygdhvacrj3bA208Sy7xUS6v0QsBMQiJ
JDjy4h6lnGh0MeXdMU9pcoRVwOc183zff1b2Ef6rp7N4/FXzdqr+Yg0oUikZMtX4
VRYjZi7RDc2OiUDiXxFVdryf3ubHQBnwoeLnvF0UTB1QY0+hoDUbs7SWKFUs1j8Y
K+wXndvXn2d3BaUD/zKf
=Moa+
-----END PGP SIGNATURE-----
--=-=-=--
