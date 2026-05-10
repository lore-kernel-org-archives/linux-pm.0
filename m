Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7962128395;
	Sun, 10 May 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434409; cv=none; b=bV2liNjJ0/1oafmQF4rDSBXssb5VTHZhZA/9Yhe0AhdtNUDMGqj1AHU068ASnKtflr4DoyPryp9clYe34/bLOQ7iuTzLP0kTse329HRpWaWcZpRo41EIXUmmJdl4mjV7bema9rsXRIrxy9BfPWBWs3YpcTB+h6rEgXakYAVxfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434409; c=relaxed/simple;
	bh=5vhln8hwLXT96G3zmIVyp4edQsgVpZTaaU9SdZD7DGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHDRHIryO2Kn7jja1COJYfPNLz57lwHrfVHFe8pOITJcy+W34+0rFAYH6xuoGbhyNy2X/F9hpIRNbQ7aZjo7QhfmOCV2KwMY3vmi9zMZnVPSi1jKbo+1Gj27A3aULZrk/oHKTsFuMgavvciDjIBdKTRIlNmfM6ByoTnukthC41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4o4wzl93; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4o4wzl93"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aAGaWEanABr6+ytHK0XeFze2tlYdRRk+DRIr8VjGm0M=; b=4o4wzl93iTwurevd32vlAqPVwj
	w2kIXtSCtyTnRtBGX0OohF7PhRmxuWJAuUOPdg85jjkA2Ejy3jZn0vKuvd9nvk0Ep33tJlbeGd6+Z
	9V5/8XajB2pWzSAYPbT4ru7v17Y+4uR43Mj5H6tCtgcxtcJvOCdxPTQrOk0IAzf+BbHhjbkKBTLli
	W+vQOYexWXh+cW4tO45f1YEID9cHoOFw+BurP4d6bWjC44AI8uDC5zcyP3j+D5irZLjz0QwOs21E4
	XK/z8Ke17x57FnNGXEuZSjOLZq//awLqKRj9wkgLmXESGb7WHpy5qRlv0IXcO/XeHMym6C59s0KMh
	21bSJicQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wM81w-0000000BGl0-0BJe;
	Sun, 10 May 2026 17:33:28 +0000
Message-ID: <b23cee4d-dd82-4828-9f38-72cfb05eff32@infradead.org>
Date: Sun, 10 May 2026 10:33:27 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq-stats: document limitations on modern cpufreq
 drivers
To: NicoErdmann <nicobsc4@yahoo.com>, linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
 corbet@lwn.net, skhan@linuxfoundation.org
References: <20260510143303.120863-1-nicobsc4.ref@yahoo.com>
 <20260510143303.120863-1-nicobsc4@yahoo.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260510143303.120863-1-nicobsc4@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/10/26 7:33 AM, NicoErdmann wrote:
> Signed-off-by: NicoErdmann <nicobsc4@yahoo.com>
> ---
>  Documentation/cpu-freq/cpufreq-stats.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/cpu-freq/cpufreq-stats.rst b/Documentation/cpu-freq/cpufreq-stats.rst
> index 9ad695b1c7db..e8a8b3a85ad8 100644
> --- a/Documentation/cpu-freq/cpufreq-stats.rst
> +++ b/Documentation/cpu-freq/cpufreq-stats.rst
> @@ -28,6 +28,13 @@ Various statistics will form read_only files under this directory.
>  This driver is designed to be independent of any particular cpufreq_driver
>  that may be running on your CPU. So, it will work with any cpufreq_driver.
>  
> +.. note::
> +	
> +   On some modern systems, this interface may not be available or may not
> +   expose meaningful statistics depending on the active CPU frequency scaling driver.
> +
> +   In particular, drivers such as intel_pstate or amd_pstate may use alternative
> +   mechanisms for frequency scaling and accounting

Missing an ending period.

>  
>  2. Statistics Provided (with example)
>  =====================================

-- 
~Randy

