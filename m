Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E322352F87
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420116; cv=none; b=hs3HYcflkIeJtQlzmcQFZd0fPedK6PFNaAAfms3ZVmC1thH3iS190XSa4rjtTPKfPmnt1pZFD/0azbIaRYJaOWYVg58p/I+87r0uHuPFgUQ2AMuJ3P/fhX0bM/IFlydN9jlkozarmPi05OqJsfDGlaNc28h7OuJ2gVr9Y/wge4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420116; c=relaxed/simple;
	bh=V4ID6kRY1CPCDouGJINvI3V5tewh1LOXmYk1CaewQK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWO1d2xbMxQU9sEplhB8axBQKNjHWJH8cxmJQeScHT2kQ7cXrvYA/HNd/2Bgb8GWkNUDBNH5RWE2ShZpyS9anwrxxFw4XaClz0YSArHUcbjWLYFFc0ShBXaUhL9rKxcOf3URoqy1SlNjMzU/+LCKFI8O+glvQUdPqt7BiXSyao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HBuR5tAj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBuR5tAj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7412b07f22so278625a12.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774420114; x=1775024914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aXgKs6So+9ysaTfAFVk0nSkShZrElkjbltdMt4UBoWQ=;
        b=HBuR5tAj9O7C+vig33CUBYhC0jvtNaGE617A7cjs64NgB4lDQo7KiLnH+p7qWW0g3H
         bvJjtnNMa0nKhmztKlRoBkcyzxf4M68D6SV7osdHvqzg9/1ga7tVw3WVbKA7U2iuoec1
         FbnFBarOtLmiQphDrZSJLFNAxHPSM0N8NlVBFCsAJNxcuuaT5czUYeHeCYF/ose6chdl
         iX+cMGFic+puOMlcA9xGpl5/PpWCuwGfEFJuscxaXSyIMi/bX6GrbBkmWo4IEoPRjoO2
         tzEKROBsIMX5Y8u8NEQlbjlHVeb3qvUBIhfIqM+w8KUhMeT2YgJYC6V/n2fMZsbwIsgp
         0fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420114; x=1775024914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXgKs6So+9ysaTfAFVk0nSkShZrElkjbltdMt4UBoWQ=;
        b=EV3z5W3Bj2Vt3PC3pMBJd/rKz9hvuZAmbKxy4xj735zTqngruxjxrUQn03cIhlyqPo
         r6G14A50Ko9zKqfU31iXKMsutufmI1fCKqTMqF8Fa/pGmfPMdAl17fXmheQpt9vdEyBs
         2cZk0YxNHv8CBjxRDZDdse/gLMqhXowbHOV1uIW3zIlEU9JUnfTZ4+huQvRs4D5iYqJd
         zyZguQ4zlc33tux5RTG2EgPHg2H7MQpE3x2okL3hmvhb0Z1z41vzP8XbUcXoSp1oVEkK
         Gd0H7RawwCxG/Os2dM3wVHxzKExBpBdxdOdSIsNoJadrtrrOEf2pY69IAJT6Ze7bcR4h
         9Jmg==
X-Forwarded-Encrypted: i=1; AJvYcCWNYRV5Rb9R7LaZcgS2z5DvShNK7ym1XuTq+ZZm3AEY4yGFHR7SM014ChZqJ/6dNOXNRxi6I09ZpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMc9f2+eLWvDjJKFM2HDiOPFwB1k2RoFa+NrkhssRmtBGVNBX
	BkxvDBMBNuPGBWwk6bSHDw7m3vWc2n2FM8HO4scuf7918BJMDJH/znXvGbKFAwZ1kd8=
