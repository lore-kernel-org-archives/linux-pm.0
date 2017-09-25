From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks
 to late/early stages
Date: Mon, 25 Sep 2017 16:24:28 +0200
Message-ID: <20170925142428.2favzil5upydpusw@katana>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <4332008.kXBLY0K23i@aspire.rjw.lan>
 <20170925072847.nl2a6feqzrzdcxwz@ninjato>
 <3654965.TWMXy0zEsZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctrcamb2jfx2mqmn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41096 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935317AbdIYOYc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Sep 2017 10:24:32 -0400
Content-Disposition: inline
In-Reply-To: <3654965.TWMXy0zEsZ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>


--ctrcamb2jfx2mqmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Well, it may be slightly late for that.  Realistically, the earliest -rc it
> can get into seems to be -rc4 and I'd prefer it to get a bit more exposure
> before it gets into a release.  It's up to you, though. :-)

Fine with me, I'll schedule it for v4.15 then.


--ctrcamb2jfx2mqmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnJEZgACgkQFA3kzBSg
KbZ57RAAkuRVb6uAlZdyFRk8wq88sv0aPAWzD/wgNQTEjNz6/+Cln+nGGNwNmP5o
1BTBkw7nMWGL5oQHNtZve2QnMk1j29VQ73QvAwMtbwUfLWtpX2qJr7w0iUWt3TF3
OiImVegkPMZkJLGtrnqPntLG/gJynXSvXnbdKHFEvprnTk1t/vJZdbflLH5kDB6i
ZPae8sBVvQTz2DKcdsvn864a0IB3IXR9q5MpYiikwVlR21SQiQL10cgWjGE9IgSo
V6J/yMsbyv8XwMSHarSA4IH2/LPguiDG/MA/aYNh6WYBbHbi0TW3itZ3azajqVmY
lxaXUeWL4kYNBh7Bzspfyv11EZfCCEz+LVAr5AwZ18O5JTxeR9wWoLhu0E7O9fX3
hMbiHA5S/mH/oeTCUu6K9rXW/G2Z1QgP5BbweuNtALjUtxeHh7lcPqb6YfRJN2Pe
h7ESFpL0sxGMYVSeXvArkXQkXGcvWRcZXMP3fylzqDgyNwiP5fZ29crbXW3S7N6v
m0VNmtVvuzh8DaGq0IBBhZgeZLolCqODwJRPZCdfHFjnHIbgfaGYVgLpbXpKyiAw
fXIaWPmvWamCGWU6QDt+emTqnluc58/jQ+03KCzVkaQJh0L3ppmk0Cy+q0uG8RDa
urTnVTNU+puR8oBlEEnfEw0lMOxTpcGf7AdfaL5hQWj/JgYPz5M=
=Y1nT
-----END PGP SIGNATURE-----

--ctrcamb2jfx2mqmn--
