From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Wed, 28 Sep 2016 14:10:26 -0700
Message-ID: <87twczg27x.fsf@eliezer.anholt.net>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org> <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:57328 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753162AbcI1VKb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 17:10:31 -0400
In-Reply-To: <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>

--=-=-=
Content-Type: text/plain

kernel@martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

What's the status of merging this one?  I'd like to merge the other
patches.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX7DHCAAoJELXWKTbR/J7otGEP/2AXpUo0FKrGMup1VqZh+ZWX
qtGQ31Y65h26yj4e9Oi25zTWmGpuYh9VXCnEIRPnATlvQNCBU9tWSXOUDRv1AZhB
xcnK0Iti3hLSrwatguZ80yLxwAG8vsuMZJ35RS24oOMcv1wGL2taFJqbGGMtyiZo
5qB2IRcQW2lOyAGSOhNPI7A22wn4uhQ9ohki4cMmj+v6EvOhkEhw5T+9dNdlHwx8
n03eKCnqMXyqg1bHdNUtjyMjk6gbIIQV1jMZLhyh4PMp58fTz6huwMGldBIokyPj
bvpgMRinZGQtzK7UPvqcpAlUdOc6ySSTTvSs8C+DYQRNh3OxpPLHmXLdldMCLmf1
l/sEkc0axJvzpb6ODoXJeQGjdEBHchI//69+RhaRdHXNY2YFTlvBSelZgIQiE3rf
mTgZeVU2iANYJ/bHTHDTUTKWX29dNZXR5G8YCeFOIVNXVg8EOT2MBRo9xc2rulV/
bjVQQOGX2h28efiEl/1cc1/2SVZR3qhtVi09bStMNlXMAZHbJoNauOHze0rnXWag
DL39pwKtNYz13Re3ePOpixU1Zq7ZoRYH6etaHc8/wb+3/kxU8XwT5jGsKQszJM20
YRoN+zttIpAcI8ngciNL1tmN7y8hst/2o+Ggqk2idq1Vs/3LZOqjrPQikKLuOWas
P08F3HrJZvP9aGqemXB7
=ZkqH
-----END PGP SIGNATURE-----
--=-=-=--
