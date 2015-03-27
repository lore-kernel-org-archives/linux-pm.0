From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFP] LPC thermal track
Date: Thu, 26 Mar 2015 20:02:49 -0400
Message-ID: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34607 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbbC0ACw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 20:02:52 -0400
Received: by pacwe9 with SMTP id we9so78014149pac.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2015 17:02:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, cyndis@lakka.kapsi.fi, kapileshwar.singh@arm.com, l.majewski@samsung.com, geert+renesas@glider.be, srinivas.pandruvada@linux.intel.com, wxt@rock-chips.com


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I've created a proposal for a thermal microconference track on the LPC
2015 [1]. The basic idea is to get thermal developers together and
discuss the thermal role within the Linux environment, from kernel and
userspace perspective.

A initial proposal for the topics to be discussed are:
=2E Closed loop control governors
=2E Sensor API
=2E Thermal class: split of temperature sensor device and thermal driver
=2E Improvements on OF-thermal
=2E Devfreq vs. clock cooling
=2E Power model based policies
=2E User space tools
=2E User space governors

If you have interest, or if you have ideas on how to improve the
framework, reply to this email and add it to the wiki.=20

Add your name in the list of participants as well. Also, if you feel
like giving a talk on the topic, let's add it to the topic list.

Currently I am simple checking what would be the level of interest to
have this topic as a LPC microconference.

BR,

Eduardo Valentin


[1] - http://wiki.linuxplumbersconf.org/2015:thermal

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVFJ4cAAoJEMLUO4d9pOJWsEAH/0kwlAQnq/c/4rmfCRltQ7Si
5weGDyhvrHMC93gpbqgKshFZQe8HWhfbccecKQOs5cFJxQIJP0ye3NpnOQVyVgfj
rqCIudHAYbq1scjJtRYanlhRBhz9pFQP7JZ7lbHei2A3lnL1Yz2/yjiXv1/sNQiD
/TWEfKSeWyj1hx5zaX0FoAW8ylfSMV3gU1Ugh7Ew0y1s4qR8coG3GlLf/QdifVdB
ETR49AphvHEKop7I2eR/+526dxQjVaQAJ/ex2zGMj+JF6O5MKbJfONcKDDUeJfqW
zdfwlX8h5XoRIyn9Ph7XXRrF7nRkPzvWWTChqObPgNDVRfko8FK5Mtw0fBxIxHE=
=qkjx
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
