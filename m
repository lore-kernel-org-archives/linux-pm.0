Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEB3537F0
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393428; cv=none; b=MmIm8d+YBb955SvZs/C1tUW8SwT+VFSojJBf7G3oONhFnfj93dzuu9Ab0vcc0rcYvRiebj5Ym+oq4ug+hlLWgeRCjDD3k496oG3Lws6trHR3Mz8P45+8aGDFw8TyQb01b63ajp74Ofr8MOeHKNphM0RKHLT3RCNq8Vsi9SZ/GAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393428; c=relaxed/simple;
	bh=Bxyhf7q9gjI0v0lYz4BDkGeko8Jyfia+b2AOYu3ke6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwA2pT5JwpfsoV3aBuGW+sVRfOwP3gDVL+s2YEmMChDdo68E+h9CxJz4k8qbF7GFaonjI0aM6rS+Ovf3XGrLVeHfdj0zJhQtylj1w4/RkP4QVwhQvF5ZpWLM2R3MgDFU8/XHurV+OJf8xs6miNjLdXwniiQWYjT1hueITIGImjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAeoAlIU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAeoAlIU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae43042ea7so24719225ad.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773393426; x=1773998226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVk30x2ccyn17PKs2fTExjwPgJxdrgV9P0kUxQuXoMY=;
        b=uAeoAlIUoVDlkI8w3HI+oI3oKMzaiOufCa3eM6NLlx4EKRSbVaPnnAm6NrA4WGnQNN
         TlKsRalbe51ypn2RwDcyOh8twSCM+kiGEmDv6tAkMNkLEsoSbZeWz1ZGoFfvb+cRk6HQ
         14U1wqbBl537tjM+EI/7yaSh1qGggQdYxu9g0qFRLQsqkp+C/mtZdkf2xOZ4yDXPYN6Y
         IL8c/1SPOgVbGCHr0iZwGXW8ykv2hDJJus5Py992hVKDQmGihTNZUvpBoMvMZ+leYxfS
         qcaWncZPZvNrL4eeKu9aSXz1Q6e+3Evx1ey6IT/c1uyD10XI7c2lFo5KWzSyl1jcDb3N
         Ya4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393426; x=1773998226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVk30x2ccyn17PKs2fTExjwPgJxdrgV9P0kUxQuXoMY=;
        b=n/1om/knDFR95/VsaiDirARpECvdrAGsfSa4Tkj+rwtkZ7peIXPJd3jYagZ1KTh6+e
         i0YVeqFlmg0DW6tjlM8bMP1OuaD9Ych7KkWGwFSGroi72hMo7rzaY5mNZ/gxIiuQOiQ4
         DHiTweZ4b6TfCjQ0R2DImw8k3OpNuuYrLHNviLuCiyy2wQvG7gIyFnlXCF5kAAOVUs7R
         lokUnMQMsHj8X1LOZnZ/loDLwdV1hwAx7nMU15W/KdoMiIZ8BtNbMrIRTa7EclYqH4Hz
         KkD7DLG5ksUlU73XxmiHwAgVFPLOOnmLJI8EikBVMt4RIMkyrZAHQSP5bPGFRAQYCH+E
         Nb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKF/KTasRGueSRWnE149Fuxc5sduxNLE/9h/d2VnukeZUUITUr2L+k1d3fJ/2XmQ/jumyqNFd7+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym58fSqAlSBvfRFgZtJtT8rQrhNo0SbnxarYPNZNeE52924YDr
	HVDsq9zE1vbUu+HXustzrILr4DqA9zofWBJ7WT3R+SNMrvaKpIe97HdWo2komQwIe2M=
X-Gm-Gg: ATEYQzzqpxhPjbBMFnPR7707q/W68BViOCJpfLyLUzxlRCruGSQ+ou8hMLKDss1lVvq
	/E0gWRu4+zzJUtJJ3ODJ3fztplWv/g9sQxJPadN140BbfNSa8f9+jKBFQiybpX5ywQK5R/dsEBK
	nwlraObssO2e8moQ8vhCdL3/WkiUEtcuIvIVk1cvPD3DSvOjCB79mehjGIdMaOfLOracpJo2XR5
	xzXOFh3nq0gChnv8BeklpRqJdtZhFR2u0Q5ZsrLIOQQIu0GfV5QL7UUXh4g4+yJ5M6y0rrGtIT0
	tCUTc9pHT3auk8Ob0QMUHiLOHiPZDk+gxBag71tIfylpEAa164HP9kodn2KWFF4lyzGoObFDH4I
	odrb8oRXB3j8DmPYPxF32Io8yS+Hm2oZzY5aaQhXyOCz2xOFFy/1dIeUzc0Mi2i3lvx57CQgk0u
	GbDEz/D9nt/0pZ4CqbmMYBbYUh
X-Received: by 2002:a17:902:ecc1:b0:2ae:8055:62c8 with SMTP id d9443c01a7336-2aecaaacbe8mr27158375ad.32.1773393426309;
        Fri, 13 Mar 2026 02:17:06 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm15213115ad.17.2026.03.13.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:17:05 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:47:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Christian Loehle <christian.loehle@arm.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
Message-ID: <4uhea7kbp5u46zmob5jasrqq43foh4lixk7qycg2gxxkqpkg7b@beycxyimpme3>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-3-pierre.gondois@arm.com>
 <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>

On 11-03-26, 14:52, Rafael J. Wysocki wrote:
> On Wed, Feb 25, 2026 at 9:49 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
> > -       if (policy->max_freq_req) {
> > +       if ((policy->max_freq_req && !policy->boost_supported) ||
> > +           policy->boost_freq_req) {
> 
> Are you sure?

Its messy for sure, but looks okay. We register CPUFREQ_REMOVE_POLICY when:
- max-freq-req is set and boost isn't supported
- or if boost is supported, then boost-freq-req must be set as well.

> Instead of doing this, why don't you add 1 to the policy->min_freq_req
> allocation size when boost is supported?  You'll destroy the policy if
> the allocation fails anyway.

+1

-- 
viresh
