Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F739DBCF
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428729; cv=none; b=juAXwFRPvBxhRKoAr/WgIDRrJJstW3nNEVMow0yUkMCsIALvUc7QOBG9dBoeafhT5k98jMzd84hE34lF4C/+ASr0MOhZreHtBQqgJhjPcryV7s6e7mVehKJMC5ux0QhUM/TN/GeEI1n6aDCrkVtyCUKdkMKp+Pbyct2BAp3ukgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428729; c=relaxed/simple;
	bh=ql10Or8hiZY36+yC6GIP6J3uCWm53wVebObAMuxnouo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9UM5nKpCqW7mZZbctdpv5yGxpLsjnDzq9SocgmwELcEv8ahQXhbdlouVqQjQxSPOR+rPupGfOK/04ejU0kvVmMGj8hB1usmJTprCNGbdgG1sEVTbqnkCg1fI5DbzfcAx/sXXIAblAKiYDYFzpAcE5yL5kGb0IA+BLlFOFU93zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8GSlpBv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8GSlpBv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36974220e45so2936745a91.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 22:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779428727; x=1780033527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AdTiE2vtDA78mvf7eekNgfm+Kot3vVx+O2IbULE3WY=;
        b=v8GSlpBvs2fHCgzvmATa4KCdIG8EGF5eOEdgwDHBPsGMGcmMoagZsTgF7Imnl0zKco
         EJ9Wu6xK4RLTsOxATaUujP+0gt1m0RDTImRUbtFCGeTAyzt53Q11gRJQX2DismUdjLnK
         pl56jmHU4T576rZZ7JLnuOzMxog6zQyyPKNqhU0Ydp9APOguTnuwFZgnyVIEeT3lhA3I
         kqqyGdotQ3IM3LUkAemNuQWKzru0yEhpAJb/XpemW8SKs6dOyBlRt5TjmP2oyJC8mu0M
         4jIxW3x+rYeJrZH9I016CozUIajRsg4V9HG//IBlXIAGu6Ce3FnlJqKw+wx5T9z45Ieh
         XTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428727; x=1780033527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AdTiE2vtDA78mvf7eekNgfm+Kot3vVx+O2IbULE3WY=;
        b=Rp3iLCAjffijPD2g5sfZ/9Tbo7vnIuonCuk1a1IKUxa50JahWlRS1kqZjBsyfSuwHY
         qQJDH7ppGw4l6kBZy2hCEWLTF/rlZhpZuxLfq1h9nxTji7d1kTInHv++YR/0z8UPsz9+
         IGw88rlqBJzhJaMm1sO/b+q8xk/57baXnAVJIP7cjPPvB9lI66KZr2le4M0Uj9J5nhQ8
         BR8qt/jPC8hnMhcPyxHx7KO8qqybCY6LYDbGNsbBD+Yu/D9B/Uze7sOvlqYuaPHqOrwD
         H9XlMr3o8/efA2UMJqwxxvFDSrb2TKGmABEJRrHrVd7uKZuRDf483cnkhYEAVenWI58j
         qmGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5vbqxo2oqUWqlf6ZWmQDzKfq7B71orehw2mEETVdutB5QQTsWpbJpfJTPCEGKSBACkLR5RTx95A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fdKUIFBF2GhCXDIvqthfcrAi/Ti9CZCCuBfWMNsapoI6e6mG
	LbxaCQYZSc0UKrbhuYTSxLjo8QTRGHpiQNM8Oe0+GdbGYiHcvJmg51aYe7WI1TkeKlc=
X-Gm-Gg: Acq92OHasgEM97MveWiitdayPt6OJogdgfXscdPUXjG4B//CWafD/OI146fGlzP3HyI
	M1T5G22p5ehWASlGBDNa3y/dTrXrS3zGc1viW1TqHAGVgobIbA7/+2cgZGXtyKAp2KJIstTVjEx
	KJK58GpEO03V+Oy/uWrnn0ANgdJdeILCtcfLZhYQsomwaz7joWnCvNtIHZt0YPp2EfMobT900or
	cns5986u/JbbCvrAS5GysL9QkngbOEcSZTHvkRJtvGtt7VHOXqknwpoRuvesG99jPUjUe13GktB
	BFMcPJVz0nbFI4I67Ogn8c3vU94G0Ma44k+5V7lqeCB+cMc2gnXHwdOCQoOtDDSCnx4UxFUaxEQ
	1sdQ9A5XgWa6Qr05wfAF31N5VoeD7TRyaV8BqybSYM2RhnujAMUJCHyQqMusrkuoiXWTRJqkp7X
	E62AseccRjEjfQm1oiXDpQrz0=
X-Received: by 2002:a17:90b:4d10:b0:368:3830:a8bd with SMTP id 98e67ed59e1d1-36a476e8096mr5157885a91.7.1779428726951;
        Thu, 21 May 2026 22:45:26 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852054c8absm434491a12.16.2026.05.21.22.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:45:25 -0700 (PDT)
Date: Fri, 22 May 2026 11:15:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <jwr2oiydbpebemo73ylwynwopeujc7mkb2nrqhugmoq2y52via@yspktx7mszkb>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511135538.522653-1-pierre.gondois@arm.com>

On 11-05-26, 15:55, Pierre Gondois wrote:
> This patch is a follow-up from the serie:
> - [PATCH v6 0/4] cpufreq: Introduce boost frequency QoS
> https://lore.kernel.org/lkml/20260317101753.2284763-1-pierre.gondois@arm.com/

Apart from a minor change in patch 2, looks fine now.

-- 
viresh
