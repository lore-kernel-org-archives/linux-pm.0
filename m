Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3843F087;
	Thu, 16 Jul 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193396; cv=none; b=IRzbVfXDlaqboJfMGNU6GhCKtNDJ35NP3cK6AWHGmd8D2Ijx1qcJK5kQbF5EI0oCsuhqWdhXR275s1o6JaStsvWk90315G25nZ68TAE8z/TlilZg2OM2/xRephVb6gHwZ+wmlmQJJPX0pKld98Ar0UGKsmXuzovwlweoE9FysVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193396; c=relaxed/simple;
	bh=Bs7nKTwVC8SXd/eNghHLNOZ7HWZinuxDzbxOcJ5HaD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m9SEJwr0aeH3bJBEyuwGLSnmBKEkpb6LpQDCuoklJkzjrY1b3MwCyn+MasRHqG5+2fhbKPg5s8ogbLNMfPQcyRfHqBAWrUDHgQfzBlLIEbDG64Bwqpn1QpDpQMj+Ag6uPQkg+f82K9YLgeetLhfb41yl7+KrFFhJa36E1iGNy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ejCTMgVb; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ejCTMgVb"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Bs7nKTwVC8SXd/eNghHLNOZ7HWZinuxDzbxOcJ5HaD4=;
	b=ejCTMgVbLKdfh2S9XUdiGmn4vvQ0tSUatqfL+lYxk+P460O7MFOH47Eyz3TFx1yIXhMtxlVB3
	s4Jh41BhE+M4cu4nc+H7+J39Be82f4tjlwmT21g4dOj28i006mTlPVA1W9+iv/n00EtDECkjf/5
	VwvlijCZhGedeC3TCFX3SCI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h16cR2VW9zcb0W;
	Thu, 16 Jul 2026 17:07:03 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 262FC4057F;
	Thu, 16 Jul 2026 17:16:21 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 17:16:20 +0800
Message-ID: <33336373-70a4-44de-890c-fd26b8e01377@huawei.com>
Date: Thu, 16 Jul 2026 17:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/17] ACPI: processor: idle: Unify debug in
 acpi_processor_evaluate_lpi()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <3051550.e9J7NaK4W3@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3051550.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:32 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Use acpi_handle_debug() consistently for printing debug messages in
> acpi_processor_evaluate_lpi() because that makes it somewhat easier
> to identify the source of the problem in the ACPI tables.
>
> No intentional functional impact beyond debug output.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
