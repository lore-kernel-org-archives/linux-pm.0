Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B52FFDCB;
	Wed,  6 May 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063200; cv=none; b=U3ra/hp0K2N/XGYHlQ6611arFKIH6iL6wdBKGVLh08QgsKerllKAIngZ5CaeWri/ixsbLSwuYhuwmBFNIral6vl8599AalzSFIYx99W5tmHXJiUQHZU2IOGKnBdNBFRDbmIhiH2H/d+B8H3niBIX3trfQvx7JRc6uOfMRVOX+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063200; c=relaxed/simple;
	bh=qnXPHve10K2UEmeQMM5zVUaJgqpW7fMW37Ix4xSCP4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUWAKWYtDS5HETV97A+9Q6paBmXKPD1sMakLZys8BYZyAev771Z1+Yo1Xe/qshR7Hdh4BWV/Z0Th/jGwTHjGWLolUI1ERIHEFIllEpziNl4OO3cAqDZkd3pTi9S8wxjWpiTzKDotPpX73wZdMS6ORCO1dXDv41BCv+t/5Fqdw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=plxSIP6d; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="plxSIP6d"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749E8331A;
	Wed,  6 May 2026 03:26:32 -0700 (PDT)
Received: from [10.57.21.9] (unknown [10.57.21.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3423F836;
	Wed,  6 May 2026 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778063197; bh=qnXPHve10K2UEmeQMM5zVUaJgqpW7fMW37Ix4xSCP4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=plxSIP6du5Vm5zaw7YJGybbdrPUZlDHmFap5X1Xa8taXqMuWv65j6cJidi7A08wgv
	 kSr+hTdo+tzqRcky+oyQW8XfeNRUp8hBT84vIR4sn8WZh00juxMWFLA68f2kQQZQP1
	 bRoxTKJvDKfWvUkrvXQOl1XFtrWTMnj2qvht1NAQ=
Message-ID: <c45c96a3-535c-4374-b9b2-cf75240a8b05@arm.com>
Date: Wed, 6 May 2026 11:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/thermal/tegra/soctherm: Use
 devm_add_action_or_reset() for clock disable
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, rafael@kernel.org,
 daniel.lezcano@kernel.org
References: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
 <3075fe5c-e8c3-4439-be5c-0f6eb2fb6e48@oss.qualcomm.com>
 <d60b7b44-37e4-47ae-9af4-0c8d24b6c599@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <d60b7b44-37e4-47ae-9af4-0c8d24b6c599@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 5/6/26 10:37, Daniel Lezcano wrote:
> On 5/5/26 14:10, Daniel Lezcano wrote:
>> On 4/24/26 18:00, Daniel Lezcano wrote:
>>> Replace the manual error handling paths disabling the clocks with
>>> devm_add_action_or_reset(). This ensures the clocks are properly
>>> disabled on probe failure and driver removal, while simplifying the
>>> code by removing the explicit error paths.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>> ---
>>
>> If nobody is against these two changes, I'll apply them
>>
>> Thanks
>>
>>    -- Daniel
>>
> 
> Applied, thanks

My apologies for being late. The changes make perfect sense.
Feel free to add to both patches:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
