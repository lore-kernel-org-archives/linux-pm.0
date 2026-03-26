Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C324B2D
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514421; cv=none; b=PtfYlRkQgTfP9plSX1ZW3L8QbdPc3OFws3pVJqPa8qJIUB3SGGAQ4FfgXTGllcL70Q8KXerSWNLyk8tbe7X96wJdTYq+c2fCJmv3U1VdiiMFx7Dengbu3pfapWZU89C/CLQWi7gxIMiiCYKz2j9SrU44PDxLkCoAR5baV3ntpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514421; c=relaxed/simple;
	bh=DSZJ2FwwLCPp/kiav+J8XQ2j4Vg+s2bemEyFG4suHpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYpfhZbl7xoK0Vcvvsdtb8HHOqH8JuCXNAnnuTjcrCf8QHfM1V7+hf4IAq1IIU9jr/Q53Y2lKbaZ7wPEN4D3uKSvDa2AeEaujC+fUU9n3KFxUFysZjKsH5m9QK5Ly5VNHPrSSwR9zOiy145wN5rbzrNwllw4HhrtKcl3iYn0Pl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hw+0YcLs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hw+0YcLs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso405454a91.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774514420; x=1775119220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KL2NgmrtORdxgjLm4ixtWYKY0+c3l9qFuzavLC+ycg=;
        b=hw+0YcLszGBzuqZT6hHb0s8xuokfEdgSDnLvWcl8BD9anaZgrSjOUJo6yXC5i7wC4D
         /6WQl3eGKi1tIgPooe8YkXiOrGXPKwlKv6ochaKfxCqG28D+h6BgTxScAmqa0fiq9L7a
         TiI9SjWTr49nUyRnEyK62umMfjAjgtEMqEvjoO8qVnYw7hmviUJysPrjPQQaQ8ORh+Qu
         CwSLrl5EqAfThexSTAgoJsQhvSlztxR2Zg+6WSTxy1ErzcqTGR9TYp5I8NeMudrRtSq6
         cfMMhNxxaOjwht1V9Nkp70eYBbZfBtJDFlsBsmwbzzaDS65GQx94P8wbWFeNkzd5z9Q0
         6z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774514420; x=1775119220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KL2NgmrtORdxgjLm4ixtWYKY0+c3l9qFuzavLC+ycg=;
        b=IlW9M5JTPzP98Wrvl+qTzRxAB7couMOGMbPDZn+FluFMgd+yjvbhZIVuQx/b258JXR
         F8aHkXIXmFr78pEjqg3NYq855GDco30RXJNZ0yK2dWS/yWKTqjqXJgcsPT9fy4xGpOCd
         uo35gc4GjVbKfaii20rh7JB7h/bgyKXzLkXEh3CImEPYJ5XNTm0X2WR03uUOijtuv/18
         n8XWhnR8CDUqiDptJI9ntDdzUWhEV8Lq7Mh7Yxu9N0oQUuWui2fykQ+Si3NXW1F3SuAq
         HWYGDmiXeqk7/B0heYpmO5p75KHB3wpYW1rbAZWztzF++cv+XFHre4n/V5chPvFfRUmb
         2eqw==
X-Forwarded-Encrypted: i=1; AJvYcCXCHkmCH21HIuLydrMZpVurUgPIsyixE1Bth57ufi9XT1z42bjnDf6NOdFH+DzqSUJs/SxzZLC3Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBica6ArSUqI8gRpnmCVnfE1xIrBneKHlPBcph4lGDl44HQl5
	elVlXpqhYNFrwv0WXHoJkaEOruWssfL3zPQuqJJZSjHNeM7q/A811/xuUtqmxGul9sCGaJUbb7m
	SYPzB
X-Gm-Gg: ATEYQzwgpdcQijQCMFMQ/4H6v4SOWpdGYp54DJgezJowZYToPTxqkdyitFXfxCU/kiO
	OoCQjCL/WHDCmvoHCePWgUN3dCmQLpPre3PUEoG8Xfp7FfsqGy2FvRF5NzETZwzgcxMOeno39Vz
	s8X26eZhkZliE1csoYlz+2NdsHtx/zqGWuNanuC0YEz0zewt5Tfz/ZZj8Y5W1hLO2BcRsoM0xhE
	OgWyjWYEUYA7ayheNKfox0JVHA4gXLouAH5/cRf6CRUPw676IvEtpCZDn6T6ncaDSZA3yFF+qw5
	g1eJWzoOggTF8WO+98T65T7jIiLmo9tf/re9uvUNCxQKnurmnKqNRLfiSjhpj9YpNVxbMSPT/lX
	sjdxd8cxuuIOiSaXR1QTMRo9k/Sr+b9AsdNUfGhkie2WFpb8wcvGk0Pq1LJ+ISvoEzFR/dwRZ1u
	tKUmVldjrOf5UI/3yzgsnNlgA24DMRKsg44SY=
X-Received: by 2002:a17:90b:384b:b0:35b:9d0c:a2f3 with SMTP id 98e67ed59e1d1-35c2291577emr724375a91.15.1774514419872;
        Thu, 26 Mar 2026 01:40:19 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d09573sm917543a91.16.2026.03.26.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:40:19 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:10:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <m7ovxlp75wxeah4ia3m7aqyrs5h7mxs5fmokfgstewdbnhnkgz@i4cezzzpnrq5>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
 <6vfexdrwtftix7k4zcyftxxdzbxyrcisegrcuukyy4cbuuioo4@zi6qlmloj4kg>
 <b9029378-7c8e-4700-9ded-5fd80aa73fd8@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9029378-7c8e-4700-9ded-5fd80aa73fd8@arm.com>

On 26-03-26, 09:10, Pierre Gondois wrote:
> I thought there was an issue by adding boost last:
> not all policies support boost frequencies (and thus requests).
> 
> So blocking_notifier_call_chain() should be called if:
> 
> + if ((policy->max_freq_req && !policy->boost_supported) || +
> policy->boost_freq_req) {
> 
> This was in an earlier version, but Rafael and Lifeng suggested
> to add boost_freq_req first to simplify the logic:
> 
> https://lore.kernel.org/all/20260225084930.1692228-3-pierre.gondois@arm.com/

Makes sense.

-- 
viresh
