Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A12931DA;
	Thu, 16 Jul 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192735; cv=none; b=VYJBJC965vNqQXmzJj24QtEOJgxOieNDhnYZfygw3QbAtM72F5tfDqFiiEvFy1z1aMzmgwWCjql0S0337HRez1P1pBFAW8j+sGaBx6pR/gvkrEkjaATdGWI9eOBzO6P8k5yeKRwIMHGq9pHtY9Mqgk3Uabphg6Uw92mtwNhzp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192735; c=relaxed/simple;
	bh=BIdnaqFxJgB4gOdwapGQqFcEwqudv1c0YFpxoJQ1NWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i5NaTwWtPhnmrNsaKleRzmex1C7qWN0BZ8BRkaBvcVZzEm4dP+vXLcippRYHXHI0ndvWYkTumt5yE63EQ8sNoBRHLFaL3PZ3JtpQEIjfccMBvgnta3bVVKjpjHuafxTT2Hqvr0to8X5uAtOnojG+KuOhZppbD8gPWUaHKp7t+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=OW67Y7Td; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="OW67Y7Td"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BIdnaqFxJgB4gOdwapGQqFcEwqudv1c0YFpxoJQ1NWo=;
	b=OW67Y7TdMzojKnga1CnCdlx686XEmdTotOCGExGG6ZopSRpkcS/ZJJ/JdR+IDK0fLSgundSXj
	1dBp0VXRNi8VhtX4ny8o/bkoMdRQ7wIgwZoP7sJpxEJnnCGbQXMLMgykRarBLZtt/k1tnACl0O4
	bCWjEkJNTOoJgM025ezVLyI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h16Mz33s6z1T4HL;
	Thu, 16 Jul 2026 16:56:15 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F144058C;
	Thu, 16 Jul 2026 17:05:27 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 17:05:26 +0800
Message-ID: <6d9f474d-1e7e-4aca-8a20-c9343010563b@huawei.com>
Date: Thu, 16 Jul 2026 17:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/17] ACPI: processor: idle: Expand _LPI package
 sanity checks
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <5084143.GXAFRqVoOG@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <5084143.GXAFRqVoOG@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:30 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> The _LPI package sanity checks in acpi_processor_evaluate_lpi() miss
> a couple of things, so expand them by adding a buffer size check
> before retrieving a struct acpi_power_register from it (and skip the
> given state if the buffer is not large enough to hold a register
> structure) and making the function avoid copying the state description
> from the ACPI table if there are too few elements in the package
> supposed to hold it.
>
> While at it, relocate and rephrase a comment about skipping _LPI state
> package elements [7-8].
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Idle(LPI) states")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
