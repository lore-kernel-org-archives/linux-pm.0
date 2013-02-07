From: Valdis.Kletnieks@vt.edu
Subject: Re: next-20130206 cpufreq - WARN in sysfs_add_one
Date: Wed, 06 Feb 2013 19:55:58 -0500
Message-ID: <30908.1360198558@turing-police.cc.vt.edu>
References: <9180.1360172675@turing-police.cc.vt.edu>
            <17233164.aBDzy1OViI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1360198558_2167P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: Your message of "Wed, 06 Feb 2013 22:24:39 +0100."
             <17233164.aBDzy1OViI@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

--==_Exmh_1360198558_2167P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Feb 2013 22:24:39 +0100, "Rafael J. Wysocki" said:
> On Wednesday, February 06, 2013 12:44:35 PM Valdis Kletnieks wrote:
> > Seen in dmesg.  next-20130128 was OK. Haven't done a bisect, but can
> > do so if the offender isn't obvious...
>
> I suppose this is 73bf0fc "cpufreq: Don't remove sysfs link for policy->cpu".
>
> Can you test the linux-pm.git/pm-cpufreq branch alone, please, and see
> if that's this one (top-most commit)?

Color me mystified.  I can't find that commit by either number or
the description:

[/usr/src/linux-next] git log | egrep -i 'cpufreq.*remove.*link'
[/usr/src/linux-next] git log | grep -i 73bf0fc
[/usr/src/linux-next]

Was that a very recent commit that may have gotten pushed too late
for the next-20130206 merge?







--==_Exmh_1360198558_2167P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBURL7ngdmEQWDXROgAQITTg/9EvAJblZcE9YXSZ03+bP2NmEGIR+xFICF
RC3l0oe6ss70WxjrxjltP1LGnoi22cJD5dUPZC66W9RQu7AlA4J5A6Oi2Jcicper
b9HItqrwItHUjAXnnXg45qKnG4WcrMEbSM7cG1ieOuGnBUdBq6ZKxlFnvEOc8ZtD
1IASH/zavTMHHeY1lWShVj8wQ2yWUvGUcKTwz9pD7/D7LVpo5Zo29gp1bBKWmy0R
CrYGcYpdbkkx+5i94VXLJNMY0njaZgGdbRFvBoRR3vOrmgehyaGSMtMoTCgYb18m
ymTzS/I/x4S/WsZ5tlbdfKgzwSds8JQh5xH2uCb6Ib2YXPAuzNA04TwxT4ta/M+B
7smFJndcKmPB2CklVT2AoqH7kpfHiFb6xqe8RkmaWQ5LXRTPHZh+jpfcKHDBmj0j
g6Sy4PR+WeAgpBh/+IR/0iT2Jip2fmw8HOcTfCQF/uPuNEN2q4fVZDFRA0tBrt6e
sAdW1gCoiJnLln3dK271iJNr/a8WLmW/EuW2B/WvvHKhmfoBqBb29/cIL6LpGp3F
O7p6mQFv5RsWGOmfVHcUj2OjKFyFFIdwf1hNbivtoYbQvwUyhMl4P3lk1OPQVbqP
jpJnDnEShdoAvGC45S2Q9KFrx9Tzv02moiMkbuhlNzEHjXFtlJ7Vg4nFtObtbZYu
VuXhKi5SLtw=
=6gKn
-----END PGP SIGNATURE-----

--==_Exmh_1360198558_2167P--

