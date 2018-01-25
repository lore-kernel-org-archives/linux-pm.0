From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 5/7] PCI: tegra: Add loadable kernel module support
Date: Thu, 25 Jan 2018 15:27:59 +0100
Message-ID: <20180125142759.GG27888@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-6-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515650888-9459-6-git-send-email-mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:38:06AM +0530, Manikanta Maddireddy wrote:
> Implement remove callback function for Tegra PCIe driver to add
> loadable kernel module support. Change PCI_TEGRA config to tristate to
> allow pci-tegra driver to be build as a module.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> V2:
> * no change in this patch
> V3:
> * use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_ini=
t()
> V4:
> * no change in this patch
> V5:
> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> rebased on linux-next
> V6:
> * no change in this patch
>=20
>  drivers/pci/host/Kconfig     |  2 +-
>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpp6W8ACgkQ3SOs138+
s6Fc7w/3dNRRNw4XT4DU/vHGkt3/ajK4yWAXdyX8aI/+cJcNXQVwRQGBDI2ukbO1
IMTW1FwNwnzq3vSgl6Hk6OCz8lQaV6ohlq81++k4Ruw99JUJjTl8uQytXO8GOyDE
OFzMSSQS+Mdod3oiKH7IMlZ/y5uB8m4IIzkPXghMDw0GzWtT5q3ss+iywYzEu4jU
KtkTXeIC+ju/xVuNLVV2v/u1K5aPei2PLOReteDc5qd5FWl2UBibbUzWHSZoMDwK
Eqdp5/2s0NlOA+WyZN2qjUVENXJLqZkl/07G0o6LqTjT1VM2N5fbQ2472WCku2WO
qHGtqN5IqAg2CHBbmaYjCBF52ymiHOax2X2x1jpZFlHR9MxQq8MC6HSlBFR+KxaM
G9wKwqudVZP7K3TGwEyrH38JX5CP+DdwQOFjjGmJgWMv0VYkCIG39fp9rax9SRcC
/VRQC9NkpjkBTtVSIygT1PWGrLGn8emsvbM4ghLpm5XbSIs/wsLKS/yglQLbxsG+
iNxMsBE8VNQfbiY8Rrm7jUfVl8pO8/7/1t5d3ihmR9UsGTGK4rZMcvePsxWVYTe8
OxmEVEMAoq7CXmP2bFgOK8u8DdwCaLB2G1rFtYMlwCf05pdJyIFEZuv6FCN3KxSZ
jYrzDB/YYg+LZQua3f4dyEdYKYW5b/fohNY54DGfavKk/NUQQw==
=u2+G
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
