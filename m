From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND] power: bq24190_charger: Fix charge type sysfs
 property
Date: Wed, 5 Aug 2015 06:09:39 +0200
Message-ID: <20150805040939.GD16139@earth>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45219 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbbHEEJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 00:09:44 -0400
Content-Disposition: inline
In-Reply-To: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 04, 2015 at 11:36:17AM -0500, Andreas Dannenberg wrote:
> Access to the BQ24190's configurable charge type property (none, trickle,
> fast) is being masked by an incorrect power_supply_property entry. After
> applying this patch a new 'charge_type' property will appear in the
> bq24190-charger sysfs folder backed up by getters/setters already
> present in the driver.

Thanks, queued.

-- Sebastian

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwYyAAAoJENju1/PIO/qaQNwQAJBUWVHV87sd50EXEuWQ17ct
CNgGfEPK1Az1+J16xKOPbomExGSr0tQc/R7nNeqZ1dwFuKsD33G5lzPavIjJt0oh
FMimqen5+B81TXkhQzA2WFAXGszyKy07aIxbnAk2MT6aMgIg09UAqWSoTTn3jDlh
4uSe+C3un+TmH+F8qjQ1euxuwVHzpXf5oNhQxoRn7KV0DA50SGmEOIBN02ytpUWi
hTTHstnz8OGy28JrT8+XizGfUAVmb2wFMgO4+4JEY4XtkaE4XU/uyudJfVitXRJI
cyvRCZKcFPYUXtG4ulMcJN28aDoRPo2Bjq9dHfNbxray6hqFLJO1+wY1uqPAqY+3
lPfenj2lp1lXMQYJ3+sgwdkgI06XIgjezaQg51yQyAlPvg+8BOlZh8782Abl8oHW
141g9FWzkqmHk79XyRn4XuIrgjFYdRCZOM/MwvDW3ifDFtl99bIlKNdbAVBLzCNU
evnJrP9VN+XU+Z/dshDyP2FKgnTDvOb8h9m7lkc6X35ZZtt6fgpQFY4O7SXnHTzf
CZLy6Nre1rK/JE0jo15D6ydnGeOeHcGfBMoFr/ZKpE6Mb3ocpXMePAS3frRiNovv
wwuTOoBAWucovQuYt+IjTK8bcjOtMEjuybqMSJEq0b1+dkT3F4Qolxd+KzBVwJoW
UmiGvATnfZXT72+mRT6e
=F5JE
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
