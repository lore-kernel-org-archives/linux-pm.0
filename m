From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Tue, 22 Sep 2015 21:39:52 +0200
Message-ID: <20150922193951.GE9949@earth>
References: <cover.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
 <144ec82057a582983f4ee5b3fbbde92b4f078690.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <144ec82057a582983f4ee5b3fbbde92b4f078690.1441964153.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 11, 2015 at 11:05:38AM +0100, Adam Thomson wrote:
> diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/da9150-fg.txt
> new file mode 100644
> index 0000000..00236fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
> @@ -0,0 +1,23 @@
> +Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
> +
> +Required properties:
> +- compatible: "dlg,da9150-fuel-gauge" for DA9150 Fuel-Gauge Power Supply
> +
> +Optional properties:
> +- dlg,update-interval: Interval time (milliseconds) between battery level checks.
> +- dlg,warn-soc-level: Battery discharge level (%) where warning event raised.
> +      [1 - 100]
> +- dlg,crit-soc-level: Battery discharge level (%) where critical event raised.
> +  This value should be lower than the warning level.
> +      [1 - 100]
> +
> +
> +Example:
> +
> +	fuel-gauge {
> +		compatible = "dlg,da9150-fuel-gauge";
> +
> +		dlg,update-interval = <10000>;
> +		dlg,warn-soc-level = /bits/ 8 <15>;
> +		dlg,crit-soc-level = /bits/ 8 <5>;
> +	};

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAa6HAAoJENju1/PIO/qadO4P/0gSqtT70nAH/W6+pj7w3UPF
+bk1R9D/gJLaT8MVGNCYyraGhZRwZVw5hZgtHNophuI5Ny8hTG5FklhN3AES/zzP
Ill48l9X2lrVOjSkodPpjo+1sLTYJVuUHyf+K7ahl37CD3brcCZJMhtFuCftr2Y9
MSwuybmI9/1NFaFRRcI3fnA7So0u+/Y8JPDt0iVV2Em3uVpFtrSKcFhqBh9BpyAu
lFzaGoeGOgEYJHxwMAabQ8ZleTQYoKoBAkptW/yDHfYChd4nIqRehDh7ueVhbEnV
MsT5rwkYsEqSP/YqrptovYlfuvrchK23n4YXqAL/zCh083HFKN90BNyGON9LnBoG
qIbToowULzFz6G6DqK54BN+ZBdGupyQukAoFmfShk5eon0+zYwmlgupmgehP6y0v
7reBRw0tweQdU5jhoPrOwmu32GyIZWvccCxxwqRCyzVCMZ91dEPFkg2qRwKQs5Df
WgZ9ineLczobezQCNBJXqTgvwjpKmMTKVu7sjMPZbyTmjKSv2JilHEDo7oIMAcvw
JfVFdjgEqLUNj2m/wmm2xWDVq0rlg5JmpPiazHZUe4GCoZIiXV9CB7EnY2gzrDWT
7Y/4SWF/ZLqEZkRXHgcoS94/VWVNDZRH9KzbU04ncBuIP1o2EO2727BOhM8/s47G
DVbsoO/5VdFiHYYyMtO9
=O/oW
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
