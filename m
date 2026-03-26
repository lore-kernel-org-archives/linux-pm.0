Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A039BFF4
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499178; cv=none; b=i5Ff4pit1SBsO1xbLS3QgtwGRfSZlTMy0nLdZyq/eDTuCfs/4pF+tVYZ6e9JlGm2vAihJdnQT+LMMdUDstz1v5Cl5CoWMvnJML7x9joCkUZwDYx7leIl48MpPp3BpuZiwDqdEiMhuaAVzO7IrrPE9rdPg8i/pCmTFwIHawTCs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499178; c=relaxed/simple;
	bh=54xPHDRGs1foyEo1oPqLF7eX+mcuDq0ZjFNV7uXCqaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrAWjjnjpcMXP56lw1bbEjjjdwVbL7F4JxdTlewUxcEo1g6RCK/WkOMnLG1OMUBlaUYBRtlRKJZUSeSbhxzazcMDJQRzZDpcKDblxY13NwgNFgUmhPihBRgUhKRhdn0iz+gS0fx4TvjMmQuwCGvxJFLI8b4C5iZko2vbU35wD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngo+O5xb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngo+O5xb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c20b9fb16so254086b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 21:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774499176; x=1775103976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zChuSTIRuHiyAw3E5oUNHFRmmH1AmtYqK7etGDGBHmg=;
        b=ngo+O5xbCNR8bxvb63NOxNaB2QmTA91o17bhxzRotuwGpH1QuI0ujvKD5GTtX54/oR
         PVP0f3dFnBbmK86apq6gYrCJgmdShL7+OwxS2Ppioe62o7SOG5wHX06YI8S1ftjC82cz
         mQGGxtti3hYKNIwoy7gdcN/jXtTxFWVhc2MfPtr/+4Ag++P+1lpbzHjTQ8IInzxaGg0/
         YCx4mycOwMhYh5wjKXsWaMlrgxHP+R2JkDbx1PqE+VmY/73vgbV9bLgN7Uz1w2OG7M49
         OiFPRprN+Ng6XhID4pZes0PHA5UJHwKoCzfwzBZHZQZ2R5uhGIVg1LrYhc8lZ2PcLuxC
         dOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499176; x=1775103976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zChuSTIRuHiyAw3E5oUNHFRmmH1AmtYqK7etGDGBHmg=;
        b=MAnsTj+2D26Ymr8xFvVJpVO2f7pelkW5C/vGwujxaaI13XaB7F5Sd0VmOpQGgaSqCX
         QRJhsZ8Nrtm7YogNxyP+nAfWa8OfMtJM6sFFwmqZ5JCG002ge7/5uzNiM7wA8q+ycdYg
         UKKYoEILAv0XfX4zsgtXMzRM4jr+l/yU75i0zgZ5Pq96cK/jy2KvEiea7eMtlqy/YE6N
         F/NZjromP/uYbn6t3TrdRO1mwpSHK62qv7Wz1B7/o1tLWgqdRePBbY685HNLcLN9+kZX
         l8ro5kYENlRvGcEmyIo4QPi3zhkEeOolWZm3Bp+4QT+SR7s2hkwCK41EHDt4zGUyeetl
         ZEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVQRG/dLekytxIpFb31gSAV1eS2S3Jj2jI43L7p90oAWzxjsQI7Fw3Hm95/6xC7jBCW/gUzm4rCyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6kFtDGDr+adHeT53DqBMuZsxfbvrP9EpgQNf8PAdKUuKbhYV
	Oq32zg8BcBth5UG5X7sizIuNBa7BDqbYgkf8twPi4gPQD8WghGf1apUK1OPlsEMoG5I=
X-Gm-Gg: ATEYQzywwAtaFa7gp9Q2T4Y9sbZ528/rv9N2eJfeNIRnsmMEoXQCu7SkHBuU07Lu6UD
	36V68pOvuZ2PazMieVh1NzLAvlVwiTkH7HiOWvmAKrpE+eE3xIky/DejckRc46MvgtSgosXvUKb
	Er6k8m5eYEGb8XlntpPCqnmsfR0h4sMqP07wHjtTcGdLLnNKfBgf7DhH0rxT/pXYaFOrryHO4RK
	a8QrwCtYqfsUMWqdmVxxi3ocgzhpP++JT4Qwt45xp7i3GiEvV51icZHkHIFzzBFKpRvImhGRsQX
	LOI/0wrnRiKoMzebLik6/U6R5k+YRWBaH+79/KCB9by00Fz3+ztIxIb9+Pl23As3sbYnweJTZGF
	CmmfcwVPtrMWHESxZJP9sD/BzQx7p7TZc3ZWYHjb53FaYMBrbinUroJCmOcyMZCMQ0dLcH+NOgm
	xIwPAbBuh5VkjKrfQ5kBq5QJ3/2YlMdF2r1Ow=
X-Received: by 2002:a05:6a00:27a8:b0:829:a131:8318 with SMTP id d2e1a72fcca58-82c6dfa3317mr5976173b3a.44.1774499176291;
        Wed, 25 Mar 2026 21:26:16 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7cf78d9esm1169911b3a.0.2026.03.25.21.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:26:15 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:56:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <7iesu3qxb6bmr5xzgbwkmbtzgr4gcpwoupu4zsg2vlvjs24ciz@g4urekfjav2l>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-4-pierre.gondois@arm.com>
 <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
 <ab06e8d6-d430-483b-a2a4-9e7d197aa6b6@arm.com>
 <ir3mvkz7bbzwtsydrfdhnkkkseaj6fclzgiw3soxb673xvhczk@fukk5ad7jrtq>
 <583fd75b-d510-488b-854d-51312dd18e56@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583fd75b-d510-488b-854d-51312dd18e56@arm.com>

On 25-03-26, 17:54, Pierre Gondois wrote:
> Is the current state of this patch + the above modification acceptable ?

I will review it closely again once you send it.. There were too many small
changes and I got confused earlier :)

-- 
viresh
