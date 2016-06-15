From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/8] arm64: parse cpu capacity-dmips-mhz from DT
Date: Wed, 15 Jun 2016 14:49:38 +0100
Message-ID: <20160615134938.GA2282@sirena.org.uk>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-5-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qcw+NG9yjQzXdZsc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465985877-18271-5-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, sgurrappadi@nvidia.com
List-Id: linux-pm@vger.kernel.org


--Qcw+NG9yjQzXdZsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2016 at 11:17:53AM +0100, Juri Lelli wrote:

> +		if (!raw_capacity) {
> +			raw_capacity = kzalloc(sizeof(*raw_capacity) *
> +					num_possible_cpus(), GFP_KERNEL);

kcalloc()?

> +			if (!raw_capacity) {
> +				pr_err("cpu_capacity: failed to allocate memory"
> +				       " for raw capacities\n");

It's normally better to avoid splitting errors message so people can
grep if they see the error.

> +	} else {
> +		pr_err("cpu_capacity: missing %s raw capacity "
> +		       "(fallback to 1024 for all CPUs)\n",
> +				cpu_node->full_name);

That's going to complain fairly loudly for all existing DTs isn't it and
it's kind of redundant if all the cores have the same capacity (which is
a very common case)?  How about printing an error only if we already
found one, or printing a single warning at the end if we didn't get
anything?

--Qcw+NG9yjQzXdZsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYVzuAAoJECTWi3JdVIfQjxEH/1RBpCn3SSBgvm+gaCDRM+gB
IDAn8FgjstVelwko/PnhR6NH3oPXL3qsDWsK0UO+Z172Yeo7WzBT4DFwCgZmsjYW
JQ9cno8hXnOwzfTm9yTadK9RBFI8+K5ANRGgnO8HChUXveCtupnpIMpfbad6YTua
VbLxynUjaSRS+rmqzhJKQrmjivif6ywmXfSupEBCXnPCVQhqukz+hkacuezMI9vS
4ZiE5xc4Hc8AKMs8EYxriXLr+y27kr51AGPWsL/Pwz5mjNpo/EFZp9BU/9QunmxH
hG4PK8XAJvka9OcMzyBsjhG2KmjiybvZn/0RfgpriiK4XwZVV1330R/m0a7r4HE=
=TQFd
-----END PGP SIGNATURE-----

--Qcw+NG9yjQzXdZsc--
