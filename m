From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Tue, 22 Sep 2015 21:16:49 +0200
Message-ID: <20150922191649.GA9949@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44544 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758699AbbIVTRA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 15:17:00 -0400
Content-Disposition: inline
In-Reply-To: <1442612399-341-10-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 18, 2015 at 04:39:57PM -0500, Andreas Dannenberg wrote:
> This patch allows reading (and writing, if the D+/D- USB signal-based
> charger type detection is disabled) of the input current limit through
> the power supply's input_current_limit sysfs property. This allows
> userspace to see what charger was detected and to re-configure the
> maximum current drawn from the external supply at runtime based on
> system-level knowledge or user input.

Maybe also support writing into input_current_limit in auto mode.
Just disable auto detection until "auto" is written into sysfs node.

-- Sebastian

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAakdAAoJENju1/PIO/qa/3gP/A0kJEwEhtz9Lq9ERZII/ZVY
F11Un9p2toukmtkvK1bY4kT4jx49cRlcLA0TooqKujyAt5A2AhC/SRLi73FDT2Tu
+gTskBDRxhyOSxLvLd5o9K2Tk+hBy9ike/2KS760Foxg9CByAUie6BAchcy1eY6t
y5I2sWBKgO8+i3rz/B5MpfvhSxY2DNQeRq1FCH0Ks/kHuYInSynMFXPtdhCkQ/iB
G271fptummqPxjYoZgsRlYpyIs7DEPqZGmKBMGSIIEABTS35MCOrB5q3kB4cZZ6V
uZu80aCbZGHl6zXuKfqiIiAQIAMYlyxHwNZq7lHwfeJZZq0ISwsO7Y+11M+CQ0/R
4Y4VYYA15sxE5xdamLhsxitUTyJWmz2QutfuVb86IlQ5i7UL41YyLFoo80bCok0Y
lwvWsZyh32jLxOW+gD03aWmMdb+GWv2fCUdG0v60CpyjZ7FQiy0GF2k2WN41ijqg
1DQumkspa+Y3ad5JuVoM/B5Vb3F5QLb6fuH0KhE1P0OSxTCzaFuoN9l5mqDK9Z4l
TPRcL1mYt2mUhl4HJ+scYcve0txbFQ354aYU5jDfa3nepR4CCSaLUhtb10Zpa9Zk
jLf6MkB4w6OMtbbkI+me9WVwpXnHryegFaHFzQ1j3egVXsxYHb86a5mK5eGUqofs
4W5BDXhC4/FWRpm3BHRp
=tXYl
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
