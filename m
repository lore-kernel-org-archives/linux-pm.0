Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467C3B19B5;
	Wed,  1 Jul 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891514; cv=none; b=mngYa8mT+NF1GZd5xJGV7Quk+9a9CUI9hjVrfk/IUrjzH6TLTk9EmyM1737u1dYhk9xz+6nOsOYeX8pxnmMsQ9CqEMruF2GAQ8ioaE/B4pA1kLiw7RSxggCXzBdqOjsruOKR7MskoXgkxATd2UgPfJHwTTlbMSzTNyIHPgVXiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891514; c=relaxed/simple;
	bh=vpCwxCc/jh1ELbp5VpXjSmjU7t0A+pMZjyEMapeeu4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q8T2fj64VFZ3rRGLS7sFkI2nvPRoy7s1NZVcCR3PUc/OsOAa3HPbH7S3id4vD3BG0wwUbUa51NViRoonu7afEELqth3on7UXQL7w45z+MqVtHKYSECF9vpbJH0zeabRnePGwXxdb3PtFTobQBCC7JizRJ/2jUEbHiwH88zX6X3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=WdN8FARP; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="WdN8FARP"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vRTdiQsC6/7X1boag6afRTp9D+BMwbbk1RY2lrBsgQQ=;
	b=WdN8FARPus7NegMBnOH/ZOlWmjRtqVfhC8xGKq2zklobjzBIk0PlqDjy9lvytSvOX3LGTm2mT
	YRLTR74NbHEqokLRlYZ6hbGH5tIA/6qFKiqgRcfJtCvmX0qWGVuXzeOYYGo4XFt7/eCsVYmx74Q
	ig6E+ypsg5/m0BrCyXvCC/Q=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gqs8q6yqlz1T4gr;
	Wed,  1 Jul 2026 15:29:31 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C49340561;
	Wed,  1 Jul 2026 15:38:22 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 15:38:21 +0800
Message-ID: <6e5e36e0-c470-469e-bb16-a5faaf055463@huawei.com>
Date: Wed, 1 Jul 2026 15:38:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ACPI/PCC: Preserve platform-populated PCC signatures
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Guenter
 Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>, Andi Shyti
	<andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>,
	<lihuisong@huawei.com>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <10fb88e6-02f8-46b8-9665-db94a4035c5d@huawei.com>
 <20260630-loyal-gray-polecat-a68c0d@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260630-loyal-gray-polecat-a68c0d@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/30/2026 6:49 PM, Sudeep Holla wrote:
> On Tue, Jun 30, 2026 at 05:25:20PM +0800, lihuisong (C) wrote:
>> Hi Sudeep,
>>
>> On 6/28/2026 12:37 AM, Sudeep Holla wrote:
>>> ACPI PCC shared memory layouts reserve the first dword for the PCC
>>> signature. ACPI specification defines the signature as 0x50434300 ORed
>>> with the PCC subspace ID, and ACPI 6.6 clarify that the signature is
>>> populated by the platform and verified by OSPM.
>>>
>>> This series centralizes PCC shared memory signature validation in the PCC
>>> mailbox controller and stops PCC users from rewriting the signature before
>>> each command. Clients that previously copied complete local PCC headers
>>> now update only the mutable command/status/flags/length/payload fields.
>> I am concerned that this may affect the functionality of drivers on some
>> existed platforms.
> One other option I was thinking is to not issue error but just log the error
> message and let the client driver add that additional check if required.
The patch 1/6 is not good to our platform.
Yeah, suggest to use gentle approach to do this if we have to clarify 
this signature.
After all, all client drivers work well before.
>> This largely depends on the implementation of the platform firmware.
>>
> Sure. However I always expected it to be taken care by the platform, v6.6
> just adds that clarification explicitly. It was never clear that the sender
> or the OSPM needs to write that signature, so I disagree that it is platform
> firmware dependent entirely. The clarification wouldn't have got added if
> there was any disagreement on that fact.
The reasons I say this largely depends on the firmware are as follows:
1> The previous ACPI spec did not clearly require that the platform 
firmware needs to fill in this signature first.
      The client driver working on these platform doesn't work anymore 
if use the way in patch 1/6.
2> We are not sure if some firmware verify this signature or clear this 
signature field in shared memory.
>
>> I think it's good for the signature to be filled in by the command initiator
>> and then verified by the recipient, as this is how this field can serve its
>> purpose.
>> Otherwise, I really don't see what use it has.
> Please get the spec updated accordingly, we can just change in the kernel
> based on what we think is the best way to use it. It needs to be clearly
> specified, otherwise it may cause issue for non-Linux OSVs.
Agree.

Yeah, I found spec v6.5 just said how to compute it and didn't specify 
how to use it for platform and OSPM.
I saw the update of v6.6 for the signature field in "Generic 
Communications Channel Shared Memory Region" and "Extended PCC Subspace 
Shared Memory Region".
like: "The signature is populated by the platform and is verified by OSPM."
But please note v6.6 didn't say above words in "Reduced PCC Subspace 
Shared Memory Region".

I don't know why v6.6 specify like that.
After all. all PCC application parties (client drivers) in Linux have 
already filled this field.

According to my understanding of normal signature in communication,
it is generally filled by the initiator (sender) and verified by the 
responder (receiver).
In this way, the data is valid, and the signature is meaningful.

If it is only initialized by firmware, and OSPM verifies it, its 
lifecycle ends there.
I don't think this signature has much significance.

The signature field is just in shared memory and may be cleared due to 
some other exception.
Some similar case also need to be considered.
How to make it work better and more resilient may also be something we 
need to consider.
>
