Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B1417365;
	Mon, 13 Jul 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949589; cv=none; b=HK6Z7N9Y2l1QCTHyWVY9FZguIchmlIAc1k00VrHgotyQ51EyjLBYanv+GY+NxfTKho+admafagYrCVnwFrpisJxG96cc8FVmxIEvg2vQPKNhdDyJtMV66tgwY0ksHMmA3QfrVSb8a1n6HsvFgmIhmxRzUCM+WyuE2F3gzydHO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949589; c=relaxed/simple;
	bh=h8HnbLVN96lnrZSNb4dpnt2nZALT+6DHmxR3TbBy/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd6TBTjsjHVj5lPmJ1mQLE6qvTetdf8CmGEpMugzgFoZbGI26ntwviwA8gccdm94f+1t/KIqwgHrD7WtVSVY8m5GY+UKRQ2YLmu5Xvtiie+3rGdpRWauHmAovegNvoEkdhWjxk2RYKmymMPsJJcTqbkWyPVjknCfabfqx23fIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLBmeSEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLBmeSEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA261F000E9;
	Mon, 13 Jul 2026 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949587;
	bh=xYsOtZrY6Y5PfwEUYwAX2OmkMFT7Pd2f8GReQEGTwc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gLBmeSEzr7AtzrKBOz1FCBFLUaLcHM+vfu9M6nNol3wPRmGuW16rex4Er/ZlA4mXj
	 wK7kK+vW49By1PTMbS2Vd4/DF7GfkP59M4Z0tTE3el6XTvG3D/qnjhdEu07DEJMWwx
	 RSvudL4NHQtptNo3rUtb6AnddlgvfFCtI40lPNxA/seSjr54E8jleRV3x1C/vTOxLX
	 VwyXFPV48ywrRqJoT2K4X6nJf+VsYLdil3xaM86+2bgwqBz2hRknaNcUPUNpD2xT+6
	 y85Diza9f2Q5Dd9Wo5blMtU8N83Yf98NrRJEFaPVAaP5PlfhXskTyAGPqjWmMxwdX9
	 gpg+sf4ZVzcdA==
Date: Mon, 13 Jul 2026 14:33:05 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 15/17] ACPI: processor: idle: Add switch for strict
 _LPI processing
Message-ID: <20260713-heretic-malamute-of-action-5aee05@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3896986.MHq7AAxBmi@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3896986.MHq7AAxBmi@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:42:33PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Add a "strict" argument to acpi_processor_extract_lpi_info() that, when
> set, will cause it to ignore _LPI states without minimum residency or
> wake latency instead of assuming 10 us values for these parameters.
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
