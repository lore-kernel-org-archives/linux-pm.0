Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEF2749ED;
	Thu, 16 Jul 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202941; cv=none; b=UvvRtnM6AbVmY+L6CYgdei/l1Vh4M3OfhqLPleIYNEGKFV5+mbs1HS+qrkkAZmI7JcM+meJa+knMUMJ59Qzov5zsUBPgY2H2uDOXBeFh3kGu+A40aUf0U/yHzlDMdDT5BcfQPu7MuxsbVy8Y9xHdzLgroEFhYGseCpK6O2ZysGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202941; c=relaxed/simple;
	bh=EZxVC/D54wVgxl0zWDMOVIocF1vs6Rm5e5A+kMlb/DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=terRxHC7U9p/nvz4G28+gBrDkH4QebxEQczgefN7uWNsKl6ZVlfhGP3R4W1e4EFgIGQqCrP8cGZpJGHws9kEsBT8t1bB9qACfy/bCV9ESo5bM/72zMYsxIoe2zJP55Okvt4KTE93ZAmgzkgkTWQxt7PW98GuM+CcuSIrj/9kNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=EhXQVD1F; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="EhXQVD1F"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xMxVnYj6QT+IYqifD9iI2OTvIDfK5m4/LMjHCbIzqMs=;
	b=EhXQVD1FPyr7FWpQ8yGJpaZ0gxVCyu7Ea2xlQRYmbfG7eP3rap4KNTRnhzRRGI04JeXvJTLdB
	bCWKneENc2ey8Mbl70o6ct6DZ5HYfcnKk8v8JTHjTe1pJ1doaTXDmS5aLH3OV6v5L8Oe/rdg1As
	TPcLJoe2TXMFAo+zlzJmbzo=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h1B8745d5z1prKd;
	Thu, 16 Jul 2026 19:46:15 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 9700D40575;
	Thu, 16 Jul 2026 19:55:36 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 19:55:36 +0800
Message-ID: <3e276356-492f-4f2d-aca8-c9eed53d0a61@huawei.com>
Date: Thu, 16 Jul 2026 19:55:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/17] ACPI: processor: idle: Split
 acpi_processor_evaluate_lpi()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <10878273.nUPlyArG6x@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <10878273.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:34 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Move individual _LPI state package processing from
> acpi_processor_evaluate_lpi() to a separate new function
> called process_lpi_state_package().
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_idle.c | 167 +++++++++++++++++-----------------
>   1 file changed, 86 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index cd506e9e5a84..771a7bd6fb73 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -869,6 +869,90 @@ static int obj_get_integer(union acpi_object *obj, u32 *value)
>   	return 0;
>   }
>   
> +static void process_lpi_state_package(union acpi_object *lpi_pkg,
> +				      struct acpi_lpi_state *lpi_state,
> +				      acpi_handle handle,
> +				      unsigned int state_idx)
> +{
> +	union acpi_object *lpi_pkg_elem, *obj;
> +
process_lpi_state_package-->acpi_processor_parse_lpi_state_package?

Others look good to me.
Acked-by: Huisong Li <lihuisong@huawei.com>

