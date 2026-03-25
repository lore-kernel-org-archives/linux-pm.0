Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213E357A5E
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420973; cv=none; b=UK+zhguFGk5XIXEYLKnVmQqLOxrRcCDABcrwKK68GeDFbWfyYZIOftidc6IZdV9hWpH3Y/cxNWkeSkz++c2Asq6z1EuSNGdqVbIMl06rm79PEpsviCSbE65hIbqfM0ohQzxx/I6ILWBJFhi05Y/+03865sjQzdbXyA/leV++q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420973; c=relaxed/simple;
	bh=PxgRccVn8cF02TlACNrcwsh3WON1Nirb5TL1ReGEieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn4kZAaXM6+Vn6XAYQyWjclnvsJkm8kF0HvILhCtDHn8zIL9of95BUNdEFPt4dhGjfuL0UYttfBJ7phApFBlcef1/HpJ/N6usv60LXFEZsNN63BBctXcoTezlFcspXGMVLkjQaSsayjNF++mWymIhVBhTOJdmoWJjGXqq5MLS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPagIaJm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPagIaJm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c70e4654eso205197b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774420971; x=1775025771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6M4B+9kyrMtUcVVbXTu+8SlccYPDUcc3KdjZB1RGuY=;
        b=cPagIaJmGj/19semEx7ShU5yUUW9rl+iH2EGWhB3EQdKGhquRqdzvs3UEF6eD9Oa5y
         +oqWbXI5+AlsUs2I7/W9nZVl+Zg1P/oAtOyzB4wqYYbCw8DftL5KckkXc+eHyYcrwkPb
         ceqyh+FhWdVOXCBwuInDqlndSFCBONEADL5LJZospY8fRCoCQFSg6UxxzT1lIIPwuP5M
         m49n8gfn3ob7ttccau6j7/KSxEOkCEFi0x3A1zIrzWaL4YndJMG8NT0iQD99Z9gQQ/24
         DaTjhXHR7AYnbe3SdY/ctVVDJsv6vfgJ9xSLMAiOa4BaCNma66FGLR3DGYW7k0TOoij7
         RCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420971; x=1775025771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6M4B+9kyrMtUcVVbXTu+8SlccYPDUcc3KdjZB1RGuY=;
        b=VZoOJh6yYP7GyBKXr/yR/ICGaJur1BzZH3L8tkK+z9skYgv44P1YwP5Fj6tBC16lPe
         eFlq/zk2XBt0nUSNMHILWVXp16toYIsLHDnp3KfdaG0KT2U/Xp+rzAjdrHlxzpha4KhL
         ozEeXeWealOxojN99QhxA8i05X1wx9c1vd7qQpEtuijhUIR0pQBWzSlPsT2QeWjn7ZKN
         BE9auqUtixVe6/EtxdUTvDPPKDR35KkqboNbwHr5USHGsgQi8b3TzINsduTv08lGb+g+
         qjln3Ie3ApFZ9GmthH6em2phXt3csPRTFqD7GqApL9rUdXvEMRcgkP1uuwiPhaQsEM8/
         YCaA==
X-Forwarded-Encrypted: i=1; AJvYcCWirJDoFKTT3J9Edt5XlULVWFGa/C8/KiqL4rWSKlwDbEJeWOqo0Pd5xveoHBvCVZZDWL95UvJMfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKi7Wib/CXXTha5duLe/52d+jl8+zCgDsRiRGgCfpBzzB75wf
	ioRqDtlch/QFLLOAof7Xdmft19yS6mDfCOsbMzGHzgtIiGTtsKSJyV3SAqEZFi0l3Bw=
X-Gm-Gg: ATEYQzybacoV+f0fCCm3w+UrH5ad1rQvdzIxTqGmmbP2/n0r2qbA9qVVAMtEaL+tR2+
	vus7i2VQiJZ4qIRiLjSEgToGelo/KsD+wMk8mFrij3neWeg61sLTDnJo88CL3cF5z6fNad7jgFn
	4JYqvFSFh5MEo+vqIhvi4Tg3RGaoGdoDlqVkbDhOQ4Sws1xLA9KzwDNVeD6sthY6+25NveylC6W
	RdE4h6ANKH/B+Zy3+MriGuJ3u+LaBLEIO1Gh7aE16nlJGgvCqI/gQsGgcdofSuXbnbHZTfe18Nr
	k2SAFLrjrqlB8aGQI+57PlyZgUS5eCzjHW+XRuNMirIUfU88DNYheKjDYczE37512y/fgzcDaGl
	WTk18N4aDtJEfNfezoe/QDHI3q9rwAS064/V3hqo2xWRkFH4txrUhQkw7pcPbpw3dg5jT/t9oCK
	Qa2r+Hyr8scd/oaLBRNsTqDXGk
X-Received: by 2002:a05:6a00:b484:b0:82c:24a6:2a75 with SMTP id d2e1a72fcca58-82c6de79e34mr2217015b3a.10.1774420970591;
        Tue, 24 Mar 2026 23:42:50 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409b448sm14055926b3a.39.2026.03.24.23.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:42:49 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:12:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yi-Wei Wang <yiweiw@nvidia.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <2qvafxg3umwqeshf6eag3ep2zpyfwxbcdj57iorlcrus3tzrti@cpnkeirybxxo>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
 <acKggw9F7oULLEuJ@monoceros>
 <4405239.kQq0lBPeGt@senjougahara>
 <acN7pSjuMkZl2yhV@monoceros>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acN7pSjuMkZl2yhV@monoceros>

On 25-03-26, 07:12, Uwe Kleine-König wrote:
> On Wed, Mar 25, 2026 at 09:34:55AM +0900, Mikko Perttunen wrote:
> > On Wednesday, March 25, 2026 1:45 AM Uwe Kleine-König wrote:
> > > On Mon, Mar 23, 2026 at 11:36:37AM +0900, Mikko Perttunen wrote:
> > > > @@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device
> > > > *pdev)> 
> > > >  		return ret;
> > > >  	
> > > >  	/* Set maximum frequency of the IP */
> > > > 
> > > > -	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
> > > > +	ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
> > > 
> > > The documentation comment for dev_pm_opp_set_rate() reads:
> > > 
> > > 	Device wanting to run at fmax provided by the opp, should have
> > > 	already rounded to the target OPP's frequency.

And that is correct, right ? This comment is talking about the max freq possible
with each OPP and not the highest freq possible with the device. If a device
supports 5 OPPs (0-4) and if we want to run at the freq mentioned in the OPP3
entry in DT, then the caller must send a frequency such that clk_round_rate()
returns the frequency of the OPP3.

In the above case though, we will end up running at the highest freq returned
by clk_round_rate() and an OPP corresponding to that.

> > > I think using S64_MAX is technically fine (assuming there are no issues
> > > with big numbers in that function), but still it feels wrong to use
> > > something simpler than the comment suggests. Am I missing something?

I think S64_MAX will work as well, unless clk_round_rate() returns a frequency
higher than what the OPP table mentions. It may still work, but the values may
be confusing and inconsistent.

> > Looking at the history of the function, the comment was added in the commit 
> > below. It seems like it used to be that the opp framework always used the fmax 
> > of each OPP even if a lower rate was specified, but after the change, the 
> > caller has to specify the fmax rate if they want that rate specifically. As 
> > such I don't think it should be an issue in our case, as we're just using the 
> > rate to find an OPP and don't have a specific one in mind.

Right.

> So the comment describing dev_pm_opp_set_rate() needs an update, right?

Maybe, not sure. But as I mentioned earlier, it is written with the context of
each OPP's highest freq.

-- 
viresh
