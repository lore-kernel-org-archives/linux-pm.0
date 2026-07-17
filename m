Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA48233946;
	Fri, 17 Jul 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253513; cv=none; b=R/TGOgGXX7AXWwBI56oz+u1u6XQxY/zqJmlqKSIbjy8WHL56ANuw3TCA6vcBsRg2P0Yy5o5g2PFcu8wZBBJM4SD8fRHXVtaGqhUD+ANbfZxno37p+JLng+jCo9ZZWqonu8N4uvey+kIo4iRLVMAZMkgWeRipfyjJBtLz67K4YmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253513; c=relaxed/simple;
	bh=m/tsragtxK1qGhxNefpGDkSiGsD9zsJ6B8dJXZzTvrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oipD//wqH2Gz9p8lKiygm8W8EmigLbuf2IrQoXE4lR3Hbq0OgKZRa7HO4ptZil11a8tJgQ0XZAkkrCg/xsUb6NN7veGILA67IYyExhBr2rr/XE/2BYkIXUQPKv+ZAs6xvdJTHSN1DsmrkjWvX9Y8cesCzJ7GCJEpwP+2qWFufIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=k0tzZXxk; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="k0tzZXxk"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m/tsragtxK1qGhxNefpGDkSiGsD9zsJ6B8dJXZzTvrM=;
	b=k0tzZXxkJZGWGUUqWvKILPPqQ/nyTvC9TAKMzfyN4tnNtbj4ZL8bBlLEba3CopdMga7wHwAEU
	FXgluZDVgmKUH1deG2Cm7wOs3539NbPp6JSnLRRIvknyJUnFMvBGohHyfjiT8IM6MqDRZqKSI+X
	Z27ICf0WQwQLuSqB52usvj8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h1Xs81TMLzpStj;
	Fri, 17 Jul 2026 09:49:32 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id BBF0140537;
	Fri, 17 Jul 2026 09:58:27 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 09:58:27 +0800
Message-ID: <17affb39-faef-4785-bceb-e675f1f99269@huawei.com>
Date: Fri, 17 Jul 2026 09:58:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/17] ACPI: processor: idle: Add switch for strict
 _LPI processing
To: Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3896986.MHq7AAxBmi@rafael.j.wysocki>
 <20260713-heretic-malamute-of-action-5aee05@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260713-heretic-malamute-of-action-5aee05@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/13/2026 9:33 PM, Sudeep Holla wrote:
> On Thu, Jul 09, 2026 at 02:42:33PM +0200, Rafael J. Wysocki wrote:
>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>
>> Add a "strict" argument to acpi_processor_extract_lpi_info() that, when
>> set, will cause it to ignore _LPI states without minimum residency or
>> wake latency instead of assuming 10 us values for these parameters.
>>
>> No intentional functional impact.
>>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Acked-by: Huisong Li <lihuisong@huawei.com>
