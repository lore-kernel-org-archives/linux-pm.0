Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006733ADB1;
	Fri,  4 Sep 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508891; cv=none; b=Iy3fm7tnqo9htMSWiY1S9e7ykcEw1fnyLFN4XrORnxVt8pLpzGafquu+i9z+DDIyi7d77/588GZ55y9ef/hbxjQN0SJjnFAWNYNwXv+lHFKoU1lTeEn2KUIENqQqqk/ZKVSSj9t41l0b/K1ugPVOSMqiddRm0MQmayEtvP+qiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508891; c=relaxed/simple;
	bh=b9Mw3aFGpBMrQOIkrZcenLoyU6lVn1++jOl+6R0djPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQPtSU0jgIr4Yr/sScRQWPaxyZRrbYNqDKDeB2vgr0wIClb9EuQ3w8hpOstGldfZVhcOqZD8YFQK0wWzlKnqokUMaA3XZ7K+SdZzeGtawA0bp3cZx1h5TZ1BU2/fV4dSlzjKmWjAwpGoxf/z8yLXe/KoQDtPAETe4DeMHPODd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=t3y5OxEg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="t3y5OxEg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29CA7153B;
	Fri,  4 Sep 2026 01:01:23 -0700 (PDT)
Received: from [10.57.5.232] (unknown [10.57.5.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741953F7D8;
	Fri,  4 Sep 2026 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788508886; bh=b9Mw3aFGpBMrQOIkrZcenLoyU6lVn1++jOl+6R0djPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t3y5OxEgZLeP8TAormzrNnWsmfPr2of6O8saz7pejGRA7VadiAtCJuF+HXM0MKqUm
	 eFhbITrPmNuF2kFYwsiqQMqxHgNo3jXlUp1jS1VQQ/xpTrokSBLgRFf0U36LI3SqcR
	 UG50iQTFOCuaJ+DsYD5P8wwp/56gD6wLlP0TbLis=
Message-ID: <03b270ab-4a39-4a82-b970-c0c10f400549@arm.com>
Date: Fri, 4 Sep 2026 09:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to
 suppress truncation warning
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/17/26 11:33, Andy Shevchenko wrote:
> Switch the sysfs code to use scnprintf() to avoid warnings about potential
> truncation of the names of the sysfs attributes. We can't increase the buffer
> size because the size is the part of an ABI for some reason. Note, with
> the current size of buffer the affected attributes have a room for up to
> 1000 names, which ought to be enough for all cases. There is no functional
> change, as the same limitation was implied before.

Right, it doesn't touch the real truncation check problem only avoids
the complain from the tool. We can think about this later in some
redesign.

> 
> Fixes: c56f5c0342df ("Thermal: Make Thermal trip points writeable")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/thermal/thermal_sysfs.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

