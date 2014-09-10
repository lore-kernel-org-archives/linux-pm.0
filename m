From: Valdis.Kletnieks@vt.edu
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 13:59:44 -0400
Message-ID: <17893.1410371984@turing-police.cc.vt.edu>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1410371984_2058P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from omr2.cc.vt.edu ([198.82.141.100]:57573 "EHLO omr2.cc.vt.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbaIJSAy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Sep 2014 14:00:54 -0400
In-Reply-To: Your message of "Wed, 10 Sep 2014 20:26:48 +0300."
             <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

--==_Exmh_1410371984_2058P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Sep 2014 20:26:48 +0300, Ran Shalit said:

> What is usually the criterion for PM (power management) suspending
> that application shall use ? Is it according to minimum threshold for
> cpu load (as indication for no process) ?

That will be highly application dependent.  Something that checks your email
in the background may not care at all, as long as it gets network
access every 5 minutes or so, and the entire system can power down for 4 minutes
and 58 seconds as far as it cares.  If it's doing media streaming, it may
insist on having at least one CPU burst per screen refresh, and the CPU can
go to sleep for the rest of the 1/30th of  a second.

> How usually it is performed, i.e.  is it some periodic process, which
> wakes up periodically to check criterion for cpu load ? If so, isn't
> it problematic in PM terms, becuase it mean that the system is resumed
> periodically (as a result of the the periodic timer's interrupt), and
> all devices are resumed ?

No, it can be done on a per-device basis.

'powertop' is a possibly useful tool for playing with this stuff that will
let you look at power management on the fly.

--==_Exmh_1410371984_2058P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVBCRkAdmEQWDXROgAQJCxRAArav2gUoZCYwkxOI94SpakZBxWIPeZqPg
zMHUO57h2Ir8M4gL1YCehUgQMAVHLfLObQrU+ScqcLoRQTrFWCKdhc97lohUBJgG
IAYmpD/keY0zzznvkb1785qr8zIJaGQ7Qv79tPSmmDrp6dMsF9/ze7wVrprFIuqH
mvobba7ACVro6lreBXDdAdhpoorcDJCnn8RVu99RUd8UOmoWO9XFtp4ZQHy3dd+M
2yBOyV51vicRnK9nvWN2pJ96FmcWxuCFBqkYIU0uWYu+VONT1hfHJDWHrZL6vLA2
28fj8+ODfIJMBoH4lMmCIPgbK562RlQDaz/8/tHq3c7edMn3KsS2iLo6i17aEwfk
19b2/ysotM1g5hyCkGLeCDHelBx63CAVTEmMQGjRmW16kRbLUGVL8x+NaVhTXGGw
x7EBx/nyc+iNmCxiHKKynhkVBFr+jtY7jbwsWl4R0cxcksFOXNPVCiIausz8n+ZE
w/G5oIh1HGIGOtoHVrqWifroP3As6y/6gWWM73wDl5BnUYBU1pECpw5VFON27Daz
v8FqNKJ7a1OHxiwUSOiXPk9YAEulmKV/p5zxv4+ED7HiZH+kbvjpJ8JOX3l0STrc
gnyGgxlS62ioODmlPsSmLfh53G6WB0PQ3w3658g21SNPcycIZWeBQ+TCYBll9NRH
7OePe6fVa6g=
=0FcW
-----END PGP SIGNATURE-----

--==_Exmh_1410371984_2058P--
