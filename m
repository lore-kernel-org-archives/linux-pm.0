Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EA4DD6C4;
	Mon,  6 Jul 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330470; cv=none; b=R69tfFISNufnbCkV3pl+CvHkuDMIJrduPnVOzueeWceK33raVXlNZaohLFN6kmyBpHfXDqvDuN86xrgx4zjivBwIt2hKdNikymZwDnehIpNq1RaUMQ8Fcoee0n7OPf/2EFMS+CcYNXHpA16X+EtwLbFoa9Wim4wXhwHNtYDLLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330470; c=relaxed/simple;
	bh=Mi8P+gtBq5U0l3zHeZVni9V0RRF9cOf4gQ+4Tb0ayXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0irfAdOKMeDDvzYR1eWS4SHiyX3uT5w+HA+TwsSoc9wgMWvDpVd+5E31uvxOcDjNieUMM2rLl4tLauvV+5snPYPCLrrWmRL8Ta444HoBYd8dV6r/jMRE1b0MMwnFTWdkVJZH+shX9qATthbQ75fPYzoX2X+Lxuz/rP2Y13YtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLNDOB9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLNDOB9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB51F000E9;
	Mon,  6 Jul 2026 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330466;
	bh=y1+eJUeoIxDPpvm5aRAfOrIFfS0MB5kksd6upW7Lnwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KLNDOB9chj6s2n14hcCWonOb6t5b4Iuvm7R0yXt2Ew3rcCVqkNqibjzQl+aw4M8Dq
	 MJ7Y87yTYjqWdoAQpsEMk4oAksUlKqMkh3ZxMCsnYjWZEHx4GWMPUbDcez1+MNTfFT
	 0hS0tz1mApA9M2ecQPKoozLb6C0Ry+HRb2bwWx1c2nbk5UL7XijiAackl3nTgRSRIK
	 aQNiX/9GIVEMb11duvTdic1GazY5KRNBzzVq+kvm0BHvd76WgO/he60BrCLv1nXl7N
	 Ji++SGYUCNlElJhrNN9P58s7+iDZpjNlhiShpwkHybjOKMc10OVSJV3lqCrMEgkViY
	 E6raygxWWoa2w==
Date: Mon, 6 Jul 2026 10:34:23 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: scmi: Check pm_genpd_init() in probe
Message-ID: <20260706-dashing-dazzling-sambar-453a4d@sudeepholla>
References: <20260705103256.284467-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705103256.284467-1-lgs201920130244@gmail.com>

On Sun, Jul 05, 2026 at 06:32:56PM +0800, Guangshuo Li wrote:
> scmi_pm_domain_probe() stores each domain in the onecell domains array
> after calling pm_genpd_init(), but it ignores the return value from
> pm_genpd_init().
> 
> If pm_genpd_init() fails, the genpd has not been added to the global
> genpd list. The probe code nevertheless stores the genpd pointer in the
> domains array. A later provider registration failure then unwinds the
> array with pm_genpd_remove(), which can try to remove a genpd that was
> never registered.
> 
> Check the return value from pm_genpd_init() and only store successfully
> initialized domains in the onecell array. On failure, unwind the domains
> that were already initialized.
> 

It was done that way intentionally IIRC. We don't want to remove all the
power domains if some not so important power domains fail to initialise.
You can log the error if that helps but removing all the domains that
have initialised seems bit of extreme.

Are you facing any issues on a real platform or is this just by code
inspection.

-- 
Regards,
Sudeep
