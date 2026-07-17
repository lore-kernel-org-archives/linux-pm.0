Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DF30ACEE;
	Fri, 17 Jul 2026 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252341; cv=none; b=bCO8vB+8ysmZBV96TzKWPgYmLpS8Zh5zWkuGdgNbD2SfKFDmbvr8eWtb4DBNlGg5uo6NFkA/fKHHX0rstX34cbffX0WbKmzEbriTf0bHRIkJMTN1zrST5mOD7EvpSrg+lTqx5rAI/xowLM/TIaULXW55V2glcSi3nKe+R+M1OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252341; c=relaxed/simple;
	bh=qWtWob1lkxZwdmw7Egx4GSn416kVvSw15XwHhTTfDPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gjSsJWOTEBFfQZ0+SzngdrA/ur+qPEFwiOK3K7/UjZs13Hs+zub7ojlbKQpMpQVoqS1EJ+T1+4sxlgnzpKCCmKik6F9duoGadZqaG3F6vkNzdSl0wqwHdXU/kXScw2tOE0CknRECETF3rrZdHNg9ZeMRD5GL/7rscwlH2pviwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=B6EZceLC; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="B6EZceLC"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qWtWob1lkxZwdmw7Egx4GSn416kVvSw15XwHhTTfDPk=;
	b=B6EZceLC4z2dzBL72hYAsIFv1DqBGr8H5RonIH7FFPe4nVvMc4YQpa+CO+mIJTBFRT+arA4iQ
	pFKzTsncPdMmwKEP4LSmiftiLRFHgBK0b9VmxQc3GbDb4ejpElRhSMLNNM7gvf+pwkVFjJeDQ3x
	w1Z3LkdIgMtyUAhcbkI85uI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h1XQ85tCzzcb2y;
	Fri, 17 Jul 2026 09:29:36 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id D2A7740575;
	Fri, 17 Jul 2026 09:38:55 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 09:38:55 +0800
Message-ID: <fa1006f0-40a1-4aa6-ab98-4e1c60c1a988@huawei.com>
Date: Fri, 17 Jul 2026 09:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/17] ACPI: processor: idle: Introduce
 too_many_states() for _LPI
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <1964818.CQOukoFCf9@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <1964818.CQOukoFCf9@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:39 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> To reduce code duplication, introduce a function called too_many_states()
> that will check if the total number of _LPI states for a given CPU is
> too large and print a message in that case.
>
> Use that function in flatten_lpi_states() and acpi_processor_get_lpi_info().
>
> No functional impact beyond reducing dynamic debug flexibility.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
