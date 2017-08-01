From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 08:36:42 +0200
Message-ID: <20170801063642.GA1839@light.dominikbrodowski.net>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
 <20170731221645.GA5871@light.dominikbrodowski.net>
 <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
 <CAJZ5v0hMdu3hZoc4YOE6YteHLuXkO7V63cTiCbBENBGT4cLp2g@mail.gmail.com>
 <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alexander, Rafael,

On Tue, Aug 01, 2017 at 02:05:22AM +0200, Rafael J. Wysocki wrote:
> Actually, I don't think it will make any difference.  Please check the
> one attached this time.

On Tue, Aug 01, 2017 at 05:25:03AM +0000, Usyskin, Alexander wrote:
> Dominik, can you try comment out "if (!pci_dev_run_wake(pdev))"
> at drivers/misc/mei/pci-me.c (around line 223) to set domain callbacks by=
 force
> to see if this is indeed the case?

thanks for taking a look at this issue. I have tested both approaches, and=
=20
either works fine and solves the issue. Which approach is better I cannot
say, though.

Thanks,
	Dominik

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlmAIXcACgkQmpdgiUyN
ow0xxQ//T2+pZAUjVhFy+KMAoXyZsx5je6y4GSq40a+IsFRQuo3Cblx6dCex2bo9
CdSv1llMXQtICL1StyNL3+Q5sHu3h8AQvoPa37lYnNkJPzJVsGDSDtqyfYvCueaJ
TYFyTtrWhPlwCO80PcIb04uzLTU0xbGSV3ECPvs5zlgh0Ws8uurI3QZsF3hfZL3g
PGf4zrkpgQ1CRC1qXaVSLLPlW8lTw+0uVzPM8aKmK0cNt1md0Schan44XAOa0AdF
//uZxaAN3mQ7CcfzprE8IdNxgpbrK88xjwKnu15+SJJxSwVb/1mMXx9tve55JE93
+ctOgXgcPIdCaijJGT68LW7hQDJtBlZcULh6/FqvdPe3jX1Zss6Gxb7SASUL/Ry3
l0kWhJpx5h3rcXxmwgXe+0g24jnZyqgisS6eE0K9C/6+1GD4XIhbAtL2QsW1FxsH
jM2IExFT9GlCYnxzeLpzMZoehAxZNHJxYCk3xsEQm8go4JCL5iKerw/n6fz44FNU
U5m09ghbgYYdsKJwvldsjAGzRkCKqeVlAYv4GFc8XzfBc65fm48iL0o8Rao02j48
VC2VK+S88BRwj+ml1mtAwTvr8Ng3WIe7LTAC8EvcKPfaObXPRKHUn2rArgKHovuB
Eg/Sd861pVnsMDOkfKsC2KrJhHp0uShWVGK84f7e1IVn1wD5vCA=
=1iPQ
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
