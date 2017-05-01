From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v6 2/6] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Date: Mon, 1 May 2017 13:30:19 +0200
Message-ID: <20170501113019.gc4mblrwvyd7qgv3@earth>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
 <20170418073421.31351-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1654141401824196722=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170418073421.31351-3-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, liam@networkimprov.net, linux-sunxi@googlegroups.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============1654141401824196722==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvha4q7cvppd2htm"
Content-Disposition: inline


--nvha4q7cvppd2htm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 18, 2017 at 09:34:17AM +0200, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>=20
> This patch adds the battery power supply driver to get various data from
> the PMIC, such as the battery status (charging, discharging, full,
> dead), current max limit, current current, battery capacity (in
> percentage), voltage max and min limits, current voltage and battery
> capacity (in Ah).
>=20
> This battery driver uses the AXP20X/AXP22X ADC driver as PMIC data
> provider.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Thanks, queued.

-- Sebastian

--nvha4q7cvppd2htm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHEoACgkQ2O7X88g7
+pqeOxAAjFTdUYEQSYAyhz/w78B3VDU58cZAXCtrCjiP4myZWTGrmCGkYR3Fze/K
fhs1iZwIuOZu6BQ0LLjT6BJlLCFgBtxwLXwEUdm8wb6q/+/3s5rVHIwrcc9DL779
Gh+T5JTGtN1uWwZ6k5rRzz/9c1InKksTYpwdJvM7cHyeFKNk2dBY3MKI6YYTNyww
vDjf2Yklie8ayxW/0nvZW7nKb0HxE/LDhHIBxGRmHwTvTyYdnzeecK6zufFl7Oti
hXqXPK09XUl9yoHYTb56sZVP0NTQIk0d7iZpzgvFWEiEQnWvLuOuBsMo4Mzp8r2R
LATXjqOQSLRURkPCz/8jujhO16iaBcq4hOxc1qGCaRS0lNnCh86OfAVN4CZnFys4
SdQUsbcRKUiYTYMz5h1AkKLAv5fq+ZMH3tIsHR9s9ZvoyhVdZz4PrtuBoFeRqTem
6g5UBKhkqGSw89fVePxeGgJymqFwnCe99nH6Wek/cp5DDUvkGCOykKFMooceVbOi
WL4elMd8DnmXVeoQfrkxs6vvWtRhD3shgNYNY7F83/pMRUsfkRwSzGfvtD1tP+U9
Y8hvvWc0++gtlna1PmmLrTfMW0eHSp/NGQp+o/GErgyyeBzLU5nS065FNzGluYJf
TLXNnN3v//QUte3qxotgbM5uGVz9dHtsB9QMJAyDAEz5/llHfzA=
=27d6
-----END PGP SIGNATURE-----

--nvha4q7cvppd2htm--


--===============1654141401824196722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1654141401824196722==--
