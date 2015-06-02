From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 0/3] Add support for Richtek RT9455 battery charger
Date: Tue, 2 Jun 2015 21:27:48 +0200
Message-ID: <20150602192748.GA13930@earth>
References: <1432909545-31895-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53933 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbbFBT2R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 15:28:17 -0400
Content-Disposition: inline
In-Reply-To: <1432909545-31895-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anda,

On Fri, May 29, 2015 at 05:25:42PM +0300, Anda-Maria Nicolae wrote:
> The next 3 patches do the following:
> - first patch adds Richtek Technology Corporation in the vendor-prefixes list
> - second patch adds device tree binding example for Richtek RT9455 battery charger
> - third patch adds the driver for Richtek RT9455 battery charger

Queued for 4.2. I slightly modified the DT binding to specify the
default value for optional properties based upon the values encoded
in the driver.

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbgOxAAoJENju1/PIO/qaDS4P/2SrsMlfMOOxkhn9igp9/Rnt
m49GglxgJZY6d/vLpBXYOeR7zsRxsOrpQq6wo3JZHwRYnlx4y+/IHUMNpQ+mfq7a
+cmxAcnSXJHnf/GDT0a/hSACXZnJa/0bhjePK+7S0ns88hZRNsJMNXInQZrc2bZC
c7O4Ipg0oy/Sg4Hg5Ty3s9zr08IzEe5C4aeQV/1WIp0XuAwDerjIOl+075caiT4S
F4wZejBzISRkIKLCxWaEeHv5JUsZdV/9IYQV9DXWpKHXNQud59/IhF/vLA01Cq5K
GEP2Wn1ngFMSNcTBSx3bCzIUmVr3CLDUeLj2Eb0bSxrkfqPBGMRF6oYqHy4/d+x0
3tDcTSzinhIDamLIUE4xn3fLaaaDooN2RQizXIZLVsFOBTHlNfXobsxbxxG/+CE2
GECmZHTbmerXeJR+GFXwi6ojUY9BX4N92X3Kukr2WSQNibX/qksn3nQ54oxCa6dC
hjMKf/1/YtKZoYmWEb74Kn3OhVpLXlKktmSnTx6IIGcOQA7oHzhQYgOgGL+MESwf
ByczWXQXFGWtOC2zrHetmeoe4nWXZvblw64Ya1OgYfjQh4VYPEtXMugQkQPBWWxO
hnDdpDvgSCkEN+yXfGGodBrgCd+Sj/hRXCi9ksGuIJErGGx3frsMa+VEIQLY34jQ
laOKLkj5Ck9WXo8rhgqi
=CO4i
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
