Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B94DD6DC;
	Mon,  6 Jul 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328582; cv=none; b=rLJh/qZQTL9ymjtsdgVCEvo7UbuB8N4F3RsH8g7vgpxuJgXK9VVDvnl8ta6fk3cOvdkZPuQF1vZTrZmJwTgjKl8K2HLoF794/Pev6f76KZg7sFs7LsvK+oBYWyHKSloydvY4bf2AYsupIiE9RsRKJWycFv4X7IKll3fAvJNElGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328582; c=relaxed/simple;
	bh=yufmUSY40R4RXPo6K7fEa4KIhnrAK13kSTYa5kuGUP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DEZro42zNxj9UqrIY643v6/4W3Ee/uOWE2BTc2uyHnvmfSLwiQ7feUp1u1Q4BrHCZwXVzrR28D9lYtEYJ0HtupFJp82NGIekqCAdtNckcHQRvOJz6o5nE4MbalUIboEeV3ELXP6yaHcsPm/DpV1Htu9hNO7hEcLNlAj/uyMa4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=eqNX7Nqc; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="eqNX7Nqc"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2qCqXzWRyJgWX/jnAd9V4kg/326uEay1uq2VZP4DJJE=;
	b=eqNX7NqcRHulodn1DGKmrAwPngvL/KEnkDj8rjacXwchLellJkmB/BXCciys5pPKEq9G0tk0l
	DyRH5AWM9/lX0/hkoxc5uLE84SI60mkFD9M7Yk9/uBrBtMOxfVLbdv3jmUpEkc6jodJD3UOEFpL
	K3E8ZyyBpWhy4Oyv+nKQCK4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gtynF0fYnz1prqF;
	Mon,  6 Jul 2026 16:53:21 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id CFCF54056E;
	Mon,  6 Jul 2026 17:02:35 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 6 Jul
 2026 17:02:35 +0800
Message-ID: <9e351fa5-e4ad-42a6-b4e8-daf43b8b4251@huawei.com>
Date: Mon, 6 Jul 2026 17:02:34 +0800
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
 <6e5e36e0-c470-469e-bb16-a5faaf055463@huawei.com>
 <20260702-secret-gifted-pheasant-34be3a@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260702-secret-gifted-pheasant-34be3a@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/2/2026 6:21 PM, Sudeep Holla wrote:
> On Wed, Jul 01, 2026 at 03:38:21PM +0800, lihuisong (C) wrote:
>> On 6/30/2026 6:49 PM, Sudeep Holla wrote:
>>> On Tue, Jun 30, 2026 at 05:25:20PM +0800, lihuisong (C) wrote:
>>>> Hi Sudeep,
>>>>
>>>> On 6/28/2026 12:37 AM, Sudeep Holla wrote:
>>>>> ACPI PCC shared memory layouts reserve the first dword for the PCC
>>>>> signature. ACPI specification defines the signature as 0x50434300 ORed
>>>>> with the PCC subspace ID, and ACPI 6.6 clarify that the signature is
>>>>> populated by the platform and verified by OSPM.
>>>>>
>>>>> This series centralizes PCC shared memory signature validation in the PCC
>>>>> mailbox controller and stops PCC users from rewriting the signature before
>>>>> each command. Clients that previously copied complete local PCC headers
>>>>> now update only the mutable command/status/flags/length/payload fields.
>>>> I am concerned that this may affect the functionality of drivers on some
>>>> existed platforms.
>>> One other option I was thinking is to not issue error but just log the error
>>> message and let the client driver add that additional check if required.
>> The patch 1/6 is not good to our platform.
>> Yeah, suggest to use gentle approach to do this if we have to clarify this
>> signature.
> Fair enough, we can just log the warning for now.
Ack.
>
>> After all, all client drivers work well before.
> Sure, but not doing anything will just make the bug carry on for ever in
> the firmware. SO logging warning is minimum we should do IMO.
Agree. We need to clearify this based on spec.
>
>>>> This largely depends on the implementation of the platform firmware.
>>>>
>>> Sure. However I always expected it to be taken care by the platform, v6.6
>>> just adds that clarification explicitly. It was never clear that the sender
>>> or the OSPM needs to write that signature, so I disagree that it is platform
>>> firmware dependent entirely. The clarification wouldn't have got added if
>>> there was any disagreement on that fact.
>> The reasons I say this largely depends on the firmware are as follows:
>> 1> The previous ACPI spec did not clearly require that the platform firmware
>> needs to fill in this signature first.
>>       The client driver working on these platform doesn't work anymore if use
>> the way in patch 1/6.
> Fair enough.
>
>> 2> We are not sure if some firmware verify this signature or clear this
>> signature field in shared memory.
> Anyways, better to check that for current and future platforms if not the
> legacy ones.
>
>>>> I think it's good for the signature to be filled in by the command initiator
>>>> and then verified by the recipient, as this is how this field can serve its
>>>> purpose.
>>>> Otherwise, I really don't see what use it has.
>>> Please get the spec updated accordingly, we can just change in the kernel
>>> based on what we think is the best way to use it. It needs to be clearly
>>> specified, otherwise it may cause issue for non-Linux OSVs.
>> Agree.
>>
>> Yeah, I found spec v6.5 just said how to compute it and didn't specify how
>> to use it for platform and OSPM.
>> I saw the update of v6.6 for the signature field in "Generic Communications
>> Channel Shared Memory Region" and "Extended PCC Subspace Shared Memory
>> Region".
>> like: "The signature is populated by the platform and is verified by OSPM."
>> But please note v6.6 didn't say above words in "Reduced PCC Subspace Shared
>> Memory Region".
>>
> Ah, that's just inconsistency I believe. I will raise a defect.
Nice.
>
>> I don't know why v6.6 specify like that.
>> After all. all PCC application parties (client drivers) in Linux have
>> already filled this field.
>>
> I don't think what Linux drivers should be the reference as there are other
> OSVs.
Agree.
>> According to my understanding of normal signature in communication,
>> it is generally filled by the initiator (sender) and verified by the
>> responder (receiver).
>> In this way, the data is valid, and the signature is meaningful.
>>
>> If it is only initialized by firmware, and OSPM verifies it, its lifecycle
>> ends there.
>> I don't think this signature has much significance.
>>
>> The signature field is just in shared memory and may be cleared due to some
>> other exception.
>> Some similar case also need to be considered.
>> How to make it work better and more resilient may also be something we need
>> to consider.
> Not sure if I follow that. The way I expect is platform won't populate the
> signature if everything is not initialised and running at it's end which
> implies it is not ready to accept the request.
It can also be defined this way.
But platform firmware is generally ready to accept request when OS is 
running.
If platform isn't ready to accept the request from OSPM, the command 
will execute failed.
So it seems that the signature is a bit redundant if it is only used to 
indicate that the platform is ready to receive data.

Anyway, I follow spec, just does not understand the signature usage spec 
6.6 added.
