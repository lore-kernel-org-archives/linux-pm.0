Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F811C5F39;
	Fri, 17 Jul 2026 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252798; cv=none; b=hX058PJ2xt3/WM6oTFjLHjome5NX4vGlfYem9xriYiRk3mz9+lH2Th+70grdFfmiom/JqoBbKFXoRmcTKXO+rI+cm3SpLmVVhQ0ZK8XjpwhL9TFq0NwyQNXouob5h7lstHM6UWPzKPEQt/feTVIkkSXKuDSL/5i9VD+A0ruiAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252798; c=relaxed/simple;
	bh=u06C8DpZt+744QBqsHD/QZXTiJwGf4ieDQ599Go2hA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AS+RMw5BXMcKFxxkcIFWoNUfjFMKA2E6HsrhQh4WJ4egWobwW/oYKzqXwd0XgcsgqqVEiHh3hBssWO2TiZUMaxQKhGBswXJi+XA2azgr/cvfQDaWCGKNXp3oL5LN8gqVsyDiM10LnjM5p2PGM1S3qDTsCS/IpWien0Giar7yFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=YwSMgcz+; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="YwSMgcz+"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=u06C8DpZt+744QBqsHD/QZXTiJwGf4ieDQ599Go2hA0=;
	b=YwSMgcz+j/kPYwECYaJ3OTuqqiA9+44h7oRiz5UFcqF7ZHzc+vJ9YAEqGHhuu8TExtpJugidj
	SkziRpouxPACtt7FNavsSSMFz00gb/aHs87sBkxHaixcVN26e1T3ddjisw74OZAv1YVCMHaZMgA
	fPaGOVL4tLlvU5rc8o7DQxY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h1XbP0d3qzpStj;
	Fri, 17 Jul 2026 09:37:37 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C41E2012A;
	Fri, 17 Jul 2026 09:46:32 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 09:46:32 +0800
Message-ID: <f0606b25-5be5-4224-ba6b-9783aa73711d@huawei.com>
Date: Fri, 17 Jul 2026 09:46:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/17] ACPI: processor: idle: Introduce
 acpi_processor_extract_lpi_info()
To: Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2709187.Lt9SDvczpP@rafael.j.wysocki>
 <20260713-mottled-finch-of-refinement-5ac3a3@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260713-mottled-finch-of-refinement-5ac3a3@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/13/2026 9:32 PM, Sudeep Holla wrote:
> On Thu, Jul 09, 2026 at 02:40:35PM +0200, Rafael J. Wysocki wrote:
>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>
>> In preparation for adding ACPI _LPI support to the intel_idle driver,
>> move the majority of the acpi_processor_get_lpi_info() function body
>> to a new function called acpi_processor_extract_lpi_info() that will
>> be exported to external code subsequently.
>>
>> No intentional functional impact.
>>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Acked-by: Huisong Li <lihuisong@huawei.com>
