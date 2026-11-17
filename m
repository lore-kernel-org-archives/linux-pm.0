Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892311;
	b=T3gd0JTwW5zqgaIxyqe/5RnnBOexhXC3mNEHVDMefwfoiVU2B/2OAyz+lYwkqXhNi99M
	 CnINKHw16zD6+OzGypC11u2QiNukR/XbAmtaaImlPIpzzsKiTApE8xpbLUdKB0cpzEU2C
	 v2OwazNixMjhRsnN1/1q2rlDYsYVYf3bxKTzkApmkE99PIJD+sn0IdgyoaVYxkt49XJk1
	 htwFyz9sdUGBqf/p5ALEZfJ2glr9iCX0/c4Se9IqUeFGZs5Yf06UUozMv5fG80pFkQVX+
	 qcx/OoBorrWnXjMFHCGPaxc/WY3GvMeBoGDHK8pxh5SgztDo1MX1u4z6hQM3iHp5GSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cFIGFgrqmh7vJ8p05TfgpCv8oubT+IqY4VjNLXb1IxQ=;
	b=GQ/+2TaUK5JnxniXJPxy4qbAQs0gTC9zsoylOzYSZeY7H5aYatRuFe9P1HqBYDtkTshr
	 5eHLU/qgE8xP2JuJXNYJkC/cqIppfV4GqQ0O1e5GbHSX0CvTSCKplpRwGLrJEzEmu3njS
	 mIquUkSzYnBdwGW+WHWo/EkmLQtEGJ+QKmUnzJAKL1Ms7iRDYNsmvIj5nMisndunoZNOL
	 KhXfKabkU8GGv/p6J7++Rfl4YUFncdj+wCgmIY6HnvRG2gp0P9lpdp8SZKgpjpo6u9sSQ
	 U+QnqnCwRf3F1RbLYLbhcErSuYtCdEcUORRyCgXwuKtjGaisne0yKqYRLwQRiwP7WnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KUkwjxqY;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D4606A32A
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94D4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KUkwjxqY
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so8824739c88.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892310; x=1795497110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cFIGFgrqmh7vJ8p05TfgpCv8oubT+IqY4VjNLXb1IxQ=;
        b=KUkwjxqY2sX91TEyDbP1VuzvxqZymLLpQ+APbi/GqefwJjM/dcMbwXeu6DoGvVCCKO
         rZ252LO3XGO1Ih5y0zh54MGbH9ApJIXFv6JPpO5TycX8ykPqIRy7cLnAOa7ZeF5nvqzL
         Vlof9WZBSz9XtVoxSnA0W13OMOQ2M30DKveLTBIytt97q+PQqAQCcuroQVKT+9AiI8is
         qfKjdips5pOpfuJGVXPxZ0eEfYSO87ZWe1nAdNSHE3RMyvcL5ZNZkFPPNH0NdIfLlNRT
         ZZ4etEKl6xRaYYdM9Z9ZdzxS0kDRCRxYOsxV0MWBTsTzLPIHRjf7+xjXQlUhoVGNvXqk
         u07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892310; x=1795497110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFIGFgrqmh7vJ8p05TfgpCv8oubT+IqY4VjNLXb1IxQ=;
        b=hTbBsmsNPkUEgcLRr+kBaMZuYJ4QgPiQaaG058J/m1JUIQpthW8sHH+skZdSs/IpJs
         EImPcjei7BQFe17JvzcNpQNMlLbl6SHXlUo80NI8IcOvveI1ehfx0tXP+xX5iIqGqFmv
         rRc319l5QrRfdEwW0SSpgSK7JEjvRGYd7uCjvIOF/aCby40AfJUbsntPRq9LGoUQ2PaF
         DyvJZJB+Vfkl27iwtehcnxvcnSy6FPcqTu74WkhuMmcDpsHUTQDZiZK/mdOhLPYPk3Ln
         +QOvPvNe5xhisIRym8OqPABNPMj+Deo9AxuY6+Hv9+FYQCgnNMEAMqOn5/6kfZxyOvMj
         Ul6w==
X-Forwarded-Encrypted: i=1; AL+hErG+5sNjg6xNCo7DUEAHuzHQdWlPDiN48lHybKR6GnGn2I1BR/BZ7d6eAKs5fezSmAoUAkBBbtmfWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tEFF24C7UJSSBp8fp1w3hIvHe/+xK18lpLjvmL0xSSIuqDUEk
	9ScfuW/JFbYobxVxmvIgbWx7wjdezUlI9TFJqXL2YhR4ha8oAb1Fx795I6FO2SF9Qkw=
