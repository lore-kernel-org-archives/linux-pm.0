Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B2382373;
	Thu,  9 Jul 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604932; cv=none; b=ckcGyuLn+NB6qcxy7+wHsLH3PW48tI6pBPCSZ1cjZPIynFFXBm4eXNomuhMtAPIr7hzXjS+a8QC6aEJ5RSmjA3SdQ1ZPDWMz2OrRajNT1Sz7j2gLy6h95Ttw5IBFJ6cW1HfLmgdMyKqt+/VS3M7TaslW39Iv9GENte1K9BBi7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604932; c=relaxed/simple;
	bh=K+LVGraXAMblh/wS3bFKCf1Rotn9jKdnH5k+fGzPHRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVMr+QP8eKPGGpjWkJgkR67pMYcVCG9wdcFoL/pU5WxOcGgRD7MAKDIjiIRwzK3jKkJW4nrYqku5NqjIF9sZh1U61zjvPgzaLMFpYxkyx4Ac6Fukb6BpXfuUOu+UbA5AUd5ApzX0S01H6ggRB+JXrcH4CU/zDVfrVdvaowAprsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I59NSzva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I59NSzva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AB21F000E9;
	Thu,  9 Jul 2026 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783604930;
	bh=K+LVGraXAMblh/wS3bFKCf1Rotn9jKdnH5k+fGzPHRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I59NSzvaQxwTdYf/ydnUSsp3J7DRGD6vuGADrtJX3lWUUqErsp6d6+63BaCU2UH3V
	 q9i0SATbBbTGY4RuXl/8pyesWUhMIhjOoL53RMDtqdAUhVElEm3TPWrOmWent7AISY
	 U19kiYNZLe6XkO+rAPKDIRyhqlFQEKFTMUdtVk9nzDXYN2QNkboKu5KMB6h67J/qAX
	 5AWIXf1rUbdA38oscMMdV4R7ETds30jthSI7xq6ilNGfe1DH8Vd7xLeNN3d3dzTgGj
	 EmdXIlZNa1vL4OQeCpQZY4L1IxOauswZHU4kCZHv0NLOzZyltr7bONZorKx4UUTnV1
	 zUeN3v07P3ZzA==
Date: Thu, 9 Jul 2026 14:48:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
	Alex Shi <alexs@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <dlechner@baylibre.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
Message-ID: <28cc462c-4c65-4de9-a9e2-965646eb4c83@sirena.org.uk>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yR+snn5kvWfft1sV"
Content-Disposition: inline
In-Reply-To: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
X-Cookie: MS-DOS must die!


--yR+snn5kvWfft1sV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> SCMI server from different architectures than ARM that's why remove
> ARM/ARM64 Kconfig dependency with also remove ARM from description and
> rename folder to reflect it.
> From specification perspective only ARM specific transport layers should be
> available on ARM/ARM64 architectures.

Acked-by: Mark Brown <broonie@kernel.org>

--yR+snn5kvWfft1sV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpPprYACgkQJNaLcl1U
h9BuZwf7BOfh7haRASNEf+GyM/vJ8Rk5M6i8yfFXIOEaCoBhABZ8W1qPGH3D9QB6
j85LaXzp5x1NmpHyO1zPkfENzIT8rDMO3sNcd2V1i9UbGT5EZAOjkvFpEAiUbDPg
6vmqmlrPHzncOhGwzSsjgbGIrv8q6IDUKZCPB1fFjuBJICagQCuAQ8onuA+RLmMH
mCYg0dJz9kljPFTkBn0UXgVnCBDyR0em/jBJoFVGQqmNEuAit/KicZ13TP6+ApXP
fsZpWN+9x9deYwe20wbBAoZ6dpnPlv86m1OPhEO3WtcoKmnXLo7onCWHsRAKLJB7
57OJGcXyJz+mFT2Y1Clm/wpPUCck8g==
=gvbq
-----END PGP SIGNATURE-----

--yR+snn5kvWfft1sV--
