From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/9] power/reset: brcmstb: Add support for old 65nm chips
Date: Thu, 22 Jan 2015 02:47:18 +0100
Message-ID: <20150122014718.GO13715@earth.universe>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-4-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B3NBd8mrXZtPJEYR"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416962994-27095-4-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--B3NBd8mrXZtPJEYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 25, 2014 at 04:49:48PM -0800, Kevin Cernekee wrote:
> The register bit fields are a little different, so add an entry and a
> compatible string to accommodate them.

Thanks, applied.

-- Sebastian

--B3NBd8mrXZtPJEYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwFamAAoJENju1/PIO/qabr8P/1ea3h4M0xKnteM9XGvGal8q
BHAQBk7O083ZW/D4qhdxJyy+X0Wq/9/CiYVNsJb4xqDMDW6lpVp2V7EI0XeljjhU
Q171ZNF0jr+l3PiTyAL03yacpWzJ/QPZReJFwJCovN+/JUnVrz1mMzWFP4U5RyMY
TwtXIc5DiAxuwVv7cfc4sst+zGzSZpsRNToNQILUf9MIFozjiNUtXP83Wcn+Oj0I
lJ3YVtazMKwvpfN5ZAJ7+llZ2ye0rtr8pY6Pi/Okb0O8Lco6N9m3RCdti9nq3nxw
YuJVgXxj9bj3xzjAXMINx1HV/yMdL3Z02qSzYaEWZJq/5h7Kk8ZadmUcXEi9keZV
u3j6HJBcF4Mbh7Dbx227btBRmJUXTui57ssze4QTUxJ1gCilX+lsZEuiBeDC/XwB
G/UxxYVq+2tpwlco97wZrW6DlljmrLyiMIlgSqfwb602ulunuWdJRvr8BzadFraU
FG+jgYEEfz/w7sSzCuaPoGLlhc9C08CPowzDbn4PK6ubAptem29Uz2mulknEpUbs
pa7qGDRTyXsoaLnquJJReDc5VkqVerV1aqmQ0rSlhXeMpzJDuhm+/4lrpR1jVRL0
RwyqVbYUPQddAWU9rtWL7SBBmWqaSqAGbi8rmKSmqDuUsqyeSS+oJpCOkUP5sNGP
UxmSuEUsuDskeTxzKPYO
=Ix8s
-----END PGP SIGNATURE-----

--B3NBd8mrXZtPJEYR--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
