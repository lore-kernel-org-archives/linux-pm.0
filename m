Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96534D901
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263677; cv=none; b=dwlwPanWZ6V/Gmt4ad9Qq+S2l4trmnAQM1nCBM2GWpkPGUuSByiZsxbIU45v39A6tsEbR8tq5CV2GAcMwQxSnOafwDmgil03yK0KMCJKaTYXIGMVUggBNMsN+DcrywaiCttx8DWOx2KR+wrA3PE1YnOXWaJLKY2gIsuOi1FLcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263677; c=relaxed/simple;
	bh=qAh1VLAJGnsgqquDAhS+FfRurgPmqKRM0FABdJ7PnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVtAbhMQ6EedM/xIbwy0V4gJSRfWYOt4Sbl3So9mi9e703L+p73V6+pMGn4TQgYOL+XUM2HglskT+PcV1WIWt0rS/SHLIuA10rMIxZubHYbQFugI0j/DkRR1ZVJYz6SaYy05MgkvnOJuaZQEc8ttkSl6+OLaQV+lV4DWi4ViGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7ih3YVH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7ih3YVH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-83ef1d17904so4468016b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779263673; x=1779868473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw4GyRnL2M4P8CKjQW6uXBwJzV1CCa+rVhOUr7kFD7M=;
        b=E7ih3YVHa7B8ZfaTjL0NNSj6GH7Rr8JPLGsMlpakqHtWB5Rxvrp+2dn7pAhxIREw/3
         6QKJKBB4G528T5ayx/budGVPJyFLCvSVKTi4Ki8iEFogiBAYukt9VGYYhja5O2ikA9Fx
         CaAlZup5iB/W9hy6Oc9yltkPVQSBMbdIBnimJBh5JHA2rzaiLErUOwQSMoh/DWt7g4S3
         Vh7eurzStHO6LrgHLGhavdUA9QO00jjbjeGgjRAhT8xRikbHVucSUITGltzoWlaFgMlu
         cjGfldmKNhMwBvwJlrEOa9MA2KivM5YiILgyoexJCUzcxQsqOgqWIQfnXzBfQBx944A4
         ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263673; x=1779868473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw4GyRnL2M4P8CKjQW6uXBwJzV1CCa+rVhOUr7kFD7M=;
        b=SKtM4MCTuj+ypbNO2j04p2gjURadoUUHV9fzSM53tHn9A6HOXUGfIfPwRsJ8JdTxJb
         neFkF5NSDQxXcumRfZcmOE2CvXquzEIbIzG5joH1Sc+NqtZjvigWHxLNdGjbJcB60HvI
         fzIENLUrciwN3hrz/jd4BRl44goHNHyOxtf1PtQqC/3XocvTgpf5IiIRuhbKavgNj3Nm
         3ZxmImBOn0W8pqKIkCPdFJmMNbcZdb0wpDNL8eTmy9hHca+0Blx0mqywNSxHZnG1xLsJ
         rooHCylmtWuIHRrA9SSONI4HmsWhyg20vgSdl6oyJOoRRfaM1eDniK4xLTPxKR5gd8Au
         uL+A==
X-Forwarded-Encrypted: i=1; AFNElJ8rb5OLuReAhxEoYhwxtBVhEczqNPKFN0Mb8wkmXqBLc92FsNAzobhXRa8IEcOL3xII4gz9XzBEhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxva1JER/4v0sikOJ9kXT6m4viBYBwMFrqXDUVejkJW0nFG2PzZ
	rrm51/rpDG0u93uV5CCcOa+yYHY5iM3nbdy/rkhMeUXcYrYHvz/XmBABlKAd6LfFG8U=
X-Gm-Gg: Acq92OENhrjCOt6EaPTH/GZsOITEhXvp21Nu8C7S6OMHvFbXxsN7/dWJIVHp3udeRwt
	MeLZLIEd/ih1q+ku41Zf0bN1Y3lQ5lslnLA/ZVFpOSU+626MajZzotgSRs2KJMZ4yYPe/9+T8Jc
	gFmf63NI3FyCuUO6+6iWUJUR5FTbAdDsxOQ0Ddy/QStxTuyAxtMCItmtP0THh7eFCFbfz2lUhBq
	rbOnnMNNzrLRCL/7U20mExJS1z/4og/Q/cAH69lqlMXVsDsOoL618nEKTwv+jnUIVl+cMD0mc2F
	AfN5QBzKJdd0aTYQsyVQocywG42UiJhySW8LrK6hZus7lke1lBl+zkfz01Rw86tT6Lg5zgbpDVj
	G2h1hh/rgJT3pwUksEILQ3ljIoQo5bC/F1jr4FtiG1jeb1OUgLHDtaBVEP8MgVP1OnDFIRUvgZ9
	8LIWIAOh44RqVwI3pI34scxQc=
X-Received: by 2002:a05:6a00:299a:b0:82f:6e9:d1ba with SMTP id d2e1a72fcca58-83f33df4581mr24179421b3a.37.1779263673292;
        Wed, 20 May 2026 00:54:33 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm9950186b3a.48.2026.05.20.00.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:54:32 -0700 (PDT)
Date: Wed, 20 May 2026 13:24:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jcalligeros99@gmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] OPP: of: Fix potential memory leak in
 opp_parse_supplies()
Message-ID: <lr5bp3ndh535rwmfx4p7toyclzhibn22m4e6s2zg7527lhegwf@cnwfq26flerm>
References: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>

On 11-05-26, 12:12, Abdun Nihaal wrote:
> The memory allocated for microvolt, microamp and microwatt is not freed
> in one of the paths in opp_parse_supplies() which returns directly.
> Fix that by adding a goto to the error unwind ladder.
> 
> Fixes: 2eedf62e66c2 ("OPP: decouple dt properties in opp_parse_supplies()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/opp/of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
