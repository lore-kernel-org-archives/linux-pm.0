Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B1175A77;
	Fri, 17 Jul 2026 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253391; cv=none; b=HCxCvqKGdQT+yDufDbJr6k3WOI4XvxKFviXiuK08j9oJ61ud/NXk91v9GxMXgs/7OTGK01G2SYfFOidTL6rc8+hIeByG6ktjnmY1lTX4syVcd79Io3ymsMb0Sp55Qa/V5mN1tTbsnSDl31AJYjht4sbpBKpKvk7vxFrIIBwBLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253391; c=relaxed/simple;
	bh=3QwJc0rFK+CLoMn+IOptIySHtt1PnI4XBD9oBnLYWXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fRMQR6Tu2IkFqinmppGn1KyWdo48t+NychoD5acY/n7wl1ISLnrY19i5ighy8ktqjSNBXwXG1PG97c6igV6IRFsGji8u0Saz4I5h447TdnpvfEtiY1/8kxSZsyrNgvE9gRrRrNSPKrgiS++Xle8GJksuXaGjHXHKsgofonlhfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=BLEpzYWN; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="BLEpzYWN"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3QwJc0rFK+CLoMn+IOptIySHtt1PnI4XBD9oBnLYWXI=;
	b=BLEpzYWNqPlhrhSgMRQ0DvvC8e323+EzPblmED9Utg+2G1pwjqvr0/nmcq4koWob2aRiJUDlu
	pYm51O0TgpMvuqP5trDafk/OdWJOvYGJOSWyxStGnvatsagRpjZRTKjEwuORuVI1ORWoNpRFIq1
	NZNA73uTOeSksVq812H+bCA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h1XpL1bwLzmVXM;
	Fri, 17 Jul 2026 09:47:06 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id BF28C40578;
	Fri, 17 Jul 2026 09:56:25 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 09:56:25 +0800
Message-ID: <0edd6c44-7ea4-45aa-a62f-bbda2d555db9@huawei.com>
Date: Fri, 17 Jul 2026 09:56:24 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/17] ACPI: processor: idle: Relocate
 acpi_processor_extract_lpi_info()
To: Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2277662.Mh6RI2rZIc@rafael.j.wysocki>
 <20260713-awesome-excellent-wrasse-eece2f@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260713-awesome-excellent-wrasse-eece2f@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/13/2026 9:30 PM, Sudeep Holla wrote:
> On Thu, Jul 09, 2026 at 02:41:36PM +0200, Rafael J. Wysocki wrote:
>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>
>> In preparation for adding ACPI _LPI support to the intel_idle driver,
>> move acpi_processor_extract_lpi_info() along with some static functions
>> used by it to the acpi_processor.c file containing the non-modular part
>> of the ACPI processor driver, so it can be called by external non-modular
>> code like intel_idle.
>>
>> However, export it to modules in the ACPI_PROCESSOR_IDLE import
>> namespace so that the modular part of the ACPI processor driver
>> can still invoke it.
>>
>> No intentional functional impact.
>>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Acked-by: Huisong Li <lihuisong@huawei.com>
