Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BD3BF679;
	Mon,  6 Jul 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371545; cv=none; b=rWOt+yv4XQaPMZ7kfsaWwWLzOKbPVuxkYdCTbIEex2DE0iy8B2CHWK/HUAbPXwwyRQCq56lMFEnQGOzb2VAyHI4z2OLQE44/4EO6qy12lzo+iPW7gMQeKY5SHFnTT+4HiF5ZSXgNrygodvteT0dAEIy5zxSBI9794Z9jxDmxtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371545; c=relaxed/simple;
	bh=LRqt5iGrCy3stj6S4jr0OnbAsnN3ciWf48wLl6W30L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeY4iPrLcxH1OB4AR6STaplg7sABm9srMvoBpy8pnWPcLPliWdmVYIr9hcZRhieDvPCf4QQl/Y8qJG4JODFn4fhENv0FJzNtiWFMkfid/xI4x23yY7d+gqn+XiTEs+EPys+zhnC49LqFOKwjKENe4xz1fqVVFH7k2m8r00cXzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVITvsEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVITvsEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8CD1F000E9;
	Mon,  6 Jul 2026 20:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783371543;
	bh=+zc+AqSKZtfFV3G9vnqY3wnMZNqhlnIfdKw/QyGAhEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SVITvsEk4/Snfvnhnsod8k7G1kePLpZbp49QGpjElDWmj72K7CpIjAoZ1rud26zZR
	 nYRbwJPdZlpbfH/m+EToZuvMunOmwVCzg+MJG90vSqEmIcIpKavmuH7h5rt6gU28jC
	 M24VnIsPLvDtAvvDwNT4l6Yl74LsTnQa/HCNGCycB4RFb/xOg/K5jtV57DXiQtxuSC
	 KaeGY8Qa8qR+FrVjID071/DSDymlJX8HJNRPenul6dZzkXt+8A2QRg9y99UqJG0weU
	 36APj9sRkYib4SiPsbFH1blo5a+qtK1KDP89K31ptlQN9YPrlsCYBpzFqCZpOsbeQ7
	 55/kBsG08OOIA==
Message-ID: <9bd738da-bc62-45a5-947f-8971538a522a@kernel.org>
Date: Mon, 6 Jul 2026 15:59:01 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] cpufreq/amd-pstate: Repurpose "amd_dynamic_epp"
 cmdline and corresponding sysfs
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630185904.5602-4-kprateek.nayak@amd.com>
 <8155d7c7-2a10-4fec-bfde-0aeb017724ac@kernel.org>
 <5f271215-6e83-4d75-a562-16d8e70ce672@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5f271215-6e83-4d75-a562-16d8e70ce672@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/26 15:36, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 7/2/2026 3:10 AM, Mario Limonciello wrote:
>> On 6/30/26 13:59, K Prateek Nayak wrote:
>>> Since dynamic_epp has been converted to an
>>> "energy_performance_preference", toggling the feature via the sysfs file
>>> is now redundant.
>>>
>>> Repurpose "amd_dynamic_epp=enable" command line to opt into dynamic EPP
>>> by default when the active driver is loaded, or switched into. The
>>> "disable" counterpart will "dynamic" option out of
>>> "energyy_performance_preference" to ensure dynamic EPP feature can never
>>> be toggled.
>>>
>>> Use a tri-state enum to differentiate if the user has supplied a command
>>> line parameter or not to enable the feature by default vs keeping the
>>> current defaults as is and allowing users to toggle it later via the
>>> "dynamic" option in "energy_performance_preference" selection.
>>>
>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>
>> Honestly - I have to question if we even want to have the kernel command line option anymore.  If userspace can easily opt in and out as in this series, do we still need a kernel command line for default policy?
>>
>> I'm of the opinion rip it out, less to maintain.
> 
> Ack! I'll rip out the cmdline and the "dynamic_epp" sysfs file then in
> the next version?
> 

Yeah; I would say so.
