Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296123A7597;
	Mon, 21 Sep 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020043; cv=none; b=IaYK6rxvfmRkJB6huPXBjnXSI+Cf+6TRL3Js7PMktpaogHBNZqCu8jXlxvqKksjnbIIz6o5jDwNi0cs5iZughiI4ieC+eoW/6bLb80ilcASBJZfHAE1u/1Cn3qyRm1S7qrZc7xwP/78vhz65C/hwxXLBBOltLc3Xk3rBpPFO7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020043; c=relaxed/simple;
	bh=BcnEdl8QDnPqGivNaUv7+XCrZTH93GaYtfPRvDAlIUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnZ0+yxBMp1AF0cc6kA0mSy2rSG2YN1CrJGjhH4AvKsPV/xKnTGHKMy8cOFKzpMAeNw1o9/uVjGSQpCjZ1iM6k0VG1DO8DqgyctdlN8Wsc3THS4nncJyVoJZIRTK4/2DiOogeom7rMHFT8BC8H/P8dKXyF8C4xIVUlVO5RorceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nz8FspN0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nz8FspN0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E3D19F6;
	Mon, 21 Sep 2026 12:47:16 -0700 (PDT)
Received: from [10.57.75.12] (unknown [10.57.75.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7769F3F86C;
	Mon, 21 Sep 2026 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790020040; bh=BcnEdl8QDnPqGivNaUv7+XCrZTH93GaYtfPRvDAlIUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nz8FspN0pLBCdbpMaLV6xXFKibR6EyNm0OYxDS1JWJv0pGrc01MsCyANO9tYHfF20
	 SYOxqilDpslCPZDQoPtPIyY2/Q1GMDfkPcGbuGznjqfgonX1i4i5ivEEUvNz3t2KhA
	 7sSj9y8X06NV8QYcNCILO3VHs8gbhL0+iezIPg0U=
Message-ID: <651d6392-984e-4363-8ef6-94a23be615d7@arm.com>
Date: Mon, 21 Sep 2026 20:47:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] cpufreq: cppc: Handle Highest Performance changes
 at runtime
To: Jie Zhan <zhanjie9@hisilicon.com>, Xueqin Luo <luoxueqin@kylinos.cn>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, Ionela Voinescu <Ionela.Voinescu@arm.com>
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
 <d02f335a-c97d-49ad-85c0-2eacd744eb0c@hisilicon.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <d02f335a-c97d-49ad-85c0-2eacd744eb0c@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/26 09:49, Jie Zhan wrote:
> 
> 
> On 8/7/2026 2:08 PM, Xueqin Luo wrote:
>> Hi Rafael, Pierre,
>>
>> This series adds support for handling ACPI CPPC Highest Performance
>> register changes at runtime, triggered by Notify(0x85) on a processor
>> device.
>>
>> When the platform changes the Highest Performance value (e.g. due to
>> thermal or power budget adjustments), the OSPM must re-evaluate the
>> cached capability and propagate the change to the cpufreq policy,
>> the scheduler's CPU capacity model, and the frequency invariance
>> engine.
> Any real use case of this on platforms that run cppc_cpufreq drivers?
> Some addtional motivation may help.
> 
> For example, a processor can age over time and its core frequency degrades.
> It's good if platforms can make OSPM and userspace aware of this.

+1
If this is still current then I'd love to see a resend with a fix to affect
the entire policy at once, not just policy->cpu and I'd propose for now
also limiting highest_perf at first probe and ignoring any
highest_perf_new > highest_perf, until we have a compelling case / platform
that uses it, because IMO it does make everything more complicated.
(+CC Ionela)

> [snip]
