Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8833FE33;
	Wed, 22 Jul 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727393; cv=none; b=MYLJrxfDintejMDOrXxuEF7E89beBS9+iA8cRte3v5iNPeVOxm+b9zeQ0uOcFSu7e0UxbEhy2lUUitbr0T0XxhT4WDV+Jm9xI156v6plhWvZt5JHszb/hq+1x0GxXrR8flRAQJkXPRMt3IOA173oSJUy6xbkPVDMgwCUkCxaE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727393; c=relaxed/simple;
	bh=U04IaVKW7Y6u/Ilc68HAvnbuipGcvPidoP7zFdtNyII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y58fptZS3t7oGtHBwkKwDvDs7hyfw08vqdl26n7OeqFjcUMSXnxzvqk2RbiQzz6TWyiuPIbIwVAiAtSP0nfxpFoz8rA2S6lh2GLLNaRC+eD4gr52GgBUlbyEs1nfpnjJbYtPFaKTtnNLu3779Nox2GVzA2jMIqWfoKwElIwBvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3/WvEof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3/WvEof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5121F00A3A;
	Wed, 22 Jul 2026 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727391;
	bh=wv1L8p6MzfYFZCK3iFIRBbGSTULComoQHOxPtqcosU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3/WvEof+x+0IFlJxdp7Jq8CBnTzwrFUC1Q8BtC34jxDUsczvRyEMXnu5EzV66r8+
	 Ac9laVZG8TDxUX28DyEScWr8Sy66S0lrRGP+914kHoXIbck4j3TlMZHDrKYlC2+X+2
	 h9494jLEsgRbknMDLlMi3Lar5CPrhSDwoPMFPa53RI0AMG1qNzVrblcy00WeEHjwgG
	 ADdecRyii4RI1h4qqx76FZ/AYQ7FF4uEi1uJgwuU1QhaO5/MKEBBw89gYZynBDuB/u
	 uERDW6L08bh74bMQeBNRmF5XJBwvb1m/JU8FWw/c4H4J9SHgVDV0iI604UV/QqFYJk
	 lDyTrPWoE2ZMw==
Date: Wed, 22 Jul 2026 14:36:28 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1][linux-next] intel_idle: Update documentation after
 adding ACPI _LPI support
Message-ID: <20260722-rough-adept-kraken-3dd7f0@sudeepholla>
References: <12962673.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12962673.O9o76ZdvQC@rafael.j.wysocki>

On Wed, Jul 22, 2026 at 02:53:31PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> After adding ACPI _LPI support to intel_idle, update its admin-guide
> documentation to cover the changed behavior.
>

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
