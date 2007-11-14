From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: make freezer optional for suspend
Date: Wed, 14 Nov 2007 15:38:59 +0100
Message-ID: <1195051139.4091.12.camel@johannes.berg>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711141421.15812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8191940501539675072=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711141421.15812.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============8191940501539675072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0gz82CwPAbUkHJd84s3n"


--=-0gz82CwPAbUkHJd84s3n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > +config SUSPEND_FREEZER
> > +	bool "Enable freezer for suspend to RAM/standby" if ADB_PMU || BROKEN
>=20
> Hm, is ADB_PMU specific to powerpc?

Yes, and it's the only code that allows you to suspend w/o the freezer
right now (via PMU specific ioctls)

johannes

--=-0gz82CwPAbUkHJd84s3n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzsIgqVg1VMiehFYAQJcXw//V3hl3DdFOUWsmk58n7iph+Kr5IVBbIAy
StSnGoKYpcKcNF9fTtSGacIUjj/sWBhJ2fgWDCvce+9CHxfBT1WFlfkz9t2PJPLi
vCe5tRFTwqqhqn44+hfg9w9UOvyrnQT39v2/Ym2KG6zN2FEP2yX+jKAANV8AypYU
xELQkZ6cZ95jYG3g7GVWV57RNsxPa4opcfHR3e9p25Cp8A5hA/61G+pSyHBTzKI2
Z2aEDO2j+LVYDiofeOzcO+T+APSwVwXzYB4p/0LqfKiSH7BVEgs2mWmfIKSkit7l
7PJydbEeIuoHAfBSnw8UGqMAI0WfULosskQwayHzvqCIMJmMCCYQ/WadHGNL7Tna
0hU/Q7UxxlSovQDMcn55OkiHDhfdFlEHq3CpVp7R+YhUA4tlQyudRAQ9/5UpROsb
ExwLxGoYhwSfhw9EgsohmxH+swM26WyDPYaKPtiiTQ2GxJFG3G2gttEf/kb6PyIo
NuqmQf/0CR2POxU3NwfY/0UPb0l9zDaHYQDCRUUKtBrPCEpurqnkK8xOVHMJvvSs
qFJ7NtE9Z18lUewsMuJ9uFL5KLdCeNCO3goy6jm0PR49JbDXLX80QgjvU7ncWQs2
EibS3mCEwZX33zWMnJTegMWskpyU9NviX4SelFHpZBi8Oj94lQsOqAy9R5Mktspr
ORxkfuptVnA=
=lQBm
-----END PGP SIGNATURE-----

--=-0gz82CwPAbUkHJd84s3n--


--===============8191940501539675072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8191940501539675072==--
