Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBEF3D5679;
	Thu, 16 Jul 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203601; cv=none; b=n6EW+Z6+3w3mcsaWs7yXeP5dDDmeZxQiKTcQWvGGAGI/MSEYGh495BVJOvA6JZqYctBNIoZEMkiQo441I+Yc1sdwTslPWWQrtZcMYUVcrik9CyGyYBBf9Nt4FC4Ie9xH6/bpqbDb0FuoVYn+fwBrgcfqF4BrIesafEVIu5gRgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203601; c=relaxed/simple;
	bh=Gw6yBQPcUqWoJn/6AxO9+zvuiaQwTsI7oUY1U4vQilQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ex9EuYDLcRdzTLEfd0kAbywppAWhQwdDmDhuRhM2YAOpIr1wGkPFeF8UMq+FvUxvtNqgoq/r2aMTeE1mUuU9mtl+kSmi9F5yJocZyDpASAMo3UKzg4pwuvuv84vplZf00rLGLyQbdhg8chmzFhk5B4Y3b8+AX/f2ZsfB7BmpNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hBpzdXGn; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hBpzdXGn; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hBpzdXGn";
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hBpzdXGn"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NAhHo8nnJnMcWdAbjB+sr6l3n/AZsvsqLWHkpaYUrTM=;
	b=hBpzdXGnpHp+/+9vqOv4yCBq3tkLe/b4D2dMmIYW1PFVxSQw46jWM3U40omR5npqeHsgzSxg6
	K7xWOSd2gk10wAAnU/NU/P5HAd0K74yxM4EnBjAGsM0j/Nz3ivd6qrMalvuSbpzLjCv7Vc2Pl9x
	tSqfNpmV0wHqojwNcNA1ik4=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4h1Bb85722z1BFqp;
	Thu, 16 Jul 2026 20:06:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NAhHo8nnJnMcWdAbjB+sr6l3n/AZsvsqLWHkpaYUrTM=;
	b=hBpzdXGnpHp+/+9vqOv4yCBq3tkLe/b4D2dMmIYW1PFVxSQw46jWM3U40omR5npqeHsgzSxg6
	K7xWOSd2gk10wAAnU/NU/P5HAd0K74yxM4EnBjAGsM0j/Nz3ivd6qrMalvuSbpzLjCv7Vc2Pl9x
	tSqfNpmV0wHqojwNcNA1ik4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h1BP21pBszpSv5;
	Thu, 16 Jul 2026 19:57:26 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id C24124056D;
	Thu, 16 Jul 2026 20:06:20 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 20:06:20 +0800
Message-ID: <7cc71741-8799-4f8b-85a8-b86baac0cf17@huawei.com>
Date: Thu, 16 Jul 2026 20:06:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/17] ACPI: processor: idle: Rearrange
 acpi_processor_get_lpi_info()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <7965163.EvYhyI6sBW@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <7965163.EvYhyI6sBW@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:36 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Reorder the definitions of local variables in
> acpi_processor_get_lpi_info() and drop local variable
> pr_ahandle that is not really necessary from it.
>
> Additionally, move two definitions of local variables to
> the loop in which they are used and rearrange the code
> slightly to prepare it for subsequent changes.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   
Acked-by: Huisong Li <lihuisong@huawei.com>
