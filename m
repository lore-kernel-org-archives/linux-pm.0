Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95238D40D;
	Mon, 13 Jul 2026 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941894; cv=none; b=iqDnFrpXVEt6Hqo52nvOg/Q3GlL8P17s7MSQcHOo4WzLpPZPJeixXPVTeO+u1QEw0dZJGflsE50zxzVx4M4jH4wVe/ro8UDe6k4+ODE26wFh0mPrLY4yeaFv1QgosNrMhDX9NM9cZJiaTENzD3XdObXd3yjg9UTrQH82KKGRFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941894; c=relaxed/simple;
	bh=2kOMIkPASljTwyuadUIIJCAzugYYX0rtoQaxoY6Pn3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRj8ZCCnORFcvgLRSidbwhKuzn8Nl95+P+dh1vgPVWXFmSgGfaJPO0uzDb3Zi5m6wMEPryBgo2yPBj2tGOWWHJd76jxfAjOBv0t4sFXbo9XZWcws7gppZbvPtB2oi7Gq6FJ7MCnWU2SpOHS/q+owPEopTanTxHJdTkOtHHkmu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIG39SXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIG39SXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2328F1F000E9;
	Mon, 13 Jul 2026 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941893;
	bh=irsRs/nBD6uGKHtSPg4eK4S7z70uChTLYFUfrCRF/ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BIG39SXOV3GA9RXCmhBt5yYar9OWCx2n+VEPbXyaMw2/LYOwkmOCIid9Gi9ux31PY
	 ImCQNXpQCpyK+BQsqi9pKtbO0OWypMq1lskZDfirxbWY55qEya55jtw5zZgdB4CmLY
	 0jTTnOUT6oZUp6A5lIV/dympG6TMkX+FTXq/BVhFif8m3cZjDZk5Dm9uPGNEXWmRsd
	 EHusUs55L+Q9iFtvC8+UUDbVlfQJTOhw1dvHmaI6usjdaEtuf+Xkwihxf9VKMtKvzH
	 de+ccEBYGxBBcv90RT4QWeehRgwMON9FxnUGX7z0xdHWH+qQhwUOev8UV0D4jPVrV7
	 No9RkCmMomSTw==
Date: Mon, 13 Jul 2026 12:24:50 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 02/17] ACPI: processor: idle: Ignore _LPI states with
 SYSTEMIO entry method
Message-ID: <20260713-honorable-hilarious-locust-9d29ca@sudeepholla>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2268989.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2268989.irdbgypaU6@rafael.j.wysocki>

On Thu, Jul 09, 2026 at 02:31:28PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The only entry method for _LPI states supported by acpi_idle_lpi_enter()
> is FFH and it is better to ignore _LPI states with the SYSTEMIO entry
> method upfront than return an error from acpi_idle_lpi_enter() on
> attempts to use them.
> 
> Update acpi_processor_evaluate_lpi() accordingly.

My bad, the idea was to allow SYSTEM IO memory for other entries like
residency counters which was never supported.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
