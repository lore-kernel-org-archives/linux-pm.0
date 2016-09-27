From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 2/3] regulator: max77693: Also manipulate the fast charge current
Date: Tue, 27 Sep 2016 19:51:56 +0200
Message-ID: <874m51w7r7.fsf@machinist.wiedmeyer.de>
References: <20160927161502.ygfa26xk7sdj2uot@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wiedmeyer.de ([85.116.192.112]:60590 "EHLO wiedmeyer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755483AbcI0RwR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 13:52:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by wiedmeyer.localdomain (Postfix) with ESMTP id 4A5058E91DF
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2016 19:52:15 +0200 (CEST)
Received: from wiedmeyer.de ([127.0.0.1])
        by localhost (wiedmeyer.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y0od19NWKz_B for <linux-pm@vger.kernel.org>;
        Tue, 27 Sep 2016 19:52:12 +0200 (CEST)
In-reply-to: <20160927161502.ygfa26xk7sdj2uot@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Mark Brown writes:

> On Tue, Sep 27, 2016 at 03:50:42PM +0200, Wolfgang Wiedmeyer wrote:
>
>> When charging is disabled (e.g. by removing the USB cable) the charge
>> current is not reset to zero. So if I expose the current by the
>> CURRENT_NOW property, it incorrectly reports the current that was set
>> when charging was enabled, although there is no charging going on
>> anymore. So I felt the need to update the charge current every time the
>> charger gets enabled or disabled.
>> Initially, the charge current is set to zero, so I think it needs to be
>> set at least at the beginning to enable charging.
>
> Are you sure that the register value you're looking at is the actual
> charge current right now and not just the maximum that the charger will
> try to use depending on the conditions (supply available, battery
> state...)?  It seems like you're acting as though it's the latter but
> that's not what the chip is doing.

I was looking at the vendor code that was released for the Galaxy S3 and
there the same register gets accessed for getting the current for
the CURRENT_NOW property [1] and for setting the current [2]. So is this
probably the wrong use of the CURRENT_NOW property because not the
actual charge current is read but the maximum value that was
set? Unfortunately, I don't have access to the datasheet and I didn't
find it online so I don't know where the actual current can be
accessed.

Thanks,
Wolfgang

[1] https://code.fossencdi.org/kernel_samsung_smdk4412.git/tree/drivers/bat=
tery/max77693_charger.c#n531

[2] https://code.fossencdi.org/kernel_samsung_smdk4412.git/tree/drivers/bat=
tery/max77693_charger.c#n552

=2D-=20
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX6rG8AAoJEFgWokwQdX/EQmEP+wcyOVrtl3O1rTq9cXgV1RWL
DK6PDAWjwOipcRD2X4+owLiJPfPXFwnzauN4n6bXLUgYAZrl3/+ExQGQ807eNy4z
BFTQHz6tsje/MH/j7frRR+FZ4pTZP9pOOqacmE69hq5Tf8+xoYdyhubdA/Ps2R1E
rcziL+WN+vxc7j795fzIJ5mXR8NpWcgG5Lguj/Y3jHgrbdvcteeGgQw9n5Q2Jo++
tO5LFUV/e7Cof5sxHZAIkllLYk4oObdon9KurZNV8hMpEFqVzKC/AU6l2dt7Qdz7
FqNs7XdJtTKnvJQ/7i7/vona8hgZNmIqo0SVsX/H5qFnLj5AEbblhMt3arcq2eND
85MQecFecHCXglgpdcrk/Pr8hgZVIcJQVzRxUcVE5uBSIh7pmrVtY1YCJuTtxqud
1CzHeKKcrxtFCynu+u+6ql7MdZ9q3c/i1QQagl0LN2y5r6qzlDZN0cKwydXIsRQs
9Y3VpAc0CSjjsT5QpPkCJVdvjGIDrzV0D3ndYBTBXIMNkJiie4qXlN0HaIZyokmc
qNjFSyDr3s/XpazKQnRHp3JVtAnyni0FQEcC1fPTdPNgIjjFjvT4nXJHgIo9iqoC
Vdg5F6LwVXhmr5zIbRozppnYJx7iXIwkCW/yaAtgG4jyXToCoH0pfh9h/n9pzn++
DbzdRxcY1WdUL4U5g698
=mZ5c
-----END PGP SIGNATURE-----
--=-=-=--
