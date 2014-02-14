From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Fri, 14 Feb 2014 15:34:23 +0100
Message-ID: <20140214153423.340e404e@mjolnir.ossman.eu>
References: <20140214072623.3dd67851@mjolnir.ossman.eu>
	<52FE01A2.9030905@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-17047-1392388467-0001-2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saehrimnir.ossman.eu ([193.12.253.10]:35914 "EHLO
	smtp-relay.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaBNOed (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 09:34:33 -0500
In-Reply-To: <52FE01A2.9030905@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-17047-1392388467-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2014 17:14:34 +0530
"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:

>=20
> So with that, I don't see how the KHz value can turn out to be zero!
>=20

Very interesting. But I can tell you that it is indeed happening. With
my earlier patch (that checked the return value), I did have this in my
dmesg:

[  188.044175] cpufreq: updating policy for CPU 1
[  188.044177] cpufreq: Driver did not initialize current freq
[  188.044177] cpufreq: setting new policy for CPU 0: 1000000 - 2800000 kHz

I can sprinkle some more pr_debug:s in there if you want to trace it
further?

Note that this is with 3.12.9, not master.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-17047-1392388467-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iF4EAREIAAYFAlL+KXIACgkQopDLsoqlmELpEQD+IuSLf7uiPf537GrdmqwYfRqH
cDum3sOHwRFa9/cMIz0BAMjWk9UYLrKbTT3Cx7aNHtNWYJhCZbTQapRCURKZrtBR
=SoLJ
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-17047-1392388467-0001-2--
