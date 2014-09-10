From: Valdis.Kletnieks@vt.edu
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 14:39:38 -0400
Message-ID: <20227.1410374378@turing-police.cc.vt.edu>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com> <17893.1410371984@turing-police.cc.vt.edu>
            <CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1410374378_2058P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from omr2.cc.vt.edu ([198.82.141.100]:34307 "EHLO omr2.cc.vt.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbaIJSkq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Sep 2014 14:40:46 -0400
In-Reply-To: Your message of "Wed, 10 Sep 2014 21:23:28 +0300."
             <CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

--==_Exmh_1410374378_2058P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Sep 2014 21:23:28 +0300, Ran Shalit said:

> As far as I understand, suspend/respond PM is not per device, but for
> all system,
> and wakeup source will resume again the whole system.
> I think you mean runtime suspend/resume in the answer.

The original question didn't specify. You said "suspending that application",
not the entire system.

And runtime suspend/resume of devices and even the CPU does fit within
your original question constraints.

If you're looking at system-wide suspend/resume specificially, there's
two basic schemes in use:

1) User hits a button, acpid or similar notices, and does a suspend to
disk/ram/papertape/whatever.

2) User hits a button, closes the lid, or a user inactivity timer expires.
A process notices, and asks all processes which have registered for suspend
notifications "Is it OK if we suspend?", and if nobody says "Nay", it does it.
If a process complains, it is repeatedly polled until it finishes whatever it
was doing and says "OK now".

--==_Exmh_1410374378_2058P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVBCa6gdmEQWDXROgAQKZsA//T5px7M1s33QoNM68KevQyjkjuBn0Emhw
AKxsm8OUYknVFEdqbC4dGqPoxAg+z+hkHBrR1HdbXuP8AaiHKqokpMgHbRs+C1Vx
it+AlUs63lu9oUXFroWNENdPaPNzpsMnfeI/BqflajaPVpLV30h96kgVlgqeCVZK
2sXtk+Wvo8iAGRc/jD4nIsJ8XQg2a+l90/GbBthhrOu9f1ErKm+sQDAqyWeNraX/
6+gVaBv1Ht1X1J0EL3lT+/dpbD2qAOkSZBsgQD0qhBZ/PvkzxXTbX4KH769tUN8p
G0jo4k2YR3Z5Gfg3grhkJmT+JsjTTPCAuybLpx81OyokWUk7UN11IxO3IcsHBKno
yHQfWr7c41dYGJfdnziYYEqHQcZKsNMzN8RUWJ06jdCOyz5XX95iIulwpx6oofxV
z+Fset3X6Uwwlaq4zxBbKd8eX1++Sn9Zi0EsGUFp97LT2ZIuDyxO8h78N9EMMxd9
y03UO+2qcxjOatIlay7wPVPp2l0RyMpHN27fO5E5peBtda713g9s69dzcopOg7P5
SJ24DtDEL1WwiUJx8BB1bVhyhR/yCq+DcfxxSUSdwUh6WTHfn7dSaxKt3PtaeTvo
eklbDjLOK6ttj/Auutp/h5N9o92PCMyIi4RME3gm9Lg3abXszRk6fqmOKMSmpTrU
DfVnwmz4x7g=
=qt8b
-----END PGP SIGNATURE-----

--==_Exmh_1410374378_2058P--
