Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3C156F45;
	Wed, 25 Feb 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057794; cv=none; b=dusXsOaY/gdIO3dOlisUSKEO31i98ls8a+Sb0AcuhCcGf4gd2rInkB7CfKsh+KtmlZXWi5EZkYydzPANa4RkwlFl4ONYo7zMt3DTrTLn+qs8I25M6y6KC3ffda5YnTZ9VZuEAaxBvbk6St+hmk1GfGEVuVbbYKl7l2D+L16+D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057794; c=relaxed/simple;
	bh=tEgYXcuadwgc0jGOrrazjHEeJPSuoYBMFjqz54qNa/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUnaXps7XKM7NLB1Hl35jJ50Z7hgaU6uim+J94mtn2iifHx0D0gM0Cq5WQ75gBF5BBy/SKy7ZHNvAvHEYBWP7Rdzoh/DXg9RPiMhIS8WG8kMXJvbWa8gXPRy2nbdwQ1KNuVRB4SiWaQePTQTUEOHa7AoycurgK4MOCNh/4NxZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTDbjccJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTDbjccJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D32C116D0;
	Wed, 25 Feb 2026 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772057793;
	bh=tEgYXcuadwgc0jGOrrazjHEeJPSuoYBMFjqz54qNa/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTDbjccJ47OQeIWWdMJl7YmAu/C1rTnsih7/vny6eesQcQVAy3AkFkRKSG0xQW3YX
	 lcCWps83dlR5fzCPH+dWrbLhDM8QI1SgMsrZPSKbrV1vFPJi1DOkrFYmqeNbAMwwVZ
	 6OxUwiKgG7UEav1S4RZW3qArTuFFDD26pS+/8W/iZAvaeT4oEq6m4cshiDjaU4XIGA
	 YtcQ9I8xEh5AleeUoHOKjrGSqyt9uedgK/7BZmXCqGYvPo+NKbV+cxsToyhHyIE6RK
	 tO8g/Hf7TgWQQTkTrCWOiH9lXOuEs4VgY9rcHnjd03sad6nou02AxhZM3+hJy2MAsH
	 AH1PMiB+2856w==
Date: Wed, 25 Feb 2026 22:16:27 +0000
From: Will Deacon <will@kernel.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>, catalin.marinas@arm.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	viresh.kumar@linaro.org, rafael@kernel.org, beata.michalska@arm.com,
	pierre.gondois@arm.com, ionela.voinescu@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v2] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
Message-ID: <aZ90u4HrDh1N7ylK@willie-the-truck>
References: <20260224092714.1242141-1-sumitg@nvidia.com>
 <86ecma9gb5.wl-maz@kernel.org>
 <bdd6a7bc-0b7d-405d-99a7-a11eebaf627a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd6a7bc-0b7d-405d-99a7-a11eebaf627a@nvidia.com>

On Wed, Feb 25, 2026 at 05:08:03PM +0530, Sumit Gupta wrote:
> On 24/02/26 23:25, Marc Zyngier wrote:
> > But I'm more concerned by the overall pattern of doing these things in
> > random contexts. Going back to the original patch (997c021abc6e) that
> > states:
> > 
> > "However, this deferred update mechanism is unnecessary and introduces extra
> >   overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> >   accessing the regs won't sleep and can be safely performed from the tick
> >   context."
> > 
> > Clearly, the AMU registers cannot be arbitrarily accessed without
> > blocking when accessed from one CPU to another, so either this
> > function is never called in a cross-cpu context (and the warning
> > should be removed), or the premises of this change are wrong.
> > 
> > Which one is it?
> 
> The function is also called in cross-CPU contexts, but only from
> process context (get_rate, sysfs show) with IRQs enabled and
> calling smp_call_function_single() is safe. In the tick path,
> cppc_scale_freq_tick() uses per_cpu(cppc_freq_inv, smp_processor_id()).
> So we always read the current CPU's counters and no cross-CPU access.
> 
> The premise of 997c021abc6e applies to same-CPU accesses only:
> Reading the local CPU's AMU regs does not sleep and is safe from
> tick context.
> The irqs_disabled() WARN is still needed to guard against unsafe
> cross-CPU calls. This also returns '-EPERM' unlike the WARN inside
> smp_call_function_single(). So we fail instead of risking deadlock.

Hmm, so why isn't this structured such as:

	if (irqs_disabled()) {
		/* XXX: Explain the tick case */
		if (WARN_ON_ONCE(cpu != smp_processor_id()))
			return -EPERM;
		func(val);
	} else {
		smp_call_function_single(cpu, func, val, 1);
	}

	return 0;

That way, the irqs-enabled case remains the same and doesn't need to
mess with preemption.

Will
