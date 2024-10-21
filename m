Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0B1E1027;
	Mon, 21 Oct 2024 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548124; cv=none; b=MjcZnsxdQcnuR20meOb3yTC9DemdfavcnQnyd0IP0sJfvLhH23OtEmUw8PnhoEii+hAl6Bwl8sarSIFLH9uHfyUokKtCzN2UNwreltUpypxG1Oyt/5Kxfi6bwuOh15TyfRxOv/0iGGd/O4AlrBYMLAS9aVBLPqFfvatcQrkqY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548124; c=relaxed/simple;
	bh=5Ldh+j6A3bs/uPlBTG48zUQtW6HwvgUkxBfMDS2ylXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9ale3mvUaTHY9NH1S6WbN2pWzmEHTNdKcDU8zmp29LakOLTMLFOnzt9HilVRF6QKOcIqm9GWCLULMzcn1itv8FEg6hiBdIQrN+jkNYmV3fVFMhuVo+Z09RHsIb/ix72YAwfE/heQCNh2ZGDo0rA3aFxzMo018Zh55LjixKme+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9753E497;
	Mon, 21 Oct 2024 15:02:31 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5223E3F71E;
	Mon, 21 Oct 2024 15:02:00 -0700 (PDT)
Message-ID: <81c752c1-6f51-4aae-ac25-98214c9b9da0@arm.com>
Date: Mon, 21 Oct 2024 23:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through
 guards
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
 <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 10/21/24 12:08, Rafael J. Wysocki wrote:
> On Fri, Oct 11, 2024 at 8:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Oct 11, 2024 at 12:22 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>
>>> Hi Everyone,
>>>
>>> This is a continuation of
>>>
>>> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
>>>
>>> and (quite obviously) it is based on that series.
>>>
>>> The majority of the patches in it are new iterations of patches included in
>>>
>>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
>>>
>>> and there is one new patch ([02/11]).
>>>
>>> All of these patches are related to locking, but some of them are preparatory.
>>>
>>> The series as a whole introduces guards for thermal zones and cooling devices
>>> and uses them to re-implement locking in the thermal core.  It also uses mutex
>>> guards for thermal_list_lock and thermal_governor_lock locking.
>>>
>>> As usual, the details are described by the individual patch changelogs.
>>
>> This material is now present in the thermal-core-experimental branch
>> in linux-pm.git.
> 
> I gather that it is not controversial as it was covered in the PM+TC
> session at the LPC and it has been around for quite a while, so I've
> just queued it up for 6.13.

If it's not too late, I will do the review tomorrow.

Regards,
Lukasz
