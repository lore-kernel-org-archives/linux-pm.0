Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987630E838;
	Fri,  6 Mar 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789244; cv=none; b=RxPmT7bhNaiWiwapsuYaoH6XnvVYOMKQPsRX18/kqQxBpIcOZ+dHZ3vPrlZVUFnUGDwJNdrhGu/CFT1s4J6yfgZdjVRyzl1+Oj7r7yrGourU/l3atyX8YGO9bL32ZD35bfHtpBKXo5gb2v3lFThKZ2v0gm1yNU1nGR5R5wHERyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789244; c=relaxed/simple;
	bh=N8PkD5YdhmsvHajDts89F7EBedN8BvcsAD/2Zip9Q1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7P6ZN6X+MkcpSBBp2AAv7WzGfrlyYeGIyPTVgWnI2kadZRkInRv1Do9BsraaOsqMsYIGxOb+suVa8HLDL1uH1ub7HTbgZa6ogVhMAR30XKCRCZRPQMT8JLzbLKHQ9nCx3U7piy7SiqbK2u2rPUNqXqeT1qD/LnTWHlE9FswAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA0CC497;
	Fri,  6 Mar 2026 01:27:14 -0800 (PST)
Received: from [10.57.11.75] (unknown [10.57.11.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D44E3F836;
	Fri,  6 Mar 2026 01:27:18 -0800 (PST)
Message-ID: <6dbace26-8d7f-4fac-ae33-4dd0bc1d0a6d@arm.com>
Date: Fri, 6 Mar 2026 09:27:29 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
 konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
 amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
 <aaqcE5jk-JCoBVG7@mai.linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <aaqcE5jk-JCoBVG7@mai.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/26 09:19, Daniel Lezcano wrote:
> On Tue, Jan 27, 2026 at 09:27:15PM +0530, Gaurav Kohli wrote:
>> Add a new generic driver for thermal cooling devices that control
>> remote processors (modem, DSP, etc.) through various communication
>> channels.
>>
>> This driver provides an abstraction layer between the thermal
>> subsystem and vendor-specific remote processor communication
>> mechanisms.
>>
>> Advantage of this to avoid duplicating vendor-specific logic
>> in the thermal subsystem and make it easier for different vendors
>> to plug in their own cooling mechanisms via callbacks.
> 
> These changes add a layer on top of another existing without bringing
> a real benefit. At the first glance, it appears to be an ops calling
> an ops with an extra unneeded lock.
> 
> IMO, a remote proc cooling device should at least group all common
> rproc calls found in the different SoC doing the same thing. Otherwise
> it is not worth to add it.
> 

I agree with Daniel here. I thought we would have many such SoCs and
a common problem to solve in the fwk layer. When we discussed at LPC25
this needed feature I got an impression this is the case.

Do we have other SoCs which would benefit from this design approach?

If not, then it would be better to put this code next to the SoC's
driver code and not expose it.

Regards,
Lukasz
