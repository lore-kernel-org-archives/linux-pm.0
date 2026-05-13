Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473DF48BD33;
	Wed, 13 May 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687564; cv=none; b=pqamTHdoWq1IAD31E0efDsb67pYS+k1aRe5S2k/6DkU7BbZXLW3MJ1/H3ooJUpsOwo25fS3qh13sCVwJymOzLxen6jNHazEPqlAjs6EzmsR2Ww8GIy74uhft5b/Tm3+6fPiaQgYyiUXOpA6I25NtczdSwGH6AVdaiRdOr2OWGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687564; c=relaxed/simple;
	bh=R4D5vQqoT46++lxcZ3ltfMtpsjajO0B7idUBRGH89Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkHC7uAzWCvG7GQ+kXkN9L/IMBCJ5X9YpW/14hSfKYKkDDSgnRWIO+qx4WKj5JjjhTK+04cfxJYsynj7hH4QJMcSAlj+VgkWhXhB+/j74u2zQgRVKqmWnMt1PPLpIfXZbjLrsn+Hz3aoJIni8QMg+/7sMDexslYstu1ESljJJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UqBPnkMt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UqBPnkMt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7285D1D34;
	Wed, 13 May 2026 08:52:37 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C75DE3F836;
	Wed, 13 May 2026 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778687562; bh=R4D5vQqoT46++lxcZ3ltfMtpsjajO0B7idUBRGH89Vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UqBPnkMttrYWU3FrAo87v7Z4RqgjbBAo8zIP4VcT5bjPTAFaG9zQLaf11R/uoFISr
	 cYSZxPHxrwBydMlOBGh+kzR1gfimYEogi7Nc0y9aUiZgmvlHFdqUf4NotTRSRDzijr
	 OytUYbXlBrr2xa3Pp/B0Goh9p+8nemNNGeFS9EPA=
Message-ID: <f8755208-f6b6-4e07-a229-b07d045b4c85@arm.com>
Date: Wed, 13 May 2026 16:52:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
 <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
 <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com>
 <b120e546-2a41-4efd-b0c6-8a63eb5bbd93@oss.qualcomm.com>
 <CAJZ5v0je8SEjpWALrMcF8pFSZtb8uu9x9VMqvqwys0_Cv01Kaw@mail.gmail.com>
 <ea510603-bca1-4f7d-81b2-7dd118a47a8c@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ea510603-bca1-4f7d-81b2-7dd118a47a8c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/26 13:40, Daniel Lezcano wrote:
> On 5/8/26 14:08, Rafael J. Wysocki wrote:
>> On Fri, May 8, 2026 at 1:25 PM Daniel Lezcano
>> <daniel.lezcano@oss.qualcomm.com> wrote:
> 
> [ ... ]
> 
>>> In thermal_zone_device_register_with_trips()
>>> {
>>>          ...
>>>          tz->device.release = tz_dev_release
>>>          ...
>>> }
>>
>> Right, so why don't we clean that up to start with?
> 
> On the way ... :)

With the re-work done in [1], this patch looks good now

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


[1] 
https://lore.kernel.org/lkml/20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com/
