Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E02EAB82;
	Sat, 11 Jul 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755704; cv=none; b=l0vSNGW1KdjoEbOLQS8pyL03mCgiBuspW56u71+4t2UUDBUgzSWdwWOu3Dm59w0fTH8VyZv27kRl7ugi/86dZGpzClzVvTzIl1VS62EYOt9S00rzbnOnE1Wef8OwgbadfXZ0kHzIHRV2xSXH1twfN1+K/U6dy8vhICfv+xEuwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755704; c=relaxed/simple;
	bh=CZkC0T0G0v3pRiguDz3Y2aIo1lPSidqNTLl9RM53Y+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN8Enu+Tft1ON4tBRdqhC6REKiVuEZwJLBReoSDjG2xhAZ3l9+YZUpGHTPKK3Nz07I0TpqRzu7yEtXxo2aODqRXBPsdZC9Umug5umofwcYfVhJm0pPQoFfGrXjdamLNdVq6hzlz6ql2bEg6RKyTFarsiWGq9+JLbbztufJbLkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE1e5R5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE1e5R5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE311F000E9;
	Sat, 11 Jul 2026 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755702;
	bh=FfSritx/PtEBrsGP3lbGQMekJE8MmJCr9d3EgkR1zwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KE1e5R5MLRMZ5mWs3Dpq4fi2fB/ZDPPgUTHy12YnFJdhMG9l4FWItXwYpe2hKDf9X
	 SyP1C1klHJNrWx7NqlynSXTbvkrVo0Lz3DAqoxpnU71g6r/uTsDpfM+xlWY6849GfR
	 qfuoYiBbeGk9bAr3/m9iWEb4MDb+4AOC+CTYkrGzamkhBSdyKBMRFEgKAio5lZ1FMJ
	 xUZuhN8S24XxCVR6uny9gWtiIZYlJRebNoMGHNwt1TazQNcaHIQoea0ZQITPMCqjpj
	 xYu/w4axLIUFOlJb4SpjwXVhx3CQ/HKPj0Z03126qxD+INTkI41wqGE2v5s+jFbzWK
	 HKnDpxyjuAKog==
Date: Sat, 11 Jul 2026 07:41:39 +0000
From: Yixun Lan <dlan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shuwei Wu <shuwei.wu@mailbox.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: dt-platdev: Add SpacemiT K1 SoC to the
 allowlist
Message-ID: <20260711074139-GKA36656@kernel.org>
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
 <20260626-shadow-deps-v4-1-bba9831f2f1d@mailbox.org>
 <7x5mgpk3z3aiebifhxto2v7m5yrikj52lwf5pzegzhk5aiehhj@jqm6opm6nrub>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7x5mgpk3z3aiebifhxto2v7m5yrikj52lwf5pzegzhk5aiehhj@jqm6opm6nrub>

Hi Viresh,

On 10:28 Mon 29 Jun     , Viresh Kumar wrote:
> On 26-06-26, 16:10, Shuwei Wu wrote:
> > Add the compatible string for supporting the generic
> > cpufreq driver on the SpacemiT K1 SoC.
> > 
> > Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> > ---
> > Changes in v4:
> > - Drop the K1-specific cpufreq driver and use cpufreq-dt again
> > - Add spacemit,k1 back to the cpufreq-dt allowlist
> > 
> > Changes in v3:
> > - Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology
> > - Add spacemit,k1 to the cpufreq-dt blocklist
> > ---
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 25fd3b191b7e..e262394b56f9 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -81,6 +81,8 @@ static const struct of_device_id allowlist[] __initconst = {
> >  		{ .have_governor_per_policy = true, },
> >  	},
> >  
> > +	{ .compatible = "spacemit,k1", },
> > +
> >  	{ .compatible = "st-ericsson,u8500", },
> >  	{ .compatible = "st-ericsson,u8540", },
> >  	{ .compatible = "st-ericsson,u9500", },
> 
> Please take this via arch tree.
> 

Ok, in this case, I will take it via SpacemiT SoC tree along with DT patch [2/2]

Reviewed-by: Yixun Lan <dlan@kernel.org>

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh

-- 
Yixun Lan (dlan)
