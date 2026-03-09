Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE93603D1
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038463; cv=none; b=c5sNZ99WsUwLls58Kg8f86YDhhGsrYK7BcsB673p8LjdmdV+3oucUPGvt6iV4cwcXfn5tbGnLV1BrcFpcqo5XPRJ75ze4lQ+9fj9CAY980kr2i3lqedvxiRxUjYEah5Rm7v57IXcvIeEVU0x+BFaoX+wwqqPPpt/irknz8/MBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038463; c=relaxed/simple;
	bh=5/jmDc3aY0btN/p2rxZfVm+1iVdF6Kbco9rcsNTxn6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUFyydjKLyG7FfctKhdHZMSMJ+j19eqYDVmQj2YOGhqiteea7eqKSRkWEHdWnSKdPOQ4QZc9p+9ZHoNN1V3Rv7YDpTHp1X9jMZVnciT8ZC7f0oOlbP60TzIQU4NJE8VCtxc0rtiCrHFlunF+57vRevs6RmkYGxfHL+exMG9F0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJr+jKzx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJr+jKzx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3599019ae92so4199049a91.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2026 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773038462; x=1773643262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW0MZcJRk2sqhLDVCnNP5rTQ0hweIcxDtGuzOsuQ5ts=;
        b=fJr+jKzxzk9nfoWy8/WCVV6FHKQbV/wfhGDeHOzYTPwA8j/PW0zEtcrDm85XX65888
         HdsF3u0FCpYk7aRCDXdfF+Tz3LUMldXDfGV+RE8Ma7yvERLUGq40g1rLMKzZjwR+JIfW
         poGbS1RgUOaP2gJJRPPOgNCcAY2tH7El0Kj1MsR+oifb/nvm1I5KM6Ds6KKkwGPa+hE3
         KjkHffSRtlvi7H1n8eJvk8TmgrfwG8BaTxblcwYrzzLVoUEXe8yNZEcpu7epn1HSJnQX
         ZA3kSIB7Hz8m9hd16+GehVum3Jx5nbd39B+RgzBxoiYcHcSwp2hJAFaYEakMaxs/VsJc
         5GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773038462; x=1773643262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW0MZcJRk2sqhLDVCnNP5rTQ0hweIcxDtGuzOsuQ5ts=;
        b=izxpsutr+ZobbAu4Qp2saKHw6dd+D9PHviX81Ii3Qm0oJSUfNVqE/M65Ejz1Swt4/G
         dakQD8a7EEJ9CsWcszAD3x6VVmCm3VG/nF2LXbFtWfSHis8XCIw1XDvUtl+ayqeF+XrR
         CD+3fW7/R7X8e31hk9FhK6dgF2FtNSEfG30sVJPZYNgVguKFlqi9AIk57kKHBz5XcBuf
         h+JmNZpsX1goQUdYK9Ha1tafwJLd4J7qopQ6DUafAyR7A4Wuu80P+g9BhmOJYobzbb0L
         lBp0eKi4ZUa6kHZbUF2fgAI599e82figDp7vnSejQxqtSrmosdtRP99mddgP4R/x0+nI
         A87A==
X-Forwarded-Encrypted: i=1; AJvYcCVUrvKJO3W/3zDjZw9PL4no84VLNT4oDKCOOs4IjFDf7Wn77/olPoCn+RRGFlkOvUVRFI3COX5yjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYOLyCQY25oJ1lCBPyNDnJij13Vmqw30elBeflHzIrVyE2XEU
	lauwBoqAEFRgatNqy9ChJrztyOPIXOLUDdLxT7+OuAD+s0STKB1ibzVll6dk6JzTlAw=
X-Gm-Gg: ATEYQzx+UTDVGaZbhGFm/L+BF9PRnAnevIQyoXmySlpb4+MpwFM0kIx4dsipYAOhfzU
	JA904MeARpwf69AE8FN1D8QBYq/c5habP5gYGflxIRHkbekdwhekLdgvdqJl9DwJJIgf8vQMIIX
	+m+n+XWI8vm5xuedGarflpQKI2RvEt/jf1KTETANKteiW2xsLuRTqeIfuTWem7ewHr+eo1fGK8w
	7VRAht/2xFXl/7238XI8+1I3haMntHwlXZhxy8VaQYtTMmmOLBhced21hFZ7YM629yWVhHI7Kec
	y0G7473JlYdcFDaV9q7A1rlS7FkKr9WhF/Ml3dGLw5e2Fg+MKNLoI/BzQAec5XJmtG6cL/dvUeo
	vCZnGm1t9hKrn8Eu5AnSxszqmcLZHtALsCYDHb6BgIFYPMTVz8Rt5BdkuajV1LcV8rkgljvsWuu
	SuDq+HSd+cSNVCNm7lAiqokvKX
X-Received: by 2002:a17:90b:2496:b0:359:8564:dc0e with SMTP id 98e67ed59e1d1-359be21aab6mr4814181a91.3.1773038461889;
        Sun, 08 Mar 2026 23:41:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbced910sm3768239a91.5.2026.03.08.23.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:41:01 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:10:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: sudeep.holla@kernel.org, rafael@kernel.org, cristian.marussi@arm.com, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix of_node use-after-free in
 scmi_dev_used_by_cpus()
Message-ID: <4txmeyv4b2r3avz4rrkpzyyvenywn65qqhqmxw7zxewcp2engl@pxzekwutillr>
References: <20260302155348.26374-1-18255117159@163.com>
 <4lbgs3xszh75i4nucdhkbi2j33xvu6y3qfkilrshswbn73kpo4@kp36dhmrpogk>
 <5507e0c8-9733-47e1-bd8e-a335d39ad5ce@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5507e0c8-9733-47e1-bd8e-a335d39ad5ce@163.com>

On 09-03-26, 10:20, Hans Zhang wrote:
> Thank you very much for your reply. Then, do you think this patch is
> necessary?

No, this patch isn't required I think.

-- 
viresh
