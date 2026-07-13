Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A9427A04;
	Mon, 13 Jul 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949555; cv=none; b=KnTZ1BGDCjljZG98aTDCuMT9plWT3Vo8Isurm/B++d04Z/JeZUSjjZ5dqDc6jjjEWCiymumywRwVkhlmwEXGSVJT0R6l2Nsi1/Kos4BPI/VP6RVHnWl5HDsu+29kSPDc2apI6SHkzyyE0ANSKw/8zY7hdAiW+8rZ87at1ugwTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949555; c=relaxed/simple;
	bh=tmdzX9UdKYNuRuoFYHv0qoRf2WvjLhznEZGEorc6NhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu/lcCz2LDRcAMoDpdhA3kae5ztEC02adGu0OsDqbrckmxvKCdTBcXLsBPVZbrzKL4GqFsYXlHjk1ytuZ21J1nyDkmzplfl04Y5BZE193iwKe60Tw0/lLd+xEJbyDMRwGAkjf71w7rn2J1BbHgogAERQd3s0AUqFMsVi0ur7sx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmOAuWGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmOAuWGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E31F000E9;
	Mon, 13 Jul 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949553;
	bh=futj6VU5GHW1t5OtSZJOl1UqIo1Eypt5bWZKA8Pck6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmOAuWGpOrPrDzg+bch9cB5PN8eIheu9KXZNd+9H97/mpzAWPz6Rf0CBmMhaNHvxz
	 dhP9Hmlo7kutWXB5EWRlP2t6ZcyUIJEoLOPZjLI39ZDbUWyU5J5r+jmMOMQesg1UhX
	 I1HSnHxfr4r/Mx5z4Hc9izUn5WtDJMn6t6rdeuE/EQvd4Z6/eVZe5bTjh/rbPRDmcv
	 MuYa983cm7oZv88G3t3CGmMveivP+kr74RC8sGmu2rV+twQr05VbH5Y615k9cUtlqv
	 jOJPT1sDO3uyXyBclpKVCxSgoB4e1Uymx7b6KGYpkk+5YRxzE++rte8nRxKHT6tgMR
	 s9EAsG9CMtI6w==
Date: Mon, 13 Jul 2026 14:32:31 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 13/17] ACPI: processor: idle: Introduce
 acpi_processor_extract_lpi_info()
Message-ID: <20260713-mottled-finch-of-refinement-5ac3a3@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2709187.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2709187.Lt9SDvczpP@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:40:35PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In preparation for adding ACPI _LPI support to the intel_idle driver,
> move the majority of the acpi_processor_get_lpi_info() function body
> to a new function called acpi_processor_extract_lpi_info() that will
> be exported to external code subsequently.
> 
> No intentional functional impact.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
