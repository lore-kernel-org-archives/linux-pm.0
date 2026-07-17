Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7F7081F;
	Fri, 17 Jul 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253894; cv=none; b=JlmRpIpVBJ3oZDv3JE+V8pse4V/HYt5ToW/ra6eEe4MqwCALwrlS6o7+LFPFBW5A1ZnKpTgvMaqf13LaIqDeYKu9LHeqVH1bc1Kw3DEPIsV5TJRqt0cDufbJRYutpwqYELh+DmYOJqmo2VEHDp3zq/K2arfr5AgcRCHcpro4Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253894; c=relaxed/simple;
	bh=TSBtwcUxR+bKlpwbln8NXOaTNGJmEWlESJADpqGcJ48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N++v7hd/5oz+9P6Ax8qE0Smpsg7SNHuX6FYf+QBcmYbJAaskqvqk2fCtuOSoPrMC11Dr9tPWVhZFS0nqgxSOokf5wdWS7mYgJHuankNImps5q+4KigNOTNlqHjwYpM94jmrc6VvBeUc45SI3FQYAOZEJUc34h3aiEoUspujB1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HKkmllWI; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HKkmllWI"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XTv42D/uRFN2lhNjwbKgYonnnqkx2cRIzVBgR8BVFNY=;
	b=HKkmllWI+Zr63W3AnGiK6/dMTbTZiDhYkKbPUdmMxV2k3N7TBO0ZPD/brIo+a/Eirlg/GdJlf
	MDB3Ub0m3oMTX+6Up3Vnxk+PQuGlRE/gx2mQBRR/dTxNyyTzzjt74iAyWeQ3PxABauVceVqXab4
	JzcTlhihNkNLgc16PPqsSfI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h1Xzk2fJLznTy5;
	Fri, 17 Jul 2026 09:55:14 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 98C1640578;
	Fri, 17 Jul 2026 10:04:48 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 10:04:48 +0800
Message-ID: <90b49b35-4770-4509-9585-20ce381acd79@huawei.com>
Date: Fri, 17 Jul 2026 10:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/17] ACPI: processor: idle: Split
 acpi_processor_evaluate_lpi()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <10878273.nUPlyArG6x@rafael.j.wysocki>
 <3e276356-492f-4f2d-aca8-c9eed53d0a61@huawei.com>
 <CAJZ5v0iuq__Bgw0NAnMXH11ngRLiKBtxm50vBqt=ALBP2eZSwA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0iuq__Bgw0NAnMXH11ngRLiKBtxm50vBqt=ALBP2eZSwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/16/2026 8:58 PM, Rafael J. Wysocki (Intel) wrote:
> On Thu, Jul 16, 2026 at 1:55 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> On 7/9/2026 8:34 PM, Rafael J. Wysocki wrote:
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> Move individual _LPI state package processing from
>>> acpi_processor_evaluate_lpi() to a separate new function
>>> called process_lpi_state_package().
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/acpi/processor_idle.c | 167 +++++++++++++++++-----------------
>>>    1 file changed, 86 insertions(+), 81 deletions(-)
>>>
>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>>> index cd506e9e5a84..771a7bd6fb73 100644
>>> --- a/drivers/acpi/processor_idle.c
>>> +++ b/drivers/acpi/processor_idle.c
>>> @@ -869,6 +869,90 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
>>>        return 0;
>>>    }
>>>
>>> +static void process_lpi_state_package(union acpi_object *lpi_pkg,
>>> +                                   struct acpi_lpi_state *lpi_state,
>>> +                                   acpi_handle handle,
>>> +                                   unsigned int state_idx)
>>> +{
>>> +     union acpi_object *lpi_pkg_elem, *obj;
>>> +
>> process_lpi_state_package-->acpi_processor_parse_lpi_state_package?
> I don't think so
>
> The name doesn't need to be so long and it is a static function.
>
>> Others look good to me.
>> Acked-by: Huisong Li <lihuisong@huawei.com>
> Thanks, but is the ACK applicable given the above?
ok
