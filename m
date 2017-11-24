From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS
 devices
Date: Fri, 24 Nov 2017 21:39:42 +0100
Message-ID: <20171124203940.GA12811@mithrandir>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
 <CAJZ5v0ghcwSHdrbZd_=XA=tHz7=aTUVd66dHkMYRNyXpnqP84w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ghcwSHdrbZd_=XA=tHz7=aTUVd66dHkMYRNyXpnqP84w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 05:50:42PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 24, 2017 at 4:53 PM, Manikanta Maddireddy
> <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
> > PM QoS resume latency modified 0 as "no latency at all". However
> > dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
> > PM QoS constraints. This is blocking runtime suspend for these devices
> > in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRA=
INT
> > when PM QoS constraints are not available for a particular device.
> >
> > Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>=20
> That commit has been reverted, so this patch is not applicable and
> therefore the whole series isn't.
>=20
> What kernel is it based off?

It looks like this might have crept in via commit 0759e80b84e3 ("PM /
QoS: Fix device resume latency framework"). But checking more closely,
that commit actually incorporates this change already.

According to the git log the correct commit for this showed up in
linux-next only today, which is probably why Manikanta missed it.

Manikanta: can you try rebasing your series on top of next-20171124?
git should notice that this particular change is already part of that
and drop it during the rebase.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloYg4UACgkQ3SOs138+
s6EkZxAAmGjFyXPByhGc3KiydAMFKOwvSnuMWz+ADFnA/0MCDXuPoRdHfFLeZ6c6
mqWL5+E7J9rQ5mQ1dhSotqplowXGST0ayquEqc/ECfsDVLbKBpSDKp7Z1Q80EG/d
+R2sKfDcZm9yOPVfQ6PDzRCcirkY60IEYUA/+aLcwZHa7Syt+e63rkTc3omFd0Yw
vT1/N7KmcBgCNKEJotHn4uE6Q8dGMg0dD2Rq5AQ4La0kVdQ4T964st6SfVFfQgYS
OdQpwpKiarxmRfn8+h6jfjNnTvgpJf/ni3ebxACSemqYjA1enviZmR5srioFy1UX
BgSIn2BqdcdioR1wm7HOkfqgt+5s6a9MqhLz2lDeaF1MoHCsOsF93xkTIMxWb0df
weduGaQDAFOzBXmdK2nK6wg1UXUDQ6JhiJ6VbLbWpgT9S4AYPkxrV1RIDIu0Ckmz
0U0pWAx/G3xKAbWLjRkeC34JaBcAU80Rz9ZcLs9RrRX3XOZcGeQS3dGTvvC1SY+T
iwgu4W2z+d+RQzgWySh9IGbNS3HQtw8LF0IHRMxx64k2Ka97KdhtGFKRnaSzTc1s
VET2Q9HFwqxVC7TIzuOinIp0NS9FJH6U/AbByJx44Vk+uF/m6E9u9VWCr2sU8/nH
uw9av12TpCjLWL+O/4r8SW7EcPN6bLHszlBbS8bw5qJ+h9iKLs0=
=voue
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
