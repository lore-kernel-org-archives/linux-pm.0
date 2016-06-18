From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 3/3] power_supply: bq27xxx_battery: Group register
 mappings into one table
Date: Sat, 18 Jun 2016 12:11:17 +0200
Message-ID: <20160618101116.GA31665@earth>
References: <20160617220235.24991-1-afd@ti.com>
 <20160617220235.24991-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36262 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbcFRKLV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 18 Jun 2016 06:11:21 -0400
Content-Disposition: inline
In-Reply-To: <20160617220235.24991-3-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jun 17, 2016 at 05:02:35PM -0500, Andrew F. Davis wrote:
> Currently for each device with a unique register map we have a named
> array that we then merge into a multidimensional array. Skip this
> middle step and apply the register arrays directly to the multi-array.

Thanks, queued.

-- Sebastian

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZR46AAoJENju1/PIO/qaEFUP+wUymaT65fPsoxG7NpCpPZJH
JpHIZbfE62rywzVzUpu69GBnMmzW9yJMWEDyQ+cohjNsjtiYyLnoAjc438rpFASo
P3ts27lkrRracs6Q7XzKLkTZzg1NCpOiQTTLj6lq/y9oc89yGiM4ql2AXQ0aDK/+
s6iQrnUEVDpJvfEndcAp9/fjcTIOkSFNCguIpZ87W8ipefy6JM7QsQCVpkjvnb2r
0yNRloJ834+pEkS42+M9kcWiGPSCw/uUzE817VDLg84bv3ChQw6khEWnFXBhVuvI
eU4bPOv9/CGgIWp6+C2TezJ/chxOFgSYfUgLJI5skP2nNfdWnclo3DoRY7k4W+cX
AiotWFMgbvHDLHqbmE11x+nPpQrvId9cRWlBbnEn3tFr1n5Z6qG95Ox0Kub45Rjr
ZPQhZZTZmPB02MU7c11AZYNrQ7hVlCU6CdCHNP/oX3rqH7UZkSv4Xp1eySjXOaKg
FSV2W8TkeMQFp1/gPMUmkr82bjQCoWOPz79MIM9oRbfu8Q16PRcJyaMe3oNaksPv
5PNkpaocg21q64X9JI6xehxsAsM/B6PdQ30EzRE0mFgGZSP7/CT1AMfZ6U8eOH0C
pUqE3z4p17DjsPQGlLtnyRXxX70nZ4vgLGGzbS7zKAO3B/WmXRdomBcowbFmkjsL
Mqq7q/X1AT6NDW/efCSf
=Zemw
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
