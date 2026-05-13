Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCC35AC14;
	Wed, 13 May 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687162; cv=none; b=o7IlEFumIcnL6QnQ8Zt1SGDR55yOZX+7S+m0nOnZY8PmmimVSmN7z4v/UJAAtsbY0tZ1FZI3FXOpyOf/sncho7E97OjvPMrBiS401vsaLq1WzqZi0ll5wJCnUejJeOopEYWLJpGu8axjesSE/fbsX2WZdiUSLVt4kuDagduB9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687162; c=relaxed/simple;
	bh=z47ukJZipd+DSJm1oRrMFydkEDlBLFhXhnTtK8S1JU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o46ffFo81XR1wP6eLdHKvvkp1lUzitGmMOKgmC3KbQGMwKJ/tjladutinoVBW9lgEICG06vmpUaz6Zt/0hXl+fUEvxe3h3gF6dvAf8XaD04b3ewv831Yr64NPUaGTPDdl6JHp7aK1N/u0WJAwBujDotAAAAxuFofWR9D3wq9cWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bUVNNIss; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bUVNNIss"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F8E2008;
	Wed, 13 May 2026 08:45:48 -0700 (PDT)
Received: from [10.57.24.48] (unknown [10.57.24.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8A1E3F836;
	Wed, 13 May 2026 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778687153; bh=z47ukJZipd+DSJm1oRrMFydkEDlBLFhXhnTtK8S1JU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bUVNNIss8O+1OpuedfjWsHcNzZOy58hmVMEJozqcvS60M+5rS2H/nXwnNVuVtOVVX
	 oACtMZmvIiZfnxT5cdAt0PJ5zgPrI0tR0M5TbRYCAllqT/N1UdCWNtYjBLWvPFW/x9
	 LogbFx/DsqqMp/vPgI73BVOgMYkOCkre8bXIB+Do=
Message-ID: <08a0a584-c752-42af-8613-9a790e4becfd@arm.com>
Date: Wed, 13 May 2026 16:45:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com>
 <48c1ae15-3fa7-439a-a492-c82b39fb0a89@oss.qualcomm.com>
 <CAJZ5v0hxWiPX2iGFZjsF8eiNuiXEXm_b0N9RH=Z1M+JsV268jQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hxWiPX2iGFZjsF8eiNuiXEXm_b0N9RH=Z1M+JsV268jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/13/26 16:06, Rafael J. Wysocki wrote:
> On Wed, May 13, 2026 at 4:22 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>>
>> Hi Rafael,
>>
>> On 5/8/26 20:10, Daniel Lezcano wrote:
>>> On 5/8/26 20:05, Daniel Lezcano wrote:
>>>> This series cleans up the lifetime handling of thermal devices.
>>>>
>>>> Currently, the thermal class release callback handles both thermal
>>>> zones and cooling devices by checking the device name prefix. This
>>>> approach is fragile and mixes responsibilities across different object
>>>> types.
>>>>
>>>> The first two patches introduce dedicated struct device release
>>>> callbacks for thermal zones and cooling devices. This removes the need
>>>> to rely on device names and keeps the lifetime management local to
>>>> each object.
>>>>
>>>> The last two patches convert the thermal class to a dynamically
>>>> allocated object and simplify the initialization logic by using the
>>>> class pointer itself as a guard instead of a separate boolean flag.
>>>>
>>>> Overall, this results in a clearer separation of responsibilities and
>>>> more robust lifetime management aligned with the device model.
>>>>
>>>> No functional change intended.
>>> Unless I’m mistaken, the patch sent to split the cooling device
>>> registration is correct with this cleanup.
>>
>> Were you able to apply the patch splitting the cooling device
>> registration on top of this series ?
> 
> I haven't tried that yet, but I'll do it later today.

Just to double check, we are talking about this patch (that we discussed
back then):

https://lore.kernel.org/lkml/20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com/

With the re-work done here, I can put my review tag into
that patch. The error handling paths there should be safe now.
