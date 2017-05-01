From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Mon, 1 May 2017 13:29:48 +0200
Message-ID: <20170501112948.vbri3rbjoyyqvcbg@earth>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
 <20170418073421.31351-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2571046341349469091=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170418073421.31351-2-quentin.schulz@free-electrons.com>
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


--===============2571046341349469091==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bysmusjtmclsulp"
Content-Disposition: inline


--3bysmusjtmclsulp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 18, 2017 at 09:34:16AM +0200, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>=20
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, queued.

-- Sebastian

--3bysmusjtmclsulp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHCwACgkQ2O7X88g7
+pqIDw//WLuEEXxOJpjzWIm5p7j86mZeDuL7sOrvHVCj6CS0vVBn0wdIsRCMw2qI
tF9yKAVTb8BP64ygggoriTENl2jHo9fkozfFg24umMkH0ODzOU5aSj42hEjeQmp9
lDP+Nu8fu8WBYFUc4W4HNDvOoBBi4Li78paqVf3+98q5c2Lorn++15p+hgF6lVq0
YC8tBAExxN44zMMRWNiHYrrVsLHnavByv0HEMyNvIvBQvA0GvYlzyDpIMNXTdEtO
+S3C293QqOEJGLtTPDy+fTS2vxLPBSo2OPvqdEi6GNiDJpbPZMxXNICKXPo6ZczR
bJMn3Kp5qArCplpZvFbbxLinjAoCdYxLCPFLjDr5JMrsTMdCckLy53C4PxgqI1gj
tCD9qWTxUpyZIO7izVGOtCuFPEm5hrEuoC/4/TeJYjRNhdXg3JCj7iA1Cwy4iXFC
1mXeqjdq6XTsiJWeWXl/P+1FuJlTFYVOL0dJl2CGDSnB52VqH71++SRh/1lxYfcJ
BYWmVmCPfr933AIQuID259xoAlhajiOvWbV4567bJgsXWequDV41Q8NHqNcvp82S
Px7SltnhbLgc0WZ49IyfuhFOIZ02xSPnXH6v3Bk5oxEIfc7pZUNPE/+Z2UOAJtNs
ygeqnXXsueiivyTOJ9/E+AMJCU9I/S/fbYxvQx2HgzgKj+V4454=
=3Q8N
-----END PGP SIGNATURE-----

--3bysmusjtmclsulp--


--===============2571046341349469091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2571046341349469091==--
