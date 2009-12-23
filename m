From: 640E9920 <640e9920@gmail.com>
Subject: PM-QOS hot path discussion.
Date: Wed, 23 Dec 2009 09:27:18 -0800
Message-ID: <20091223172718.GB16543@mgross-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1901729201695267041=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1901729201695267041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a bit of a rant and call for better collaboration on pm-qos
applications.

Recently I've had done some work to modify PM-QOS to implement a handle
based interface to avoid some performance issues identified by others
indirectly and directly regarding the list and string compares baked
into the initial pm-qos implementation.

BTW I'm still disappointed in the folks that indirectly raised
pm-qos performance issues.  Perhaps better collaboration could be had in
the future.

Anyway, at the time of the latest direct collaboration about the
performance the problem of hitting the request API from a driver hot
path I worried that making the API handle based will still not address
the scaling issue when there are more than a few pm-qos requests that
need to get aggregated on every parameter change.  i.e. making the API
handle based may not be enough.

I did the patch anyway, but as I feared this scaling issue came up.  I
don't have specifics other than an email saying I was correct to worry.
Ok, so now what do we do, and why?

Now what seems to be asked for is that something akin to the android
WAKE_LOCK_IDLE "thing".

Last night I gave some thought to this.  One could put a boolean or bit
mask flag into the aggregated value that when polled the poller could
know to not go to any lower performing state or kick the system into
higher performance states.  Setting the flag would only happen from
kernel API's and no notification trees would be called as it gets
toggled.  (that would kill fast path performance)

But as I thought about it it became clear the correct behavior is really
a function of the parameter class.  If the parameter is cpu_dma_latency
then the flag would be used to simply disable CPUIDLE from doing any
high latency idle states.  However; such a flag for network bandwidth (a
flag hit in some fast code path) shouldn't be telling the NIC to kick up
=66rom 100Mbs to 1000Mbs or go back.

So what would a fast path pm-qos parameter look like and how would it be
used, outside of CPUIDLE?

Is this fast path problem even worth solving?  Looking at the andorid
kernel for clients of the WAKE_LOCK_IDLE makes me think, perhaps not.
If there are users of this thing then, they are not public and I don't
think I should care about them unless they are collaborating well.

For the more shy folks on the list, this is an invitation to collaborate
on some evolutionary changes to pm-qos by identifying problems and
applications you have that need help.

--mgross


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksyUvYACgkQhK5OsmQOmSAaNQCeP/FelzcoJohaIF8rcLqwkjJF
VQkAnRcWBUkxWaJdw85+Ime0xzQs6a2Y
=hblT
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

--===============1901729201695267041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1901729201695267041==--
