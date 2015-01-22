From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on
 MIPS
Date: Thu, 22 Jan 2015 02:46:35 +0100
Message-ID: <20150122014635.GM13715@earth.universe>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-2-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416962994-27095-2-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 25, 2014 at 04:49:46PM -0800, Kevin Cernekee wrote:
> Now that the driver doesn't use any ARM-specific headers, it is safe
> to build on MIPS or with COMPILE_TEST.

Thanks, applied.

-- Sebastian

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwFZ4AAoJENju1/PIO/qahrAP/344bCXsWDwe0W4PQHH0n1S6
xKRvwF2P76dxirhxsZmYBMyNmssgRaCOjDrRyg4lBj5POyW8yV1C5RS/qBDKiJEz
eHTIG0xml/TEk36Pxa8WsvZCT9gBHNbrf8wbXK95g5h6uotHq11Fu9B+wxivBzkL
w7dYlSo8q49HxB4HYGJPvAhqxN6n2zCiIzwMiJNrZJrybRdnSiKHFO3xFglE9Awy
uqrJHS7zpS2VIImANDVQ20tiJiiQDe9xaxoMoVn5fWc4MNBODAoZ8cPVmXZp/uDR
Q0qn1jfsYGJdlz5fR1kqHa2MsegOlnqDK3xQ6gLu5otg5fUZVYWHjiWYJTpp6Y5I
qErECSY40QoBqZhBHyQaEcK5eq72AFTC86xmHmr7/yAgyBzqLZQSYeu2Y8tBEHPK
wMaCBldfC7fxJXND42LGLKbH7lDOyaIisbcQGk583M10/xdPAYBYoQtnuVkMduAb
4zrUqV4ORUUdf+Ikkr48F/09eTk0oKHKMOg2p9GIDJmLBX8yRg3lSItWYjcWIS/h
cCJzzCrXirnh99g0tWO8KkKwzEVC7jnjEJ9WSpBBg7SkL9b+DuqHWUkUCkGfDRbB
XsakBmCHTQxSrAWWYByWmqy3zMLdeJ/PgBGDA8W7PgxKfSr8BZ7h6DLxpIiONRwh
DAkBpMuQ0NI7nFcYDkbt
=FhZs
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