X-Gm-Gg: ATEYQzykVLUHiTyIiPfdoKUWBCk1kq3A7oeFx5hUs1gXmKljddUMbG1dtnenkANGObS
	NawI4+h8OoVR/hDqNQdzWmWRRYoLBl8VKduOv93TMxfN2X12aAr9btuYHFIKnVMCp1gQim+2sDs
	xq0LPWic1xeP2lSxWluFtGqFOX4WQ3PMoEPnUc5ER6vJAKDLhwH9zgYIBwgB4Ia2/bx5dIvu6es
	POXxX31fKiipf2e3dQMQU2LuAIHVQ9LAuWnCAANJvy8cs88mqPc0NZLRS3YxFHcmaVUy0rqjQBX
	6pGouYTMWoVy1+QDftZGgBxkD3m8l/g6suJcTEZ8UO3Ai+Wa9uSb3mWjfq51hOv3CA8ROwAUJvE
	vrUseH2T9X3zbcT/5XaEaRE6CE8fe9lktRmDT6Un8BQGWIS1ipHK4JoBtsTUoUKZs6v12BnZJdY
	jt2KPxOrKjqJ4FFSYSksB1zaP6
X-Received: by 2002:a17:903:18b:b0:2b0:4cf1:cd4a with SMTP id d9443c01a7336-2b0a4e45b04mr57921115ad.24.1774420114098;
        Tue, 24 Mar 2026 23:28:34 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm229567555ad.72.2026.03.24.23.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:28:33 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:58:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
Message-ID: <y5wy6jtohwlioy5mzjcnp2fc7ojwhmfk7fk3yzpfdsflz7u6l5@roehvz6gyk5b>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
 <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
 <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>
 <86aab895-5945-47a1-bc58-12747c7d8f48@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86aab895-5945-47a1-bc58-12747c7d8f48@arm.com>

On 24-03-26, 12:39, Pierre Gondois wrote:
> I experimented a bit more and it seems the following happens:
> 
> 1. boost all CPUs: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 2. offline one CPU: echo 0 > /sys/devices/system/cpu/cpuX/online
> 3. deboost all CPUs: echo 0 > /sys/devices/system/cpu/cpufreq/boost
> 
> cpufreq_boost_trigger_state()
> \-for_each_active_policy()
>   \-cpufreq_driver->set_boost()
> doesn't act on the policy where there are no more online CPUs,
> so the max/cpuinfo.max/max_freq_req is left to the actual
> boost freq.

Right.

> 4. online CPUX: echo 1 > /sys/devices/system/cpu/cpuX/online
> 
> cpufreq_online()
> \-cpufreq_driver->init()
>   \-cppc_cpufreq_cpu_init()
> There:
> - policy->max
> - policy->cpuinfo.max_freq
> are set to the maximal non-boost freq., which is the correct value.

Right, but that is true only for CPPC. Not all drivers would set max freq from
there and depend on cpufreq_table_validate_and_sort() to fix this. Which was
broken earlier, but with my patch it should be fixed now.

So yes, we will have max/cpuinfo.max_freq set at this point (with my patch
applied) for all drivers.

> However, max_freq_req is left to the boosted frequency, so this
> is effectively an incorrect state.

Right.

> Also in cpufreq_set_policy(), policy->max is set to:
>   min(max_freq_req, cpuinfo.max_freq)
> (cf. verify() cb), so the incorrect state of max_freq_req is not
> visible.
> 
> 5. boost all CPUs again: echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> As the max_freq_req value and the new boost value are equal,
> cpufreq_notifier_max() won't be called, which means that if the
> CPU needed to raise its freq., it won't be notified until another
> event trigger a re-evaluation of the freq. selection.

Right and max/cpuinfo.max_freq will be incorrect here. This was the issue the
commit 1608f0230510 was trying to fix.

> To observe that, I had to:
> - use the performance governor to be sure to select the max. available
>   freq.
> - observe scaling_cur_freq to see the last requested freq. for the CPU
> 
> So IMO the issue was actually fixed by:
> dd016f379ebc ("cpufreq: Introduce a more generic way to set default
> per-policy boost flag")
> which sets the correct max_freq_req value when putting back an
> inactive policy.

Right. This patch fixes the issue I think. Your patch is fine I guess, just
mention this reason and we are good to go.

-- 
viresh
