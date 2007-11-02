From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH 1/3] Suspend: Testing facility
Date: Fri, 02 Nov 2007 10:33:46 +0000
Message-ID: <1193999626.25744.5.camel__18700.047749053$1193999636$gmane$org@johannes.berg>
References: <200711012357.27797.rjw@sisk.pl> <200711012358.27919.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7712814786967122192=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711012358.27919.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============7712814786967122192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XH3R5JIuLv+FH2fiCm2q"


--=-XH3R5JIuLv+FH2fiCm2q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> 5 - test the freezing of processes

> +/* Suspend test levels */
> +enum {
> +	TEST_NONE,

Without reading the code, I assume that this enum controls those levels.
I think a comment that it is user-space visible API and should not be
reordered would be warranted.

johannes

--=-XH3R5JIuLv+FH2fiCm2q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyr9CaVg1VMiehFYAQKz5g/+MfER8HDO3LUWcgywC7RFBthKlJbBJqnb
d4zojvyem8WpXWRE3GhChODTtgIs9Szb0I17ESIONcY8ZUe5a7KNfqo3mfgDuyla
afSs4Ruhg7Qp4oslKSp84ie7wS62K3YwyUXWAvUrMJoGbQ38lMosB0FOnxIUEPG+
t2Vu/BldYFxd2YfNkrmuHjVlfGZZQK9LpqFA9PmvAgIOjPfPaWj1jURAAPd8YrO7
KFoqUXCBA9sAiOnUb8J0/3JAY+KjkipeX8AUViAwu8pAprjzkHVj2yXnR4c2ETpF
VgTox2/O4VH4y5UcMURNzJcx/6D72ongAyL5p9yWMYaMhTckVMA9GW4P5jkVAAUb
i6MPgnK1gkWWMjSLR+to/HhO9w0WqUMBFESqEukuJC9J1sT7NxMCEPB/SCWywI4+
piwdVHDLp1EjI1JZPa3EmTW0WIkRBzwUQcqQ4nj64XQf2IAl9j+yzPMeT/wwIHVn
70oqoLtWKsGdLbew3OdyBKj5vdQrqB9IvOyiuD/qE3QvxxLtqb4FlTmpVUZmcHqp
v1UY1O1xWm03zjyboZaqJs5HThPMvtTjK35lIq6EU/uzvrGGiFEh84SRmR0owHzv
3PwcUtH2D0Sr2ruvfWL4+PTRbTezGh1TbVst1pw/EJeYe514u/R8e8qjCGn3u7Mu
RfX+4h3Vlfw=
=nXcR
-----END PGP SIGNATURE-----

--=-XH3R5JIuLv+FH2fiCm2q--


--===============7712814786967122192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7712814786967122192==--