X-Gm-Gg: AYBFou1996EQx1KkSCqLc3CLhypHibbtX+ot1R/VR34qa1yS5Cj6tXcIR1hkmIANu3y
	T8uqsvLlu9SXBvkY9li+AruhiejEsvviXe5hpet4BkJaPxK1V6C/gp/4TFAX1W4Qb232wmjKkNm
	gEvEy9HHSvFRsOJ+3j10He5UF1YQIS32/tVLpoiUNzWlYPniA0nvCaeiO8cQfPZWCJapSwuZXkn
	74DWBPCt+qbYFPbKnTxtLa3Lx8uWrX02b82043ETSXOGjmW3twPUOd+YNWgqXa/r8eA3V88hBQ4
	zyDF5Wpu6bDkhpPsMwVSDptfCgOD5I5ilx4Vq2nwFBmbnZgpQUfMP1i9LWzSFQ9U6Py8EnSp/iw
	p60C2ajyRyM3uoc2smd1la0l/sQYrw1sUpENnc8El3PhHV+VCT1br9C38YuYiN21/3xMI1KkEvl
	f9IfLo2cMFCMyRVG1dbe9w7VgwG/0hdtkFCTJpytasyfnxPGvE3zSfItMMguyaS1nSq48sM5TN/
	FpAQIN2qGffpvFDVOJzrBTPXXXDYLPpo7FGaM7HmG9+GQpbkwaKVHxF66PyhoMaFxi6dqrkCOTr
	v0oQqiYMUjPT1/9EJWBy9hiO7nSB2A==
X-Received: by 2002:a05:701a:cc87:20b0:1b5:3878:aa29 with SMTP id a92af1059eb24-1b53878b8c1mr2057482c88.38.1794892309617;
        Mon, 16 Nov 2026 21:11:49 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm53754284c88.9.2026.11.16.21.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:11:48 -0800 (PST)
Date: Tue, 17 Nov 2026 10:41:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rajanyadav0307@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] cpufreq: sun50i: Handle boards with the
 allwinner,sun50i-a133 compatible
Message-ID: <avviEW1-h495D0B5@vireshk-B250M-D3H>
References: <20261104-a133-fix-v1-1-d0b5ad3d4c5d@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-a133-fix-v1-1-d0b5ad3d4c5d@gmail.com>

On 04-11-26, 22:07, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
> 
> The Teclast P80 uses "allwinner,sun50i-a133" as its only SoC
> compatible, as documented in the arm/sunxi.yaml binding. Neither the
> sun50i cpufreq driver nor the cpufreq-dt-platdev blocklist lists it.
> cpufreq-dt then probes on its own, finds only opp-microvolt-speedN
> properties and fails:
> 
>   cpu cpu0: opp_parse_microvolt: opp-microvolt missing although OPP managing regulators
>   cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
>   cpu cpu0: OPP table can't be empty
> 
> so the board runs without CPU frequency scaling.
> 
> Add the compatible to both lists.
> 
> Tested on a KickPi K5C (A133) with its root compatible changed to
> "allwinner,sun50i-a133" only: on v7.4-rc1 cpufreq fails as above, with
> this change the sun50i driver probes and the A100 speed1 OPPs are used.
> v6.18 fails the same way, also with "kickpi,k5c" listed first.
> 
> Claude Code (Anthropic) drafted this change and its message from my test
> logs; I reviewed and tested it.
> 
> Fixes: 60b064eb82e6 ("arm64: dts: allwinner: A133: add basic support for Teclast P80 tablet")
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
> ---
> This fixes the Teclast P80 support added in v7.4-rc1, so I think it can
> go in as a fix for 7.4. I do not have a Teclast P80; I reproduced the
> failure on a KickPi K5C as described above. A series with A133 speed
> grade support, which Andre asked for, follows separately.
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c   | 1 +
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index bce4c87573a..6bdeba47749 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -110,6 +110,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "airoha,en7581", },
>  
>  	{ .compatible = "allwinner,sun50i-a100" },
> +	{ .compatible = "allwinner,sun50i-a133", },
>  	{ .compatible = "allwinner,sun50i-h6", },
>  	{ .compatible = "allwinner,sun50i-h616", },
>  	{ .compatible = "allwinner,sun50i-h618", },
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 9261d148a16..5d4ff192e99 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -324,6 +324,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6" },
>  	{ .compatible = "allwinner,sun50i-a100" },
> +	{ .compatible = "allwinner,sun50i-a133" },
>  	{ .compatible = "allwinner,sun50i-h616" },
>  	{ .compatible = "allwinner,sun50i-h618" },
>  	{ .compatible = "allwinner,sun50i-h700" },
> 

Applied. Thanks.

-- 
viresh
