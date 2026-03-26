Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5934B1A2
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499829; cv=none; b=O9/gAV8cWA8w2VecDafZouYGeKoWaG7afg2qQC4FznQ1mlgFJyhDju4Gc6r95A9mOyK+R/kVsRqJfytu3AVzi54PvXmdGriAaA2f+PVqTEFBoT583fRFHTauI94KN2+EC/o5lSQpk6eZN9mifpZT3s5zZVebV8YbFEzxALKYe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499829; c=relaxed/simple;
	bh=LtHLO5OtamgOaPe+F2jdEl6b+1ElY8UK6Cbk+m7GUm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO3pcBa4uQEX/gUPu1qf21VsIzl+s4vhq7BQATjoDxhwLXMJdMc75RJIDb9pZd9IxCT9sDBdCBlWId5IHlwjbU44Rme4ds9QcPPUw7KZezG4oSdUSuhZaLTOguGgeTihpZCZtbli0siiCaC5khsCFeXjoWPWdTbk7iBWCtpb87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L69l0sWU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L69l0sWU"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso383015a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774499827; x=1775104627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqi8uiSPRzdKy0pq53ZZHrYeRlrKb2Fz3+Xt5LonQlE=;
        b=L69l0sWU1rI+Cow9eMq4dBdSyzoWYcDzTLe5IdFTdBHoxYl05kN0vv9x2Miuk8OnUT
         1HSa8CJThv+IVc3OwOZb2CCtsAsL9SZzrjwqdAUT87PGcDyLp2d3qNCzSux4rj/dUfFZ
         sLo/bMd3pqPRn1vE+jhfiReRQfJ4ZkPUxBpYoGbUlgz9vaMuEevKSzvE2uH4PPguCeUB
         OHdTdFzcEMcnnZdzvEZyYDUH9t2tntBEFxZ3i3atAnvQIC1wXkXhbVM+PezxFplf9HQY
         Z45+NQ+B3cP616dQctWvg+2k7Asw4bajdnYTcwXHOxTi2PC6bVvZOTzf5koQ+ALyvghM
         IEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499827; x=1775104627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqi8uiSPRzdKy0pq53ZZHrYeRlrKb2Fz3+Xt5LonQlE=;
        b=le4fi0d9RZ/hwHL0UhZfKU2QbGy+afs/i2XcL6pibNKJ0urvG/26brXqfJd/Rrr1+0
         sbyyCzu2ifay4ANO1C5CsHFcWqhtf/JHOQr3uelbWrYs038OKyx9lp+kD3Q2awZu4ShK
         XkhLlRdJ+pEI7/Pk6BjLpv1FIsaBO7Jg5xP4ZivqT3f0dKEvIjVNj+x2EgJVLtg5RPdO
         /0p1zSHHou3RNkoAjkQpA7484uTpxL1NGxmeTY3dx8QcxWTSJQHxsgGilfbNLn0FUdke
         9dSOVR/3LcIcc99324ObECINwbXaulF3DtX/AS0yOUVWiQ0zF222fwcawB3C3S3Bj+Bc
         q63Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlsjpU1IsXhE4n+HsXk/61GUb019jHnx68zxj4G84sD0kKckALWAcy0UklHKkp971cyMoggT1+3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGxdmi1odWhBhwZQmrAlZsDPcIM/B6E85zOE8kpuVszajPEBC
	QBUpO3VgTLgtlHoE8jbKGVH6aw5dd4BHrO2uohptNgcwHY62sHiMEg3AkZPquwZLncU=
X-Gm-Gg: ATEYQzznyjQ47cGWhVGSEXar73JrUJw4tGlrdh/alFyykOEe2mUOZMYJUNdu29I2kIy
	NSsYESq58JlHG+eaLb0XrFzaSnSLP8vCkY4MPjaGruFIe4WuDaTAbeda6mIstbasbzXk6Vr8FBF
	jG5V4gjZucLX+fNpkYwHndcCIKSK5Ov6589gMxOewpxwUIDuJCUH8MTymhMVM3Y/GYktLJVKZEt
	UEClU4QXgwcJYuBM/v6gxdxdJ6JMTfRbdCt9oYaW9wiFxEiBEzoEb9fDv1aoq794dAR/EFdd9e0
	e6E7H72a1R6SQas12XeC3CT3zTLPMwThz1yiVuatRRjJscWvkNyu+Q1xq9WMAoLYEv82Er74OcC
	1ID3+r3v+0sOpKEsrKMVThGt8RtlB06DOT7y8tzdvYKEbxK6FiR9AQ4LZewG3Pbf2JLhelOlKvA
	bp3s6BpbnzhNETMy5fPcIinQtahMptBog56PI=
X-Received: by 2002:a17:90a:d60d:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-35c0dd7b2eemr6041344a91.21.1774499827166;
        Wed, 25 Mar 2026 21:37:07 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ba5700sm141023a91.8.2026.03.25.21.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:37:06 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:07:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 1/2] cpufreq: Remove per-CPU QoS constraint
Message-ID: <4e2ui264m6y6u6xmixvt5q2elvxsenco4r2e2axdtue3xuuqf7@rs3qofhtgq7o>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325165255.386576-2-pierre.gondois@arm.com>

What do you mean by per-CPU QOS constraint in Subject ? This is per-policy
constraint and you are not removing it, you are just avoiding to update it in
one of the paths.

On 25-03-26, 17:52, Pierre Gondois wrote:
> policy->max_freq_req QoS constraint represents the maximal allowed
> frequency than can be requested. It is set by:
> - writing to policyX/scaling_max sysfs file
> - toggling the cpufreq/boost sysfs file
> 
> Upon calling freq_qos_update_request(), a successful update
> of the max_freq_req value triggers cpufreq_notifier_max(),
> followed by cpufreq_set_policy() which update the requested
> frequency for the policy.
> If the new max_freq_req value is not different from the
> original value, no frequency update is triggered.
> 
> In a specific sequence of toggling:
> - cpufreq/boost sysfs file
> - CPU hot-plugging
> a CPU could end up with boost enabled but running at the
> maximal non-boost frequency, cpufreq_notifier_max() not being
> triggered. The following fixed that:
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> The following:
> commit dd016f379ebc ("cpufreq: Introduce a more generic way to
> set default per-policy boost flag")
> also fixed the issue by correctly setting the max_freq_req
> constraint of a policy that is re-activated. This makes the
> first fix unnecessary.
> 
> As the original issue is fixed by another method,
> this patch reverts:
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")

Looks okay otherwise.

-- 
viresh
