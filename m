From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 10:46:40 -0400
Message-ID: <1458139600.14723.29.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	 <1458007395.8898.19.camel@redhat.com> <2600831.Qfymhh5Hpv@vostro.rjw.lan>
	 <1458089721.8898.25.camel@redhat.com>
	 <CAJZ5v0iC2CUKRJokVL5xsbebOPzxNUzXxzo8hxRvm-Y=0v_LQg@mail.gmail.com>
	 <CAJZ5v0hDGmReO9KQrofSu3K25xzP08yo+qqgLiEHejKrSXEy4w@mail.gmail.com>
	 <20160316100144.75bfef53@annuminas.surriel.com>
	 <CAJZ5v0iz87xKYFV_wiJgppfiCWt7uQGXyrQhoxpZ3E7GBhA5_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-eMcdwzVogZCwWcbYHExV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38639 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964900AbcCPOqo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 10:46:44 -0400
In-Reply-To: <CAJZ5v0iz87xKYFV_wiJgppfiCWt7uQGXyrQhoxpZ3E7GBhA5_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-eMcdwzVogZCwWcbYHExV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-03-16 at 15:14 +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 16, 2016 at 3:01 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=C2=A0
> > On the other hand, being more aggressive about C1 allows
> > other cores to run at higher frequencies...
> Good point.
>=20
> We need to decide, though.
>=20
> Do we generally want to use more polling or more C1?

I can see five distinct data points for decision making:

1) data->next_timer_us where we know for sure the sleep
=C2=A0 =C2=A0interval will be less than C1 latency -> poll

2) latency_req as configured by the user, if this is
=C2=A0 =C2=A0smaller than C1
latency we need poll =C2=A0(we currently
=C2=A0 =C2=A0get this wrong)

3) interval determined by get_typical_interval, this we
=C2=A0 =C2=A0may know with a higher confidence value, and choosing
=C2=A0 =C2=A0poll may actually be appropriate

4) data->predicted_us corrected only by bucket correction
=C2=A0 =C2=A0factor - this is a gamble, so we probably want C1,
=C2=A0 =C2=A0even if data->predicted_us is low

5) interactivity_req, which is data->predicted_us
=C2=A0 =C2=A0divided by a load factor - we should probably ignore
=C2=A0 =C2=A0that for poll since it is way too aggressive, and
=C2=A0 =C2=A0stick to C1 and deeper for this factor

Does the above make sense?

Currently the code merges (3) and (4) into the same
value before making a comparison, and neglects to take
(2) into account at all when deciding whether to poll.

Would you like me to write a patch to take the user
configured latency_req into account, separate out
the predicted_us and typical_interval, and test whether
to poll against the smaller of next_timer_us, latency_req,
and the typical_interval, while we continue to use the
predicted_us as is in the main selection loop?

--=20
All Rights Reversed.


--=-eMcdwzVogZCwWcbYHExV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW6XHQAAoJEM553pKExN6DWc4IAIjDxsRzaG+oeoLQsyRefv9u
hXU75WO7TKuJAUaXOZj4cg51aQRJwiqTWQbG+PsdTAYALKKJvpoQTPY4BEhpWM9S
D5x49opJGBOUKhP1YWzj25ZC6bhckKLxFK7kec9Gms6u6gVEYuJsJfHDKpqzk+NI
+H5pgB8A0OeCUNO551GTyBjoMXnxZA229uaUOFsOBUDkRhOwenu2wg/tGYtPBtkv
SYUm4pW3+6x3iR4EjNZqKlyvK9eYD7qtZdQ/H8JtMf4tH+R0GzgrwFoldGwBEsBf
/BoCFF4ay9GPqax4ViYhvy0ByixN5mCS1AUyfYtfkIPUNJPLkBm8hjs8DQR+dsk=
=kQL4
-----END PGP SIGNATURE-----

--=-eMcdwzVogZCwWcbYHExV--

