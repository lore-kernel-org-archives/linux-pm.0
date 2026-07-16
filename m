Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120E34F49F;
	Thu, 16 Jul 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206075; cv=none; b=K9T8M+l7vBFKuIWWJ53DMpUNSZzbHcDH9agXZWwgatl8/2yvE5HEhFT3DwJyy9hBuwQbWWTQU5NMTAr+/RrR0Cj5sGWbTy+qJsDVBVJCUtFjKNS7ZyeeJ4PAe7k0K8D3krGQvesd1WY0uT8mzdWrL52KZ4Xr7kpxWnYOKPpWutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206075; c=relaxed/simple;
	bh=tyTvkzt+EQi+tEuUR7YANvtjr8ZefCKcbpucZv4kSh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJcjdrZlnjcGDfGzZldN8V/WhcARXY1JkRWMSmkK+id+wmNBVffNkRbAWfkKg5gY+oiUePynA4zFBu3VOgElKsLi0iLlD6Whoup0yxffalJ/G84SB9Q6EEaBOwC6gPwRPfaYQyocTfvMlew2jAucNt5hPyulR2uZgvPXeUg8v3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=lwQLpEJA; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="lwQLpEJA"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tyTvkzt+EQi+tEuUR7YANvtjr8ZefCKcbpucZv4kSh0=;
	b=lwQLpEJA5Wx8noraLDXYUPjsuNV/KFVrxhAB13KDbBsmvSHvBYTglryBByhqNNSTfhXeENPkN
	Qh1/LFTSliE9Rg4gEByyuvaUw25X1qhpZL8mpUTC9dcBN/b5r3G5wXvatm68KaMsL8ptp2t4BiS
	s+59dn1Y7iSiirxFpmri/8w=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h1CJT69ldz1T4MQ;
	Thu, 16 Jul 2026 20:38:33 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EA6B40591;
	Thu, 16 Jul 2026 20:47:46 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 20:47:45 +0800
Message-ID: <ad99f805-3403-48ee-9ec5-23167d87f084@huawei.com>
Date: Thu, 16 Jul 2026 20:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/17] ACPI: processor: idle: Drop redundant _LPI
 presence checks
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3349003.5fSG56mABF@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3349003.5fSG56mABF@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:37 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> The acpi_has_method() checks for _LPI in acpi_processor_get_lpi_info()
> are redundant because acpi_processor_evaluate_lpi() returns an error
> when _LPI is not present, so drop them.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
LGTM,
Acked-by: Huisong Li <lihuisong@huawei.com>
