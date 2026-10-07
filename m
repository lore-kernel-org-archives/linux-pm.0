Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D262877DE
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356963; cv=none; b=uhvnzak0gllezZ4BUDRPb3ez+IYwHi3upJOu7W2UScW2f2Eaa3426FJPQilKctZxlKQAyTxM8bTfno5fuDukpwwS+I+MFYr5f+nWDknR7m8gdS8TSmVOhZVRWMQZ74miYNhrirIThmIoKvJ/G1Ary0LL/Jyhza70OkdZMDPKgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356963; c=relaxed/simple;
	bh=iW3JVrrvUcsHlZnMMLphvKMG3KwNUPby8ziTuz6RWjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ927bCnEjLXuEtnRnpRaqYZUO7y3wXUwbHlam34buXfdPN2vNp/Ps1KU1AcmHKkC8bgWh7xA8tmydT7/TLmN1nBnL0QIrGpN7T8Hy3WuYWadktwzV+lQSuDu0IhmvZIKde9ngnQ1LQHSO1cf4Tb43Oi20dhMZsAAUlwFBADzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2A6pld5; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2A6pld5"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34ceab2900eso2369770eec.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791356962; x=1791961762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e34WpKUSaPAFWF8n5+ufAQ5hbBzjHzSllBW72um0g/Q=;
        b=p2A6pld5VNzoYyirqz54nL1QRvqxRL1ej6qCNZCjVwaEOMDxE9g8sn6kvvNm7yt/++
         ZjTHzIvM6cOsvWEv+KhQTQWGQ58AtByZw68U9+xN7oZWjmYLekTir23pjAGfThrM/Cbi
         9qEQnO61e5AvvFOlE/njnRNdKxaHzomOFVbwG6V90kKZoMNoWhvC1xTA+cpB8o+jiiF9
         g4Km6xZfNtEpYHiErsCnOJXO/DH+xl33kUMtiKokKySjk8Vc+aFcjhkWeV4ih5ob1t3y
         uTQogIpJbU0P4AmrKOaBryIGu9mkfGNmEakg99hOeBT7DuIrGLMYWFiksMKwUY9e8Gs9
         z6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356962; x=1791961762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e34WpKUSaPAFWF8n5+ufAQ5hbBzjHzSllBW72um0g/Q=;
        b=pQXGAAp7lSuDjMShqNGi53PQGv6jLn/x7tF8mKBBp4BC5aFpIWK9GquoTWkA+yRVY3
         Y80sW6hy0PCeqswyAm+yIJzY464bC6LeILxIQhjd4s+Y+lwIJfEpbd37m6f3yAfw4Moq
         6apvQJ0WIFaQy87uLxVN0pwaaH4iReHG0/udAvk0DTNFpaLmvZMpl1QvQPQ6VceLsTsr
         GvGwkmmCa03DtZUV8/RgqFCu6cHobWEXFlZ+T3r+q9ttgInngLTlT8ObJXpssS1gwQRO
         NkTj6cxOcVG4/jAYgQYRm86VGfUx4UrJbdJmI7behloQEVo1knp6MBA5MeoxYZUmVOKf
         VOpA==
X-Forwarded-Encrypted: i=1; AKwUvBw52PZ8zdrCU+Yjsz9nNhlhBCRDrjk4FS9al39F18zr4HErsbfHocq3ljWwoE/CMs8uhgTDP0lnUw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0MW/pUr2yoy/OBZ6mWiPjhpOSVUXqT+a/vaR8OzKEPmSSrJDq
	/XH24YHfpuJiKOaycgMg5RSA34wzia0HYan8JgBSOsBbqbVG5qJIaBJKyoFqjAdVZTI=
X-Gm-Gg: AYBFou1JR0F+YdXAbiNCxG4JWea27j7Q8Y8zgaB8YYxx5QELpjBjQIBecvmPP0g0lfR
	qvTMmNXplogupI8GPld7tH/hSSqCilqrPldroN5YeCSA8JMFhw6ddm8pjYRmttMINB0Q3HeIjTd
	QdhyNoYo59orgfOR5/dezF4WW3Rp8Jq98NAQAG7oV1a1G9gy1LXxBPCkfsZ2atF+8KjQ5BUVCNe
	jLDlQ6QV1P46+Q0Wj8Jg6dh3x4Z0wvwhCkH4fuF8gAK9xzYXfnBy29ztQ8qIlGu8TXZQ8kTBPhw
	ZV6wX+nfToVQ9GzkjrDqEFCYNr4jOeiBkr3GsFsz5wOGp26+Vx5PbyOSzVHTQVLJec4eTq4Bb/a
	q/XIdHawdXaIknCj3Bp8BNLIdsW7ZUfKbYbwohCPqwyKpkR831OFq4AHVfRIUiNqTQIAz+DVIim
	kMbseCNK4VecPsLNJFtauE8SxHAB2sR64Gyc4rDXD183Usxn6rA6tgx9pHwKLkBe2eDbRgF4St1
	CA5ekOA9O0/
X-Received: by 2002:a05:693c:2512:b0:33c:e82:70c9 with SMTP id 5a478bee46e88-3515dea1d6bmr1296696eec.32.1791356961645;
        Wed, 07 Oct 2026 00:09:21 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af90521sm9797157eec.19.2026.10.07.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:09:20 -0700 (PDT)
Date: Wed, 7 Oct 2026 12:39:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ilia Lin <ilia.lin@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-nvmem: Add IPQ9650 support
Message-ID: <asXwHVcEyf0fpvhP@vireshk-B250M-D3H>
References: <20261007-ipq9650_cpufreq-v1-1-bb808da4ab2c@oss.qualcomm.com>
 <tnmm2misly3wct7out4gybimrql42si47trcoygaquan2gm2w7@rzqqkefwdmvh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tnmm2misly3wct7out4gybimrql42si47trcoygaquan2gm2w7@rzqqkefwdmvh>

On 07-10-26, 10:07, Dmitry Baryshkov wrote:
> On Wed, Oct 07, 2026 at 12:31:56PM +0530, Kathiravan Thirumoorthy wrote:
> > Add IPQ9650 support to the Qualcomm NVMEM cpufreq driver so the supported
> > OPP can be selected at runtime using the eFuse value and the
> > opp-supported-hw OPP property. Also block the generic cpufreq-dt platform
> > device for IPQ9650 so the NVMEM-based driver is used.
> > 
> > Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> > 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Applied. Thanks.

-- 
viresh
