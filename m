Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14840E8E7;
	Mon,  3 Aug 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768248; cv=none; b=Kpv+y/puMRISjGHZ+JYzHMJtai+/4XbYFzGqH5wxtI6hMcGEbOdvrIFC4w51e5ZsPkdIHX3M3QDaQ41Spmh6vdqHEelba3vD35CxTWfQ7ycxt/qPWQspM/hFTFno1z48qfR2fwS7cKib1P90U3YaNYHseArSuhaEjekDhdMMRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768248; c=relaxed/simple;
	bh=RCE4KSfoKwNfQQqMo0WObq9YygCPT+zkEvtfzR2db+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOMWbXCHlisV0CfDYOjpS/ioyUCkjGW9mL/0P+1GvfxyFOaWqhY07jB1dVpT0k7EoocYD0ZO1Oycadnk4GyhOcdGrCIB94TgmBMgD/sI2VPzFJtkO2H08AFqCRsymrAF488pUkLdA35KWT3Xm3ZT2lXqWaccoa7gVCgEEXCuzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UTxq8Dpe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UTxq8Dpe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B2D143D;
	Mon,  3 Aug 2026 07:44:02 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1173F632;
	Mon,  3 Aug 2026 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785768246; bh=RCE4KSfoKwNfQQqMo0WObq9YygCPT+zkEvtfzR2db+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UTxq8Dpe1DfvtPj7XOtTSZl555t/REJYvlbcnaRoEEA+Inym4/1TPgK3YJOcDy4G4
	 TBMbPSIuA3tE5PuTMdCX+nOxBBnu5jKn7PCTMue+cxV7WLzAeqY9IwmHdWxzi3tUzg
	 Pa3D6orWcODhMkxuaCNCiqnyZtSlYClz+QLLYOt4=
Message-ID: <c2082cfa-9473-448b-9efc-e70801bb2873@arm.com>
Date: Mon, 3 Aug 2026 15:44:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <cover.1785749175.git.christian.loehle@arm.com>
 <18ee922e97441b99b9ab346fe559d837d05eb5e7.1785749175.git.christian.loehle@arm.com>
 <CAJZ5v0iDuOJ2C_P8G9xD9BV7XEpQroyPecqM30ZxfEL=PzROAg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iDuOJ2C_P8G9xD9BV7XEpQroyPecqM30ZxfEL=PzROAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 15:38, Rafael J. Wysocki (Intel) wrote:
>> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
>> calls cppc_get_desired_perf() because some platforms repurpose Desired
>> Performance to report actual delivered performance.
>>
>> The fallback was added for platforms on which Desired Performance reflects
>> delivered performance. ACPI 6.6 defines the register as write-only, so
>> invoking that workaround on an ACPI 6.6 or later platform would require an
>> invalid register read.
>>
>> Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. When checking
>> the FADT minor revision, mask off its upper errata-generation bits and
>> compare only the specification minor version.
> I'm wondering if the _CPC revision can be used for this instead of the
> spec revision?
> 
> The _CPC revision changed from 3 to 4 between ACPI 6.5 and ACPI 6.6,
> so doing that should be straightforward.

Yup you're correct, much nicer, I'll fix that
