Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2613537F5
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327206; cv=none; b=nyPNUlncSIGNwQuFsbC2NPg7CvNbzsAKZNQXXJN9xcQ3AhoDpToLdeh12uOnsOvEKmvUpImGihqDshg5z1/q9H46ncvmItiBaMV/9sACIhb3TNpCycz4VC//ZtjhYl09IZ0pp/KcXOZWVCf5qk6gH6fC/lo3qvZIR+0kp22RTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327206; c=relaxed/simple;
	bh=kopRSpjwcg3/WTri7loWqeq4Q8ciybwVeya/bduu6bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXOAEqoca1AMx/lEvUqz8vwH4wEYfR04hsBpv0YgJ44EUvCgdHvMR3pZA4SBIDkkdg1bgRrAbd8Sj+D7tXAQew/iNGHgifRIDDOMZ6zzf6Ex7lAlRlRUJBNe9dscb6mufjyQU1v+pwkAmNn8lBFB7Ej+FKONk27y+3LQa3BtLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZxU3/Gz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZxU3/Gz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829a27414a3so648420b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773327204; x=1773932004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xym68a/x1FfGjFP3K4Q73rAPZuHx3eUOUyIrreXbH2c=;
        b=ZZxU3/GzIIaR4s4tZcMSiWcc+8b6qPbr0rAuLKMeVXg55+lrZnILMxi+CVreZ7k0xy
         97ed236r36MzVoj+iysyhhRjY380ZoYPNotfLkpdElXmmRVfM/ZK+CojzMc+QifCjaNO
         QPDdcBKAxp6P6qdHdcRP+6gDjIvx5p7SvN4D74tcY428wgvQQnBpmjEpM5KcsfBgPeYR
         94k9HTHiVB8hz2xJaYmdpn+RRVlX9ry/2PTyG6+JDqQ2I5K7uBpsQqV3yeNZ54kgdCli
         EAqBWzbL7PHkLGjHov14L2WmJP4ypS3GbvwaNJCLpUg0L0e+L9HH+ht7WTerCeLicBBH
         gXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327204; x=1773932004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xym68a/x1FfGjFP3K4Q73rAPZuHx3eUOUyIrreXbH2c=;
        b=gr9kNj8XHfjx+0NaOa2OWtvuVu7SVU1pUF7/mdMzbqYRp3Li3DzdedVWoE0YquADvJ
         pYZI2WceYdwKlw19e9BAvEu2WxBFN4Dp22INFfePkCSXRNUJohzNtrkHul5Cx0F50bHz
         bZx3HwZLczxTWyfBOWLNGbLhSkL1UuSkmxROw3oAcn/iD5gWWZXBah4O073PZYu06fIe
         7KKvXViDEqJepXbn2iLKwPrYW95RA4mUjEXTCuz4lerG5Y1NZtya9QUTdJLRF5/0Gn4i
         oHLWX/8PAxFwOGtgCy+22lm7Yd1KYGJDIg5Po2H4XnniGE30xSQeekKmubdzxM01EaGQ
         zoLg==
X-Forwarded-Encrypted: i=1; AJvYcCWHqOoY0qyWh0zfNA5WoYIx8PT1e2xDIzWIV3acWB+nguAMOnfCeTj4ExvlJ2jAtUy0hwch9IdjYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwuqihh4bvlb/x9RTrfe4y2AnGFJ1hljImdgGOUaf6Zb9MefyF
	acFQ5ilsccsnKlwfeBLh7GQSMbx9p6wgGXPRoi9R3wwDZQeD5BPLVwzSvtSGIr88Sz+xmdqx5aA
	1rgKu
X-Gm-Gg: ATEYQzxlMSOrRFJIjMndMWQYgcRaEb3+gv4h1C9s2IHpi4kfE32N40FCm/6gxMoKIaC
	b5RgWN1VqJzz3RuTUZBEhS0tusfr1r8aot/9riDbJXOiB/QjMGl+AaFBOXzJsIdgh2bppxaBQon
	E21leQMg/4iUY2F0fSxjxBIoA9LZ/AcJYtfcmL5HidUW5NbPWNwwasoJotbVfPwIi3Bk2cVcrny
	xR6N0YknexlWzoTanqA+RlPzqn/BEg5WlrnQV4ju9grP+LiHJQK2a/ZBtWbcgHMH4hg/I6Td16R
	szupFx1aWyKQNG64i7upA3WMyRa0M5suTUdlTKFLEIU3XPaJi8YzO1LxVU2ACGxcUEiNcphB36v
	gxPrmJTJRgqZkSjEchYrPCAOsNO93uLGUx75nusN+rZo3V36z5aZtCSDQioydeFyy/le4LkHoJD
	M2LKNOJZvhTM7XabHEPQALPkIX
X-Received: by 2002:a05:6a00:249a:b0:827:2891:c17b with SMTP id d2e1a72fcca58-829f6ea7130mr4930946b3a.17.1773327203914;
        Thu, 12 Mar 2026 07:53:23 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07240f25sm3402817b3a.5.2026.03.12.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:53:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:23:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
Message-ID: <4qa34snjwhsacwg3h7qn5efm64lhwyorhl3y76gm7mtirbniva@mk7albr373fx>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <2edc5f50-896d-410b-95a1-04a55cd3e12f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2edc5f50-896d-410b-95a1-04a55cd3e12f@huawei.com>

On 12-03-26, 19:13, zhenglifeng (A) wrote:
> On 3/10/2026 2:34 PM, Viresh Kumar wrote:
> > A recently reported issue highlighted that the cached requested_freq
> > is not guaranteed to stay in sync with policy->cur. If the platform
> > changes the actual CPU frequency after the governor sets one (e.g.
> > due to platform-specific frequency scaling) and a re-sync occurs
> > later, policy->cur may diverge from requested_freq.
> > 
> > This can lead to incorrect behavior in the conservative governor.
> > For example, the governor may assume the CPU is already running at
> > the maximum frequency and skip further increases even though there
> > is still headroom.
> > 
> > Avoid this by dropping the cached requested_freq and using
> > policy->cur directly.
> > 
> > Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Lifeng Zheng, can you please give this a try and provide your Tested-by as well
> > ?
> 
> I tested it on our platform, and the behavior is as expected.
> 
> Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Can you also test the next patch as well please ?

-- 
viresh
