Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDB40F75C;
	Wed, 22 Jul 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715874; cv=none; b=GEX8lFNO1tnGpAEcaudpZyXHP8QP4F3ueovNWMTmci4/uxGQfXgfPRZeTFTDikh2v7lzR81STdzrOlzmlbD078lcnVvl8pmh2xhD+OE0tCbi4x0XkPbCbGUcrlrhB/jZAYzzfSkV7Xd1D5xypG3ZCF4bPLL+7EXI7+7TjTBxyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715874; c=relaxed/simple;
	bh=abIPqrOTfy3BAZu24y9FuBEYyH3Ibb9k6P/aZudvNbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMWTt1qiYts7jPB3jwHXgQfAXzKBXDbsE7MxU/+g83uaiJck1syV3UnASB/0q9B0Q0DkkxuTr4SAiWxVvRd+y0DN98Y4DIFG6xmA4lyNhLiH+w/XqHvQdJetqlzYm4szicCEzyip3znlleY3HMTFyA/EAv1jYmO01NXBGqUJQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=PNyLSZhQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJoKYZRu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="PNyLSZhQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJoKYZRu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E47607A0141;
	Wed, 22 Jul 2026 06:24:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jul 2026 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784715871; x=1784802271; bh=d7KPqKKtt3
	2qdvy6pdhb4zQY6/OdX+QnrgvqOiCn6pU=; b=PNyLSZhQMIjX+s9LApIcugWgZr
	8RJto+1uQmDxR+797Ab3+s9DxXNrnriBohsVcUbNlNt5zxa58EOos50Sfzjt+QCQ
	i9BobrwpD2KaffuwlNldy3UNSBn54gLZIpQ3dgKLaSzHD5SPj+q2gudKkjeZBtUN
	C0iggNgeh2Yi0JTPD8HXFuW1F14ML7ScJ9qLeTYP02iAdtJqCRN9XdWIYlNsO5r3
	2CfSMeIzEHN0fqDMyKUdAYiowG+FbeB3cwSuAa+2Yh618Vi0Rma3CZE9LnNOwKo+
	2N9Rn9XvLTdPfVeHAiqFRhxrWf8sDkOWa81z24cmJynGvWi9XERnN57bvciA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784715871; x=1784802271; bh=d7KPqKKtt32qdvy6pdhb4zQY6/OdX+Qnrgv
	qOiCn6pU=; b=fJoKYZRufhJM22N65aLY1OcDi2jgt2GOVNoLtW2Y5P8OmseV9CX
	21or68/LSP8ew/VhK0E9dLYRX8waN6TuXf9yrhBt5nvgjWax7aro6LXa2LfulZCe
	VE6aOwomiDDW0wFOL8UyJTR2WvVwkdwaGI1HxNzb3ALi8QdONQgDKKlW0hA++i5O
	V75Ktx6D3toIGsX/c/cEMXg9hoEV4Le7M0qrTQ7JjwJi3OS4V01LwEjSjibDP3Ib
	FwqUi2WQ84k54RZ99d1h54eIhVhuegYnXZmbjcAMvaf5ikTDZjTDq+ecueNN/Xra
	qqG9zLtqKCTDJDsiUQ7+zmL4/ZBtKxIaXew==
X-ME-Sender: <xms:X5pgavF5VobabwctdUJSi54TqKjyGl9o2CnYAaO663t1gTwWDGJt5g>
    <xme:X5pgao5YWMRe4gcqSrccwNUMWNqCmdbdoDnwAYBB3xz0gM3qK6J9AEE6ab9WkoHUM
    qxGhgvN7fT1E88lXpnAoNPrY7zfXb0ekDPp9-ryImBXm8BlJNDXn8Q>
X-ME-Received: <xmr:X5pgalmBuzOUAsSr08pSRYWf8Ix5ZBubVmKTCVju84RYCxHqqhepqLwgIBYjt1ILTZnE2lgl-DlaOT4-kmREsVjlmCDRn90B2mI>
X-ME-Proxy-Cause: dmFkZTFR4qs4EzJbzKeAVnWQV4FuYpX9MCEikNX0fQpLTgiwJwvXpFXR8ZcfR3FjZgIlXL
    2IYhwWJDSLDALFeP3nrh0kStT1Vg4aX7W4wIo41jab3eEk6zTW8TgM9jk32vgYakBUlw1X
    Uc2Ndl7wl9YUY+E4/SA+lGWFdt2z1K7L+kKb0MxZfJU+I4Fhp3JMttrP8m91O4sJCWRVp9
    mR2Wxtuf3Weeju/eMDM18yXKM0e8BgV9sURH/GO2K1uRsdZ+5MTr5DkanEkjF0Iy43wEK2
    jSk0/t3pZdUO9vv7+2igz0Q7OaGAOrJUFP9BfBhcvtK2IxOCiSXzX/8jg/O4ojVk//7Yoe
    +P6BzpWV27uIv3uUqBYC0rgiqgbB+gg6G3qpp60jLwSUMnO9WpMk6yE7mNQ2lnzl0ht3MK
    kIxt6IuHvNgADyhja2n8talh7Ljyfftj7WLypBp5Af9QFR8FhAugsrqU5e7Ou/EHLaV14V
    CYWeKcIIl/TNYdyQsmnJTeHbNJQITQRoaNd5MAqPbiasCEiS2uO9pkvV+iIUzLSadgTWKb
    T9bL8NMJYlSpuAEdF6in+N0Sww/rE/ITATpEk8td1N7t5C42H6tzSp3HMNzhqVfSHHuIkB
    ZpwkjlI9eWQztJXGRvs/ejpVxlKaXk2JYHSudZA3d2Pq2rh3dVko6V/P2ewA
X-ME-Proxy: <xmx:X5pgaj4KjRmzHlomMjuRDoCLNp5ilCnr1jdvcMPYytOc80-u0DXQAA>
    <xmx:X5pgamTohimYc8LOelQxWT7dkXc6eLarokdnHcxw9AGxtVHuvejuQg>
    <xmx:X5pgahxCbbBCeIOEUlU-ZWOEuBzbPsbPl4SRTEg4iMTkvldRxD1jww>
    <xmx:X5pgauq2ehUIREMCCXcNvG8KjNr1Lm0JDONZupyAOVDoMADKtFNpaw>
    <xmx:X5pgarB-YygeEoIA-CoL5IS75cOnbpXN7sWseERvwmYZNrqhdU1PQ7h0>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 06:24:30 -0400 (EDT)
Date: Wed, 22 Jul 2026 12:24:29 +0200
From: Janne Grunau <j@jannau.net>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
Message-ID: <20260722102429.GB4159739@robin.jannau.net>
References: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>

On Mon, Jul 20, 2026 at 09:25:10AM +0200, Sasha Finkelstein wrote:
> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz. Ideally, we
> should use a true u64 instead of unsigned long and "knowning" that this
> only runs on 64 bit machines, but the core code uses ulong everywhere,
> so this should be good enough.

It depends on 'ARCH_APPLE || (COMPILE_TEST && 64BIT)' so it only gets
built for 64-bit architectures so the unsigned long won't cause compiler
warnings/errors.

> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
> Changes in v2:
> - Minor style fixes
> - Link to v1: https://patch.msgid.link/20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 638e5bf72185..5ad274a1e6ae 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -288,7 +288,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>  	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -		unsigned long rate = freq_table[i].frequency * 1000 + 999;
> +		unsigned long rate = freq_table[i].frequency * 1000UL + 999;
>  		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
>  
>  		if (IS_ERR(opp)) {
> 

Reviewed-by: Janne Grunau <j@jannau.net>

Janne
