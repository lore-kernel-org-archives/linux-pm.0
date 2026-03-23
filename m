Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB827B327;
	Mon, 23 Mar 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263139; cv=none; b=ehzxAddlHCnT681ZIJwFbK95KXJOzyZDQXAXYvjNuFTbYhJHxA493BOcXSwutGnhXnp/FOVraJVlA9X9jP972EGsqoV9t8BHqjlLxwX5Kme83FahxjveE70Ix92GQ5w/pUFc98w7MXt4aagb2l+8yaXoloWSReL/R0u8Wl2mI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263139; c=relaxed/simple;
	bh=hFFxxC+h9bzxaTJxS++S9FUNaxZ0ky2vjGrxQkjxCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iep1SlJ/joKAZq6FiqGO3nNe1wd0IXorTj8dKazLOQsq/pr20Au5BnB7I42clQ50oBRS8L7NxMLZuoaiz+cGtPynmyKkfJhWYEGBMpNSxrV10Ude82IY2ObIRDP6oqS7OdcwpqLY+rUmwGibGe9ZN7fF2cpEmo6R7CepeVyRjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1268E1516;
	Mon, 23 Mar 2026 03:52:12 -0700 (PDT)
Received: from [10.57.17.171] (unknown [10.57.17.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D49E3F73B;
	Mon, 23 Mar 2026 03:52:15 -0700 (PDT)
Message-ID: <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
Date: Mon, 23 Mar 2026 10:52:32 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com,
 rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
 di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/26 10:41, Viresh Kumar wrote:
> On 23-03-26, 09:20, Lukasz Luba wrote:
>> Thanks for monitoring the development (it's always good
>> to have extra engineer opinion)!
>>
>> I've checked the commit that you referred to and the 'i++' there.
>> It's safe. That commit removed the heavy operation for only
>> tracing purpose, namely:
>> - allocate buffer for N CPUs for 'load_cpu' pointer
>> - populate CPUs' load from the idle fwk
>> - put that info into the trace
>> - free the 'load_cpu' buffer
>>
>> That has been redesigned since it was just for tracing
>> and introducing extra time spent for code run in the
>> throttling phase.
>>
>> The code in get_load() is OK with the commit that you
>> mentioned.
> 
> The code
> 
>          load = get_load(cpufreq_cdev, cpu, i);
> 
> depends on `i` being incremented in the loop to get the correct
> `cpu_idx`. But the said commit removed it and left `i` to be set to 0
> for ever.
> 
> How is that okay ? What am I missing ?
> 

Right, there is a mix of two things.
The 'i' left but should be removed as well, since
this is !SMP code with only 1 cpu and i=0.

The whole split which has been made for getting
the load or utilization from CPU(s) needs to be
cleaned. The compiled code looks different since
it knows there is non-SMP config used.

Do you want to clean that or I should do this?
