From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Fri, 18 Mar 2016 23:09:25 +0100
Message-ID: <1596370.PSmUAlHJf5@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com> <1458337969.14723.44.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1928826.CcXgSrbnDm"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47866 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750778AbcCRWH2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 18:07:28 -0400
In-Reply-To: <1458337969.14723.44.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--nextPart1928826.CcXgSrbnDm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, March 18, 2016 05:52:49 PM Rik van Riel wrote:
> On Fri, 2016-03-18 at 22:48 +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
> > wrote:
> > > 
> > > On Fri, 18 Mar 2016 11:32:28 -0700
> > > "Doug Smythies" <dsmythies@telus.net> wrote:
> > > 
> > > > 
> > > > Energy:
> > > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > > > 
> > > > Trace data (very crude summary):
> > > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load
> > > > (idle state 0)
> > > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less,
> > > > CPU load (not all idle state 0)
> > > This is a bit of a big hammer, but since the polling loop already
> > > uses
> > > full CPU power anyway, this could be harmless, and solve your
> > > problem.
> > Yes, it would be good to test this.
> > 
> > No, I don't like it.
> > 
> > If we are to break out of the polling loop after a specific time, we
> > shouldn't be using polling at all in the first place.
> > 
> > So I very much prefer to compare data->next_timer_us with the target
> > residency of C1 instead of doing this.
> 
> The problem is that data->next_timer_us does not tell us
> when the next network packet is about to arrive, though.
> 
> This could cause issues when dealing with a fast stream
> of network traffic, which get_typical_interval() would
> be able to deal with.

If it predicted things correctly for small intervals, that is.

It doesn't seem to be able to do that, however.

You seem to want to trade energy consumption for performance with a very narrow
use case in mind and that by changing bahavior that's been there pretty much
forever, so by now it really has become the expected one.

Needless to say I'm not a fan of changes like that.

--nextPart1928826.CcXgSrbnDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJW7HydAAoJEILEb/54YlRxtYAP/31SGFSaYwMgLoHppjoPW5gP
68PY4Gr/sijD9sQkegq+vqly5MbS3qMt1Erfmf97VTOkmbYGGm6YcOuvMPk4Fr78
FX1axk8m2W4hws+nunfliBW3rD7wvy+LIrqjOvnw2n3+NLh9pTcv8YpjL6oyef6e
lxRQW3Busnm8BTUSyXE9+GssjdfZSOLuhYIJWEp5k+PJISaLX2Cb53wRI0wlz3+6
2niYfxBZmLhfeA9NT00BBdgSRTV+hebTOQBgEQYT9zjjyUw0GOXGoB7NJKT6l3GL
+aBRfeQOgVBBgkNtUuuKOVPK5NNpJMA6/ZQ0QJbH6qWF9BoG9DWzsdO2kAtt4lQ/
m8a86dRwSU5tWLm4+okCKvtbYcw0E0cgTE/3GJLR6XZXIsMNlcPB0W3T/F2rhiTM
Ddh2Dnu8g4JDPJCJTwPnZQxV1XxlK1n2Z9i8j7CAD1TeuLrPSsbpGn4t0D15w1Dx
af5PFGn9Pmfp451IYljDkxMA581fAifVpobU6h6zIbZ5XMFneNwuwDXScK67OUX9
drnFxGXmAT6pC33hSotBQ3cw4M2KM65T/3b+BNMSGfUz6AFZxrGIZmmmRjcOPHg6
PoFRJXLmEYfPYgK9kYGeAB+ePHdTekbT4t5Lo+Hgu+vBCNz+QPBU9LGOpCbWSuCu
jYEOwp45vMOoHhmtQbwF
=ANjo
-----END PGP SIGNATURE-----

--nextPart1928826.CcXgSrbnDm--

