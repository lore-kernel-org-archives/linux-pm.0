Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974662EBBA1;
	Thu, 16 Jul 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192907; cv=none; b=m6TZjQmKYJS9DougJsbwEkr0Q+HSX9CT31FRV6hNoYxwJ9VhqVHyiGdVrELZmMtgoCNyoOXsnYMnGQE+zUnxeAuLK67S5VLZonw/h0VsT5ZcjJnuFnKUluZvcZ2QoL6kZ6khI4ixUfgTdj20jA4kyk/13WkAtRAmfQ/wiy2+zEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192907; c=relaxed/simple;
	bh=iYepiH7lzfZGwLU5Fq/lYVXqTcS3uaZUbgmfvmPTXek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oQrr/PFowhkj6hfxpJvvxIrCFeNeS0ewQbXpI6TtpS+0Xv+NLwCAObQkipjYrFX5cA0nnL4NxEEEU6OtOb2CnxdejxuaEmPeJdB+HzB6d5XkhczhVgUxk5Yto5reWn4TG2omMnDFERFSk7Ab0EAy3YuNIO+6NsNGX4ympaW3ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=B6uUPIe+; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="B6uUPIe+"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iYepiH7lzfZGwLU5Fq/lYVXqTcS3uaZUbgmfvmPTXek=;
	b=B6uUPIe+dMyc4jsBxvJ1Tyi8NE1qx2ONEzUYapqt/ChZHIZ7jkRStgm4bIJUGrZkNQMhpVJyB
	Lh0sX+TeV89U/bPpsfZ980PxlTAqZPoTtOk0wdA331cfkggPFYRcFmX16CV+AMHtRmTElNWQusu
	7mwezw92jCHADG+SlAYE68A=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h16R5338qz1cyQQ;
	Thu, 16 Jul 2026 16:58:57 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id ED36840563;
	Thu, 16 Jul 2026 17:08:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 17:08:14 +0800
Message-ID: <d7520eb0-5f9e-403f-ba2c-06fc0dd93d85@huawei.com>
Date: Thu, 16 Jul 2026 17:08:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/17] ACPI: processor: idle: Ignore _LPI states with
 SYSTEMIO entry method
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2268989.irdbgypaU6@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <2268989.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:31 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> The only entry method for _LPI states supported by acpi_idle_lpi_enter()
> is FFH and it is better to ignore _LPI states with the SYSTEMIO entry
> method upfront than return an error from acpi_idle_lpi_enter() on
> attempts to use them.
>
> Update acpi_processor_evaluate_lpi() accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
