From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 02/10] PM / Domains: Add function to get the last
 domain added
Date: Mon, 29 Feb 2016 08:04:53 +0100
Message-ID: <20160229070453.GF23745@ulmo>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456501724-28477-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 03:48:36PM +0000, Jon Hunter wrote:
> To remove generic PM domains in a sane way, we need to remove them by
> starting from the last PM domain added. The reason for this is that a PM
> domain may be a subdomain of another and so we need to remove the child
> PM domains for a given domain first. By removing PM domains in reverse
> order we can ensure that the children are removed first.
>=20
> Add a new function to get the last PM domain that was added. In case PM
> domains are added by more than one device in the system (for example,
> on-chip domains and off-chip domains) add a 'owner' device structure
> to the generic PM domain structure so that the ownership of a PM domain
> can be identified by the device structure of the device that added it
> Use this 'owner' device structure to return the last PM domain added by
> this device.
>=20
> Note that because pm_genpd_init() simply adds each PM domain to the
> head of the gpd_list object, list_for_each_entry() will start from the
> last PM domain added.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This is the outcome from a discussion I had with Ulf on how best to
> handle the removal of power-domains [0]. I opted to call the device
> structure 'owner' because 'parent' could be misleading if a power
> domain is a child of another power domain. However, open to suggestions!

I've seen "dev" used a lot in other subsystems when an entity is
provided by a specific device. "provider" might be another alternative,
but I don't have any strong objections against "owner" either.

>=20
> [0] http://marc.info/?l=3Dlinux-pm&m=3D145460070816340&w=3D2
>=20
>  drivers/base/power/domain.c | 25 +++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  7 +++++++
>  2 files changed, 32 insertions(+)

Besides the name bikeshedding, the change looks correct:

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0+2VAAoJEN0jrNd/PrOhhAIQAJVj3kss1aQhiuEVhoSjxRK2
O2fJ7fNSFfYreZyohh1VvF39OroJWvPU6hQGS60LMJjYrjTlL2YJGvNtxy/3uTGz
5S95CqUWumtFImnYDCxv9e5xNO3PZTKhXCeUfGusHGej2up738g6KQ1OydmVvEhN
LtdkmAXK3YIhXj8m1lVlGKjGFxM68S0eKEaOR/mVA0OaBbPvY2q1q2ynUtmt5Brz
fOKxmS7uX2QJTRvT0Y1fnxRshsw5mJT6bOyZWV1Hm8cme7R0OT2dy3koG/8hG2wX
kVfkq1d931UYYTy2k58u5NfORF6SAGRNlvn8X0tRnZBmHir1CIY1HkN7mdQoPbNg
jiNxYIpkV3rstqN4Dl1h4Ikf9vNS4OBJc0m7H5Iz7LLmGlAyPPFsLHAYU4h4PwLn
8nle06nhgITo3w/FWshxSENZb5h5ez+qQFPQS192TO2IJQqVvN41rBi25r+4eOys
NziawFa0/TMoAIondon6/A3bQoT15pfJa2UiIfPWVKzFM9TejkM4C+DwKdGTPWyN
mlXRPbYHItv8meX27OwR0QpaG5Co11xYxTXQns+IWUMMOh75hmnhygMpiyvWbv79
B1Q+RZ3VraYtIK1suKLAZ2UlknxXdnL3Qbw4Zdn+Noo+G9llEB45It8BC4o0I1eQ
F2mHbGx1nTI7c4Vc7rXd
=vEIl
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
