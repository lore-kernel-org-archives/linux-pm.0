Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446325393E;
	Tue, 23 Jun 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205523; cv=none; b=q8WIUIqUBR6BwuRXIOqsEqmSRlWcHjQva4w3SI4Gjq+WT/gbbq1HWTeud3qT1HWj9AROvoyufStNfABEcWN2PjDuod6xHhIAUikLr7FyaWOnYzOtjFo++xGshupTPct9jt9wnZifnEYxbJzldRzeRt3lhRQm8I3+0ox5+oetUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205523; c=relaxed/simple;
	bh=GrmHOg9ejxDc37mq32ioSdu4VIZThvznYhKIPRWvwKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvxdz3XaDQg+d19aYuKogjjEmGIIPUi1BRnoPDSr+DeYHN03yUXkUUx5uz7Cr7TtdOoeJY3PpPNM3G8KvKQa44Ze5CYpcgLrG8j9xITTvjBJQGax9S0AUbdCL7Kg8tDXZ+zjHMytponsBLVi88AEU51Hl77JCg6cYHh4Cg8GlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnLqzqqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnLqzqqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE2E1F000E9;
	Tue, 23 Jun 2026 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205522;
	bh=wgTiUtsWfJTzG5+jBv6t25W/zs/ISNn2aRtz1RmdzP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HnLqzqqzAxCFLIo0VlgNpDfkkjM3B/uuj1gem6x12sl0NIMAPN+1KeENIZX/YDZ87
	 TgFre1MHioXlUsLu+DGNskaBT57qBaG3DxQzL6LW/c2OZwcF7YbFd5qMbfhLme05FT
	 IejheBxlsYP28FQdAOdkmCp6Sxp84K/vMrfv53EkkOXQOZ1sBBS0dcdwIUe9fKuKA1
	 WrxV9YLSuGmKo97KMOhwPMzE7I6qhzb6i3VY8sxTEwA5KgYGmyLUKlmKaDHNoKmTOu
	 8rMHFu5MmgEpSjO3AKIhtTEUAhvl+ua4o0V0BSiExsTdHPalGmKKVMw4Gi/ntjlri2
	 3WO+0QJj2yp/A==
Date: Tue, 23 Jun 2026 10:05:18 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Grammar s/may needed/may be needed/
Message-ID: <20260623-neat-booby-of-amplitude-f0fd93@sudeepholla>
References: <a9a082c25e4bda4d73b261eee951efecab20612d.1780499882.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a082c25e4bda4d73b261eee951efecab20612d.1780499882.git.geert+renesas@glider.be>

On Wed, Jun 03, 2026 at 05:18:43PM +0200, Geert Uytterhoeven wrote:
> Fix grammar in the help text for the ARM_SCMI_POWER_DOMAIN symbol.
> 

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

I assume Ulf will pick this up.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pmdomain/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
> index afed10d382ad7f66..ba0b190a63d6bb18 100644
> --- a/drivers/pmdomain/arm/Kconfig
> +++ b/drivers/pmdomain/arm/Kconfig
> @@ -21,7 +21,7 @@ config ARM_SCMI_POWER_DOMAIN
>  	  enabled or disabled via the SCP firmware
>  
>  	  This driver can also be built as a module. If so, the module
> -	  will be called scmi_pm_domain. Note this may needed early in boot
> +	  will be called scmi_pm_domain. Note this may be needed early in boot
>  	  before rootfs may be available.
>  
>  config ARM_SCPI_POWER_DOMAIN
> -- 
> 2.43.0
> 
> 

-- 
Regards,
Sudeep
