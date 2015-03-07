From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/3 RESEND] NI Ettus Research USRP E3x0 soft-poweroff.
Date: Sat, 7 Mar 2015 20:53:56 +0100
Message-ID: <20150307195356.GE5233@earth>
References: <1425507949-30499-1-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425507949-30499-1-git-send-email-moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Please CC linux-pm.

On Wed, Mar 04, 2015 at 02:25:46PM -0800, Moritz Fischer wrote:
> This patchset adds support for the NI Ettus Research USRP E3x0 SDR's poweroff
> functionality.

I would prefer to have a generic driver like syscon-reboot does for
system reset.

-- Sebastian

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+1dTAAoJENju1/PIO/qaaEIP/iVvqPUkfkRm6Q82+1SDOw46
rcEAeFA+qRGxsksVzrjCxCwXBYsvrgpmQjTazIoJV7PdRW1TYLqY1nisIHM0hWiB
FxsJIiMUpPfsWIrziFUeVT0/GS+xhSbztaKcw/oim/LVYtsGZxHbirF0YBKGG/Y5
63UeupkSn6NFjqJjBlCWMkTdrP8ZpZsuShiVmKxuHKXWnZElxVFPzx/t5u/yC7EH
x1zZlbJAbL0GuY1/pXsJ7s8870CVrtHOC0rxYXhnohsFlGnQefCbrMKLr5EiJ2Ww
TvBuN7t/fMHPeb3usigQWWkuDinMMRzKF2urm5AweEMba1/kf29EmAxYCgL3IuFR
upYQxAGOgbEVrNXJyr2ndVRmgqdexURdfrtBu2lxlf8OkStoxqdZoYRYzHwfjCka
2tdSLC5WwoPZnZLIExirG0IrRCUKJ5Py+wfMiuhOqBxfIhhDNvbbHfnKP6zNK50G
Hxds0QQCcLZ4Obes8w6S4Qq0wrTCSXXn9THGPBcr69Ca8tlD0QuEQzZrSbnGGYC0
u+1sOQr1wDR4Jv70IKEz0MZDrfIZO6cNztB7/LvfHd/jP3QXwtJ4ElHhtSX+g8kv
6tmH0UaKnQZxauyybqVammWUWiUVuvGzB1LLqTVFI+gH86vhb0e9LJ5Vc2bgIxZ/
uQzhmoLQ27OROVVuqxa6
=QVnN
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
