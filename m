From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 17:52:49 -0400
Message-ID: <1458337969.14723.44.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	 <20160316121400.680a6a46@annuminas.surriel.com>
	 <10828426.sI6CaBvZhk@vostro.rjw.lan> <000701d180df$e8a14340$b9e3c9c0$@net>
	 <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	 <003301d18144$87bb8df0$9732a9d0$@net>
	 <20160318173551.675ff6e5@annuminas.surriel.com>
	 <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-nfVugVlheGK/5Z5nU7Af"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbcCRVww (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 17:52:52 -0400
In-Reply-To: <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-nfVugVlheGK/5Z5nU7Af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2016-03-18 at 22:48 +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=20
> > On Fri, 18 Mar 2016 11:32:28 -0700
> > "Doug Smythies" <dsmythies@telus.net> wrote:
> >=20
> > >=20
> > > Energy:
> > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > >=20
> > > Trace data (very crude summary):
> > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load
> > > (idle state 0)
> > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less,
> > > CPU load (not all idle state 0)
> > This is a bit of a big hammer, but since the polling loop already
> > uses
> > full CPU power anyway, this could be harmless, and solve your
> > problem.
> Yes, it would be good to test this.
>=20
> No, I don't like it.
>=20
> If we are to break out of the polling loop after a specific time, we
> shouldn't be using polling at all in the first place.
>=20
> So I very much prefer to compare data->next_timer_us with the target
> residency of C1 instead of doing this.

The problem is that data->next_timer_us does not tell us
when the next network packet is about to arrive, though.

This could cause issues when dealing with a fast stream
of network traffic, which get_typical_interval() would
be able to deal with.

--=20
All Rights Reversed.


--=-nfVugVlheGK/5Z5nU7Af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7HixAAoJEM553pKExN6DBIAH/3CBGkUcMaOaFQJ+WrU2QcWk
8dxYGrwty590qoIBYW1Ee3SnBdud2OiGLWp2U2KhD+RZF68i/GbEPuEEskag7fI7
k4aJkK2JK0TBpf8IVzfCSEahpjcw6RdYCJVQLZTwPghgS9NpNptXA3AzfpGs5REN
X4Q+prisVGYsv4gdX0Pt0t4n6r4DiE8fpbZEyeLH7Evy+tyDgNXDEyrYzeYgxhHa
CHd1tjUvGXSErhqkCt4Mx1TgJL/rqwCxczUQnenVHnRjVkd7r+UpeD1ZNVWIXA0G
A/tXsG0tH5ftp2OuRh5o1DeYfkbsCoPsO75FzxWxZNeU2K28Lbjj41Cr2x0VFss=
=j0+Y
-----END PGP SIGNATURE-----

--=-nfVugVlheGK/5Z5nU7Af--

