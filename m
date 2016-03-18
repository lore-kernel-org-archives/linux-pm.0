From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 17:26:03 -0400
Message-ID: <1458336363.14723.43.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	 <20160316121400.680a6a46@annuminas.surriel.com>
	 <10828426.sI6CaBvZhk@vostro.rjw.lan> <000701d180df$e8a14340$b9e3c9c0$@net>
	 <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	 <003301d18144$87bb8df0$9732a9d0$@net>
	 <20160318152957.5c3b91bc@annuminas.surriel.com>
	 <CAJZ5v0hOeFjj6d0jV+6aFtdkAk_ocH=K-KS5NSQ1P0-kqdnRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+ThHBW8m9Yw4i48maQRK"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbcCRV0I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 17:26:08 -0400
In-Reply-To: <CAJZ5v0hOeFjj6d0jV+6aFtdkAk_ocH=K-KS5NSQ1P0-kqdnRkg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-+ThHBW8m9Yw4i48maQRK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2016-03-18 at 22:24 +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 18, 2016 at 8:29 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=20
> > On Fri, 18 Mar 2016 11:32:28 -0700
> > "Doug Smythies" <dsmythies@telus.net> wrote:
> > >=20
> > > On 2016.03.18 06:12 Rafael J. Wysocki wrote:
> > >=20
> > > >=20
> > > > I'm wondering what happens if you replace the expected_interval
> > > > in the
> > > > "expected_interval >
> > > > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test
> > > > with
> > > > data->next_timer_us (with the Rik's patch applied, of
> > > > course).=C2=A0=C2=A0Can
> > > > you please try doing that?
> > > O.K. my reference: rvr6 is the above modification to rvr5
> > > It works as well as "reverted"/
> > >=20
> > > State k45rc7-rjw10-rvr6 (mins)
> > > 0.00=C2=A0=C2=A00.87
> > > 1.00=C2=A0=C2=A024.20
> > > 2.00=C2=A0=C2=A04.05
> > > 3.00=C2=A0=C2=A01.72
> > > 4.00=C2=A0=C2=A0147.50
> > >=20
> > > total 178.34
> > >=20
> > > Energy:
> > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > >=20
> > > Trace data (very crude summary):
> > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load
> > > (idle state 0)
> > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less,
> > > CPU load (not all idle state 0)
> > What does "long duration" mean?
> > Dozens of microseconds?
> > Hundreds of microseconds?
> > Milliseconds?
> >=20
> > Either way, it appears there is something wrong with the
> > code in get_typical_interval.=C2=A0=C2=A0One of the problems is
> > that calculating in microseconds, when working with a
> > threshold of 1-2 microseconds is not going to work well,
> > and secondly the code declares success the moment the
> > standard deviation is below 20 microseconds, which is
> > also not the best idea when dealing with 1-2 microsecond
> > thresholds :)
> Well, that might be the reason why 20 was used in the original
> data->next_timer_us test ...

Good point, and it looks like Doug's problem is something
else. =C2=A0Let me send a test patch for Doug in another email...

--=20
All Rights Reversed.


--=-+ThHBW8m9Yw4i48maQRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7HJrAAoJEM553pKExN6D+F4IALejuGG5CAF0Au83gz3X5F43
zJwVV8cRMNvm5+0DGdqpByxfI8NSlH/pMzZwwbvSlflHeommupZ3moI62mraG5VE
mdF+wEqdlrhO7eRfhyfDAvEsFsItgPcQ1e75zuQQcpmwMi+allKYguZ/VBZd31cv
5Zd6kkb08c4pHd4VH1XlTSLSyef0yXLDeFAFLai5AHVU+D0VEhhICdl2joeU1FUj
h7MwvUkcR0A+nNytyyJI1pCXs2WNUjQqvUbAsSFlhiyxTxTwWCdFeFud9IClZArv
5lGMhNGpmVl5iFtQVWe19GZ/i1YMyOuoWPgzR7/wYP665oy/PTPnM2mNM1XPtnc=
=JqvS
-----END PGP SIGNATURE-----

--=-+ThHBW8m9Yw4i48maQRK--

