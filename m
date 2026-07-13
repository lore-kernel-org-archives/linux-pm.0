Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89C30CD85;
	Mon, 13 Jul 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941728; cv=none; b=sXa0XjYgxK4UBVtemsZ51CFrmdHkviV/e4jFLAZ1EffV3ihbreWAHKJuzNMncYxNPRCI7Y1HqkbOHD46oEv1f7akXNhBdWQ1PC/dT5PfTmrsyyllQvSqXK5Z2Ji4z53su5rCGm/Hk1sQTTFkB4zfQDcRfrxdL0rCX04GzeJp4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941728; c=relaxed/simple;
	bh=wb/TAk3RYgqpXDOcNnEonIjldGOaf9kM9fpArq+77Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5Ze1D5JL1Ii0v/bmpQe48FtcCnTm+kzz5qjHNFflrN9GUuQy674Kv28l2niWp09lb1U6ITOR51H+RDwQhtuf4JWgXLX49QI488BRfc5oJazUiSIn1+pJfLcUppFo0Q/bw/jg3gaoJHeYvr/3HhYgwN0Yw+Dr0IDc91yNHoZ75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIDmHNis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIDmHNis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C26C1F000E9;
	Mon, 13 Jul 2026 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941727;
	bh=qFY+KmTx/tlnE17EO4wV+JaN3AGIQYxJwHd4c68mrB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MIDmHNisx90y+BsYrNHQHBQ+zOItxh7DmbYea8ErulpGCxQ6MDaDoGPiBGuPmOutB
	 eOBtBGExp2FwISJc7D9WCR1u1hqcgdDbuf0fFH3Zx8fn6/DFXTSmx1LAKWw3rElvza
	 48QS7HkYW8hI/Tog/bT2JZjZREuPwHupgJYmUEU6fMCoFre2bt4vR8uijQ9vU+J2E9
	 7F/57s5SB9vvxJYztXiRiiwjKNVD36BnqJkKCYAsjbHKIXI7LIOg5tE4YZt1UV4uoM
	 jAzLiwn7PyBKuh8ndMShYs4qLmD16+zemvUaBL5XaRcopsNKR4teMTnuBLJ3B0JMx9
	 sKz5+8KRYXxVQ==
Date: Mon, 13 Jul 2026 12:22:04 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 01/17] ACPI: processor: idle: Expand _LPI package
 sanity checks
Message-ID: <20260713-berserk-whispering-wildebeest-0aefdc@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <5084143.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5084143.GXAFRqVoOG@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:30:35PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The _LPI package sanity checks in acpi_processor_evaluate_lpi() miss
> a couple of things, so expand them by adding a buffer size check
> before retrieving a struct acpi_power_register from it (and skip the
> given state if the buffer is not large enough to hold a register
> structure) and making the function avoid copying the state description
> from the ACPI table if there are too few elements in the package
> supposed to hold it.
> 
> While at it, relocate and rephrase a comment about skipping _LPI state
> package elements [7-8].
> 
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
