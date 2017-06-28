From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Wed, 28 Jun 2017 20:37:50 +0100
Message-ID: <20170628193750.jh4vbl4x32rzvcng@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <404871495743279@web24o.yandex.ru>
 <20170526110602.jtvxf76abks4v3xf@sirena.org.uk>
 <3411811495806312@web49j.yandex.ru>
 <20170526171834.uq4ke5cm5qtobxgl@sirena.org.uk>
 <4265821495830391@web12o.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6jerb6fxjghum4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41878 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdF1TiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 15:38:06 -0400
Content-Disposition: inline
In-Reply-To: <4265821495830391@web12o.yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--r6jerb6fxjghum4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 11:26:31PM +0300, Evgeniy Polyakov wrote:

> 26.05.2017, 20:18, "Mark Brown" <broonie@kernel.org>:
> > On Fri, May 26, 2017 at 04:45:12PM +0300, Evgeniy Polyakov wrote:

> > Please fix your mail client to word wrap within paragraphs at something
> > substantially less than 80 columns. Doing this makes your messages much
> > easier to read and reply to.

> What part of the message spans behind this limit? Did you handwrap paragr=
aph below
> or it looked like a single line?

Essentially every line of your mail is overly long, including the first
line of the above paragraph.  I've not reflowed anything.  I'd guess
your client is doing the wrapping (this is fairly standard for GUI
clients).

> >> =A0What is the reason to use regmap besides caching?

> > There's the other reasons I mentioned in the message you're replying
> > to for a start...

> That didn't show how it helps w1, so was the question.

I'm not clear why any of these benefits would be less applicable to w1
than to other buses.

--r6jerb6fxjghum4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllUBY0ACgkQJNaLcl1U
h9BKQQf/eChno22COToPmVkfQxOnw7Oe3QIDnLEXcSbBAO/2ygRmWg9kd1qJXDgf
qSAQzVg2+T2Xqmdza5sWy78VcrNgNyesbulI3OjB/MX8Lvq5r58jwt+PAr1oMciu
+4waITPvbshVCHDfA5kKXqyLa8sq/7EofqPpiQxZJvfh5qWPUp3vkRewivL6XJjJ
0UzkB60FhN+ShZK6sWKmjnFASanM4ZCylXSUn+6P+I25AqHAzfI6Gyv17M4Warzy
GkAZPODshy0NEgeZE0ZKvtJXdzOO+w+t5zbncF81yquyQdjtGETLPpErWLUqFyzv
Wfg/fhZ069IbVIKpv5w3L7MV3cmO2Q==
=YYqS
-----END PGP SIGNATURE-----

--r6jerb6fxjghum4c--
