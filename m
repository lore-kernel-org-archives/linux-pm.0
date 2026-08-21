Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D794756B9;
	Fri, 21 Aug 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307331; cv=none; b=OQbVAFL0CTbkT849eJKcRSBP0idt+pBuIAmrHF+kO1RsjmsMjXsfRcAdB6w4zL63g4oCPaesbkw2MmJ4ZgwfkL7+ZV8ISTlwKna5Z6GiGNWWTa0BZNWdv3STVsAhwO0dCiiOWEhtGcxfLTmoNK3xzIIrM3+b55qnrWHJXYqOLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307331; c=relaxed/simple;
	bh=eFaabTXqwdlG4LEdnbvoGPdZWs8jnTCwWBAZuLgIg3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4xH7RLW3mzr3J0LevjCSftOecrivp2Dt3ZEJITka2zE2/ajVR5ete0Y9oyiw2RFlpQWdqXYNlEYrXv4YxZrkNX9aQJGcS1GxQQYyvOjP7xfxdGJZhNMSTt1gE0BD+OkdRy65//JSQQULPevbPX8Jg1l+FT5url+Fy/fRpG4Wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lPdF/URl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lPdF/URl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219D0153B;
	Fri, 21 Aug 2026 03:15:11 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4389F3F66F;
	Fri, 21 Aug 2026 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787307315; bh=eFaabTXqwdlG4LEdnbvoGPdZWs8jnTCwWBAZuLgIg3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPdF/URlUc7S0m/7wWtLOV49NGx5QWPu6WvfQsnx0O6T9thsVd7CWtdufxrGOtBgl
	 PoGLcE+NV4Rnh26G56FVOsGIlMp8sX8tC9ojTMhLLX1D/jpTtoFDEPIj10nyW3J0GY
	 xAtmiIWtxjE4EDRuDTZZIRgoonkWE36qdpQGVANQ=
Message-ID: <ed4ab782-e4a7-4bb4-b63c-3ecd24e73ad9@arm.com>
Date: Fri, 21 Aug 2026 11:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
 <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
 <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com>
 <bc9c2236-6411-4ff1-a03c-d97997b5f780@arm.com>
 <8b728c1a-f783-4660-8ed0-eb131875f2d2@oss.qualcomm.com>
 <6d5dfbaa-f0e0-425e-bacf-f177185d1eff@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6d5dfbaa-f0e0-425e-bacf-f177185d1eff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/26 10:28, Daniel Lezcano wrote:
> 
> Le 21/08/2026 à 07:03, Maulik Shah (mkshah) a écrit :
> 
> [ ... ]
>>> What do we do about the cpuidle stats in that case?
>>> I'm thinking primiarly about last_residency_ns and rejected here.
>>
>> As the idle entry will not happen (call_cpuidle() is not invoked)
>> the stats would also not required to be updated.
> I agree, with the IPI pending it is like the idle task should have not be scheduled, so the idle call is aborted.

AFAICS since the ->select() callback has already run we should
set last_residency_ns == 0, like the need_resched() path in
call_cpuidle() does?
At least menu has a semantic difference in how it decays values
for get_typical_interval() between a UINT_MAX (i.e. invalid)
residency and one it's never seen?
