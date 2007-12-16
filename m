From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Sun, 16 Dec 2007 22:03:38 +0100
Message-ID: <1197839018.6769.38.camel@johannes.berg>
References: <1197827906.6769.7.camel@johannes.berg>
	<1197831551.6769.13.camel@johannes.berg>
	<1197833664.6769.17.camel@johannes.berg>
	<200712162156.08920.rjw@sisk.pl>
	<1197838162.6769.33.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7988420527715369734=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1197838162.6769.33.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Jamey Hicks <jamey@crl.dec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org


--===============7988420527715369734==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Hiu+it6a5GoFib+p1ahw"


--=-Hiu+it6a5GoFib+p1ahw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Patch below, tested with my test program with an additional sleep(10) in
> it.

Of course, that patch is going to behave very badly if we're asked to
suspend from within apm! Will fix.

johannes

--=-Hiu+it6a5GoFib+p1ahw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2WSqKVg1VMiehFYAQLZOw/8DtSZ6o5g7knAUynlb69hrSxCCNZvOzPn
j/RnuY3cHmigsFSw/Oy/FYAz6gabpLPK/tA7g6bkVkVwxdhhuM+OwtmjGGRt6gbZ
aTR3EweDoHu04L1llHAtNidWByQhdn8KeKmX1UjPEw5JNjNwo5UHRZRY/8EuWKOD
/StECKn06ji9QiXO30NfDXmKJNGkopPsZwW7eA0Q1Hij+rQNDVV/R/wsR0AOhNT2
441PjN+rT/DA5i+lXfDSC/Gg3Qv8DAEcQtQgYPXYcaSvqJI/Kq+Z4Ux1pyZEEK5U
PuvYjfvst3LFwwbcJxL6EG5YAiJkjVMgxcGyP/9nrRiuAD/LuWbj4ydhl0cEC8Sg
JptvLkH2dJ7tK5SAC8q37kh4eiiWU78Kq73WwTszGPQUtKUIqRGhauJeIX5GUbHA
oRh0fitlLlfFjydxtURU1HurzC9ahzkdZgzpUaj/bRsl/s33uysF8fpn660Cquin
L0I46AtDZOTx1XK54IHiob8eEpE+RED1zBHuWLZUjmRE3HFdOm26jRxCXkPJx7HG
zwBqhYv1kBYGHEvfwF56hMwacQ2t1GYofxXvVxhdDox76OEyQo7fUaHF7zWIlLC5
cIDRsPK8PcuAUcnQQqxBE8YRvZ97wMz64ENdYFhlrmOc8PWxyKgOXzYiQMO2IJ+8
vrxR7EL8ZVo=
=6BZx
-----END PGP SIGNATURE-----

--=-Hiu+it6a5GoFib+p1ahw--


--===============7988420527715369734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7988420527715369734==--
