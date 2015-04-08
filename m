From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 07/17] soc: tegra: pmc: Add generic PM domain support
Date: Wed, 8 Apr 2015 10:06:31 +0200
Message-ID: <20150408080629.GB26974@ulmo.nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-8-git-send-email-vinceh@nvidia.com>
 <7h1tjwx4r2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0253452566560478666=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7h1tjwx4r2.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>
Cc: mark.rutland@arm.com, pgaikwad@nvidia.com, airlied@linux.ie, rjw@rjwysocki.net, will.deacon@arm.com, linux-tegra@vger.kernel.org, thierry.reding@gmail.com, linux-pm@vger.kernel.org, gnurou@gmail.com, mturquette@linaro.org, Vince Hsu <vinceh@nvidia.com>, ijc+devicetree@hellion.org.uk, viresh.kumar@linaro.org, tbergstrom@nvidia.com, robh@kernel.org, devicetree@vger.kernel.org, jroedel@suse.de, pawel.moll@arm.com, swarren@wwwdotorg.org, robh+dt@kernel.org, bhelgaas@google.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, pdeschrijver@nvidia.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, arnd@arndb.de, p.zabel@pengutronix.de, galak@codeaurora.org, tj@kernel.org
List-Id: linux-pm@vger.kernel.org

--===============0253452566560478666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 03:37:37PM -0700, Kevin Hilman wrote:
> Hi Vince,
>=20
> Vince Hsu <vinceh@nvidia.com> writes:
[...]
> > +static int tegra_pmc_powergate_power_off(struct generic_pm_domain *dom=
ain)
> > +{
> > +	struct tegra_powergate *powergate =3D to_powergate(domain);
> > +	struct tegra_pmc *pmc =3D powergate->pmc;
> > +	int err;
> > +
> > +	dev_dbg(pmc->dev, "> %s(domain=3D%p)\n", __func__, domain);
> > +	dev_dbg(pmc->dev, "  name: %s\n", domain->name);
> > +
> > +	/* never turn off these partitions */
> > +	switch (powergate->id) {
> > +	case TEGRA_POWERGATE_CPU:
> > +	case TEGRA_POWERGATE_CPU1:
> > +	case TEGRA_POWERGATE_CPU2:
> > +	case TEGRA_POWERGATE_CPU3:
> > +	case TEGRA_POWERGATE_CPU0:
> > +	case TEGRA_POWERGATE_C0NC:
> > +	case TEGRA_POWERGATE_IRAM:
> > +		dev_dbg(pmc->dev, "not disabling always-on partition %s\n",
> > +			domain->name);
> > +		err =3D -EINVAL;
> > +		goto out;
> > +	}
>=20
> You're re-inventing the per-device QoS flag: PM_QOS_FLAG_NO_POWER_OFF
> which could be used here to prevent ->power_off from ever being called.
>=20
> Alternately, if this really a static configuraion, why even register the
> ->power_off hook for these domains in the first place?

This isn't really a static configuration. The problem here is that there
is code elsewhere to deal with these domains. The CPU power partitions
for example are dealt with in the cpuidle code (or PSCI firmware). What
complicates this even further is that we have an existing custom API for
enabling/disabling power partitions (cpuidle uses that API).

Although, thinking about it some more, it seems that for the purposes of
power domains perhaps we should just not consider these power partitions
at all (i.e. not even register them).

[...]
> > @@ -831,12 +1405,19 @@ static int tegra_pmc_probe(struct platform_devic=
e *pdev)
> > =20
> >  	tegra_pmc_init_tsense_reset(pmc);
> > =20
> > +	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
> > +		err =3D tegra_powergate_init(pmc);
> > +		if (err < 0)
> > +			return err;
> > +	}
>=20
> On many SoCs there's some special handling for the !CONFIG_PM case here
> such that all the PM domains are enabled by default in case they are not
> enabled by the bootloader.

Yeah, I think we'll need something like that for backwards-compatibility
with the old API. Converting to power domains should be done in the same
step as stubbing out the old API, and then to prevent devices using some
old DTBs to fail we'd need to enable all domains that are currently
controlled by existing drivers using the custom API.

So we don't only need this fallback for !PM_GENERIC_DOMAINS but also for
cases where we detect a DTB that's missing the nodes to describe the
domains.

Thierry

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVJOGDAAoJEN0jrNd/PrOhQF8QALXKznlLZKBA7Y8c8wtFOt2f
cS53eyzd96dYajPO5ZbM/OeJZnINqrUm4n2h+fjBjGbvMGMztsP32CJbXbGBCC1o
YfIb+uAhfkyNZj1BEWu3zm7HxVp4JAkWgh6U7zeM8WB+rbBCu1Bzrbu8GHtklTp9
eJNPikOugXoILrOJiXK6Un7flH+70gxY6/fpVl7QlOtmRU3ST/pxpHb5wEPcM+BH
7M2tlI7+gO8SASIzaS8vwzPdNoGr3iBU2BtW8GnSwxj4u75PlzsgQdKEzPCMXXuA
kZDWMHt9iWTYOQTT2vVRZmGQ2csgFQxIWADl067mFTBHvARJ6XkCqv0DOqCjksPm
wrryeCabcPyBjeZqP4LrU8HioGSi3MwjLd49MyD67n3KNr0sVm+H9YUCPNIiMbCH
h5fp66gLOyAol30fSXwUtdsb/xcJBMOsxkx7HD+YsEJajLWBvAcTlGK7zkuWPAWn
mKF5DITTNh7498Go9VDz7Cm1XZ28la3vjiqJk7rZQvsWu36unki9nu1C2nYlaFlc
DiW4ftoVM4mrinJNt//QR37mBG8AnPx6Q3Ahmn1ub0sXDNBlQNzpwMHpVybNLkpp
d7nu7dgh1hMntllM4Fb1A8Usf8aVHOtwn+ZKIMjFK54LCVHbQIaSvt6lUMpupw6L
A3trJ9UjEzhlB6m8xgg4
=x5Am
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--


--===============0253452566560478666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0253452566560478666==--
