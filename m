Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64653845A7
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609928; cv=none; b=D23tVTXkGfrMk6IwMk3FPvoYlziypCPtuZ89GhRkwfrb6ynQYW6Gb8vA8OIDFRHWMWKBxKY62iUdB0dsBRQN5jxYZNPxhIp5F8eZ81mxMotC0nMDjbK3/6JPUAKHpKMuS4BM9Ka8GQ4CicZ1Omo3iifdJmcZN+CPNP5EBCeshTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609928; c=relaxed/simple;
	bh=WyjKr27BexD8uSwIrNS1ESTwNr61UqqGx5Li5oKMhiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnGaDk0dnh6AFlNL/w10XxVPkM7fILlc6//EN87e3tQ25m+Jevng1ZZ/dVYk0koBGC5obdslIH7ndrgImlSVC+lBOGWhFgljwXyfX3c5FCtBkHgF+DSjrQAgctcDL4CywiHezWnppwClKPS/WENOPCBngwCuzkPH8TSIj3uD8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBwoL55a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBwoL55a"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca957432c7fso7387302a12.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 21:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784609925; x=1785214725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbE1vu8p57+mDxFNsPodzCeB4DHzKs8bR2Bh8D54hrw=;
        b=YBwoL55ap9Mx161FMYmjosfvgg1kQCLw+BmYm4PeoW0vgslej0Uk755CZm6iKHsWJF
         SiwChmttr5z0bx+1KqwStU3wD08/16y8oIsAdB4umEh7DTp4aQOadBUSlCVttKLPjOhd
         EkRIFKfetin7wKrm7I/bytgnlEgJurz06i3Ekk5lSdAZRZOKil7efxsTlYISRq4u+85u
         FLfPqEYvpu45ZGd37iaajbLA1JNazCOhDUwaTjErbJvuG+sYF1rQDabv8cVxFH+bE2kA
         ZeUBHsXuhQKVpt5domQ1USzubjeb9X3rkraStdnCOPRqaBKQ423F4CgG9DIbsl5d58oC
         aaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784609925; x=1785214725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbE1vu8p57+mDxFNsPodzCeB4DHzKs8bR2Bh8D54hrw=;
        b=U8udpSvuH1J/In2OgsRpXRWwRaET42TjMQpFprvLkzy21FiU2+uFpzdujenFUrDcum
         tSaaKIxy9I7W6LeCsooOzUggRY3VdzYAL9R2klxuxt/YWfMp+WSNr6IdXnl14/2RLFuk
         dmY6kMriSMdABxsAjmATzUkhytLiCWh55q1Fj7LyehIaFRM2yUKLdHbN9AzAhcZfaDve
         6QrbaD0CqfXLTYQtll1HcCgb4+vZ+c44UlXacGCLDphDo391TC/4Xm76EG+lt3Lj+sVq
         j2Euq74XLO3papzQKhuEl6tBi3AOFJtkG3cLkHrGHeYc4ljTL87/7NJXGob+xxLCjik2
         JJlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEkgrYhs+ZpjGZEL0TWhuusWh/7QNyHfyg0dU5380bv933WR07/F7MEvTY2b+xRs08iLsFqH53qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxXKIz8faBL5fn9EssQbX8wzUiQ9QOGSNur2ZKu73HLbfF3TI
	EbH9AXGBdPa7VMifMsBezUzhlZcaRxPEePHxRrFcfb+Mh7XWV1W1E/r3FopAWyrfCX1Rg3tCyci
	yiCzR
X-Gm-Gg: AfdE7cnYNJUJCBQmZEMSHzYxO/8FDrIno3LLwKQlpWARqOTrQ25S6azbMBRp0sf/XBW
	ZvgNHyqMVOIrzrn5VSG2wqaWo9Yqjz2yAr/D0cMNJblGIWUN3GoMmH6qR32+JU6f3EU56nA/5XB
	ojRrlFGkIEO4d9Sz/k34LZ3lVMvj87AhkSE7oSAHrNJ904MQSwWWYwOH+Ox6KzlmzPi/6TYSvjb
	BGlJ5ogu1m9bDBCKRUw61qm3LjlDBtU9rz7372VPBJwMD0CXa4e0Qah/f5+hdFnKGxbjbjT2+Tu
	flTH5aiVT/7f53wETdTKIaS4uHpAR4a5FH15WitZiO6Qk32ard7shU70eApcn8/CWYp0PuOa5oO
	mJL0RtMNSezJMenyPT6PXdEyPSmBPj5nOAEDeFKITTw61e1hUiixtFrG8hNgsgnPkcQaqX8Y37/
	TlWA==
X-Received: by 2002:a05:6a21:9206:b0:3bf:a638:4371 with SMTP id adf61e73a8af0-3c3ad5d4660mr18319984637.10.1784609924997;
        Mon, 20 Jul 2026 21:58:44 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm41516259eec.28.2026.07.20.21.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 21:58:43 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:28:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: apple-soc: Calculate frequency as a 64-bit
 value
Message-ID: <gleaxjdn6dyndlqr4lfgyvpnyje5rwznrktjf4e25giozkwjas@cp7upcmeae4j>
References: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-cpufreq-64-v2-1-72bd9b4e5ca0@chaosmail.tech>

On 20-07-26, 09:25, Sasha Finkelstein wrote:
> The current frequency calculation is done in 32 bit, causing problems
> if run on a future SoC that can boost higher than 4.2GHz. Ideally, we
> should use a true u64 instead of unsigned long and "knowning" that this
> only runs on 64 bit machines, but the core code uses ulong everywhere,
> so this should be good enough.
> 
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
> Changes in v2:
> - Minor style fixes
> - Link to v1: https://patch.msgid.link/20260703-cpufreq-64-v1-1-c406c705319a@chaosmail.tech
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
