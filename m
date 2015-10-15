From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] bcm2835: Add Raspberry Pi CPU frequency control to the device tree
Date: Wed, 14 Oct 2015 17:29:28 -0700
Message-ID: <87bnc1gejb.fsf@eliezer.anholt.net>
References: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:33389 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbbJOA3b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:29:31 -0400
In-Reply-To: <1444592795-15129-1-git-send-email-lkundrak@v3.sk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Lubomir Rintel <lkundrak@v3.sk>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lubomir Rintel <lkundrak@v3.sk> writes:

> This adds a device tree binding for Broadcom BCM2834 CPU frequency control
> driven via Raspberry Pi VideoCore 4 firmware interface.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> ---
> Depends on the RPi Firmware driver submitted on linux-rpi-kernel a while =
ago.=20
> Can't see it in arm-soc or linux-next yet though (?). Available in branch=
=20
> 'rpi-firmware' of https://github.com/anholt/linux

Looks like the firmware driver slipped through the cracks for 4.3.  I'll
be sending a pull request for it for 4.4.

With the cprman clock driver, we could set CPU frequency natively from
Linux.  What we get from doing things through the VPU right now are that
the MAX (overclock) setting can be set by the user in config.txt, and
the VPU does some watching of thermals to decide when to throttle back
to non-overclock.

Unless we do native thermal control from Linux (which we don't have a
driver for) to get equivalent protection, then I think we should
probably go ahead with the VPU-based cpufreq control.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHvNoAAoJELXWKTbR/J7oPHoP/3SGT25bFbjhxI/LnMnE3xd+
Au1VIC8nylAqhirO8WhdsJjnumlJxWo7DbfTU6slV6ysAy/HT65T6eRadtyVkqf+
Uif52HWweZyigJTHneK/NSRbMGUtEmekAAQ3l2Uf9CViPpdS1HlsFrSJHqr7qakm
h5SZyJsUD4BI03R6vnWUbQsyfFAOCLklm6tyydNRNLkzt9dHqOZ1wTdqeI+BA3F3
zweXYXgAt9xNNwmqxHlXilGdXqE0UTTRhgnEFWKoxLayFPAzVKIjUHsI6bW/U6w+
px6EQVrKv9/txuwGHc4CBGPk2awVrhJb9Z/Tf+uZEwvuJLZTXXS/jqSzh0CAfJ3z
v8671kRC/QPJ5qFh/4OpANzwTHwd6pRjTcdZus5l36Fm5qZMyIF/uOckpPzLm+Jo
cC8ycPLo7tWS98CDV7aXugpksNkyZgeVnRjWqkEX8q41zHdpwYgqCo/iaKeW60gZ
0KbpPOW9L8b6llk0DYhTT15DtFMKrhzK81s81Duub5XALwWua3qBbQMFARuXhzq/
9MREkoJn4MY3w4ESvfwTsYvX31Tpy71Q6zgr3WDQT66G0bz9aGsfmOr4hE22oTkD
I+XAHfclyVKLJ0YfP+NmA6PPznoZhjrVnSDqCtxIVqSWIFr8qACX/tPviMn06erg
ocoFBKYQhStQWP8NN+Yk
=5Jad
-----END PGP SIGNATURE-----
--=-=-=--
