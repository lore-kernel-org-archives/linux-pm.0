From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] sbs-battery: add option to always register battery
Date: Wed, 3 Jun 2015 15:57:51 +0200
Message-ID: <20150603135750.GB18181@earth>
References: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56878 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448AbbFCN6U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Jun 2015 09:58:20 -0400
Content-Disposition: inline
In-Reply-To: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frans,

On Tue, Jun 02, 2015 at 03:14:43PM +0200, Frans Klaver wrote:
> Commit a22b41a31e53 ("sbs-battery: Probe should try talking to the
> device") introduced a step in probing the SBS battery, that tries to
> talk to the device before actually registering it, saying:
>=20
>     this driver doesn't actually try talking to the device at probe
>     time, so if it's incorrectly configured in the device tree or
>     platform data (or if the battery has been removed from the system),
>     then probe will succeed and every access will sit there and time
>     out. The end result is a possibly laggy system that thinks it has a
>     battery but can never read status, which isn't very useful.
>=20
> Which is of course reasonable. However, it is also very well possible
> for a device to boot up on wall-power and be connected to a battery
> later on. The current advice in this situation is to probe the device
> from userspace if you expect the battery to come on at some point in the
> future. The downside of this approach is that userspace needs to be
> aware of the backend of its powersupply, which is inconvenient and going
> against the point of hardware abstraction.
>=20
> In some of these cases you do want to register a battery, even if none
> are attached at the moment. To facilitate this, add a configuration
> option to try to talk to the device, defaulting to y, thus keeping the
> current behavior. If unset, the battery will always be registered
> without checking the sanity of the connection.
>=20
> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> ---
> If there's a better place to arrange for this all to happen, or to make t=
his
> more common across power supplies, I'm perfectly happy to do that work in=
stead.
> For now this seems like the logical step to take, especially since using =
device
> tree was (sensibly) shot down last september [0].

While I still think, that the HW design is bad, I'm basically fine
with this change based upon your comments. I think it's better to
make this into a module parameter, though, since that moves the
decision about this feature from compilation time to module load
time. This will make it possible to use a generic kernel on your
device. Maybe something like this could be used:

module_param(force_load, bool, 0444);
MODULE_PARM_DESC(force_load,
		 "Attempts to load the driver even if the "
		 "battery is not connected");

-- Sebastian

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbwfbAAoJENju1/PIO/qaCiAP/2jqWPSuteNgpTDiKGjYgN7x
qs7WQsudWUXfSehj+HvLsSmXPfbR+lpUi9n4lek/l+5PxmoB0m13bnpy8YeOZwjc
L6A5AD3jR0auKsZB0Z2PO7AfokLKMmKDsTwP2djqlyeZvqrS8tBv3Arz4DJmVHqi
gFPcg0kyZdvnzcFxB3fAR+MV+Gjx6tQjUHPmhsWGGw4ocHaGQ/goMRiu8NzbFH9C
7724AmxcBLicQPskByJWnQ6S6Ny2NP8rMtCy2LJy1f7yCxyw5ezR8s9afnfEq9ht
5dA1lqxOw/CMfpuKOIzJPtRrAgGw9T7KtWfOwTQ8MwlmMzXK8WGNtbkHM0qF6Dn2
WITiFdftslnawusRLUbgiuImcqbp614ihsbFpBsEcbAF1knyUMSqBcnd2r1I6PmL
21+RALweuSMyNpfX6I0E5FxPTIJ+mrY3DggKj/EIA17brImQSQbwB7c+iXPJHYfs
kJV960fvD/0HsynX3f89lkZr9OqD6mbG/LXp8mszhOcaySlPfAdmEh7vlLVPnXiH
1XYyjKpgirwfqu0IMvDw1KCWqeiE3WiVzDu/0pSqFAHlq2ltdW+hes32UHMm6no/
f3AZj0+/ZIGOnKCSmD2zWmsOjrQoiYMK0QAEMA16Rbts/svEuNIy9oeIrVNF338D
WXnF6OhXAI+2Y7/9/ijT
=/TKn
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
