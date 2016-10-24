From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Mon, 24 Oct 2016 09:38:59 -0700
Message-ID: <87eg35snvg.fsf@eliezer.anholt.net>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org> <1474446227-1147-3-git-send-email-kernel@martin.sperl.org> <87twczg27x.fsf@eliezer.anholt.net> <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:52367 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756963AbcJXQjE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 12:39:04 -0400
In-Reply-To: <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, kernel@martin.sperl.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Martin,
>
> Am 28.09.2016 um 23:10 schrieb Eric Anholt:
>> kernel@martin.sperl.org writes:
>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> Add basic thermal driver for bcm2835 SOC.
>>>
>>> This driver currently relies on the firmware setting up the
>>> tsense HW block and does not set it up itself.
>>>
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>> Acked-by: Eric Anholt <eric@anholt.net>
>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>> What's the status of merging this one?  I'd like to merge the other
>> patches.
>
> i think it's necessary to rebase the whole series. Maybe we could get it
> into 4.10.

Why would it need to be rebased?  The status, as far as I know, is that
we're still waiting for the subsystem maintainer to respond.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYDjkjAAoJELXWKTbR/J7or9cQAImhyuRvMyTW2ItnX7JrZ5WH
Jio7tfTdqOPusP+MCva72rs3sWx1dRYTxeuclWr1qLQ+oSxLBDO43lKjfNRIVg0V
UHDfl93eT2jIAQ6AyO+JBUPReDQo3anGppQQ3Gt0mi66b5XulB5X2SYirC4AuHGX
16eHvvF/tmmAwPc/pw6PKmE+OvzzXleIi/pHQEX/t7R5eHMQ8Tz29VHiEb1x49Vh
RlYyKLiz+kCnn515cdkSLVIQGGVQ7vcFGnvcMbx0A/MJsLi+WL3ko/5tpqlYAEEx
HcE+stkNPp+0oUWcAdtsLEKd4Y1eTfFt+oLMBgYtp4Br3hxDagVn2lj6gsDF5cKC
X8WEDKAO08uuotzEHs/6FkIuQmk1k8osqNxekRQ55ygjVIU/ZnhcvS8hP7ExU0oP
Toa29Df4/TXR9SRWs2NDaeZ7J2E2YG5oCCGeiReJW2qRMDY/vH9+rlXD1EJPAo7D
1ATaxSS2/6hMm0m4M46BcGae+i1OS+oPnEQTTjyobFT1ahh5yX61fKRfbpGoi46y
RMRB3QRUReeAtuUE+ULJfU4jfWdHT2OXYSTME/q5ZL0EehzmInsDZPDeEZPwJ38O
rUta+ak0AqQ18teG9L86RMujsiA2bvmkOOOsjaNk1UPrHs5rtMVCZ4vqAGIt//Yc
T5LbGEoE/tKo5OG2GyuK
=lPZr
-----END PGP SIGNATURE-----
--=-=-=--
