Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849232FC037;
	Thu, 16 Jul 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206156; cv=none; b=TEIjiai0JanNlI9Ghb4wkIhMbNHSKhi/S99b3j6i5IhSby2T8scEbaJauQt+P4WoaSW4i6uhUgNrPegjekRFJ6+qUC9YThmvudqhde2b5ozd5DJY+8cQWvycVDojiXbHRNTuJOzLp2Wr6A6OVffXcpT1K2vDC4GDFjDKDXjYjbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206156; c=relaxed/simple;
	bh=LQvmHv+Zv4qeDHRKAv+ZamBGVHPFL5cHn9l3hDAMBIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/1/gxGrFZHJKUlVTfYxDzXxq8jEQWSIapxUkl+2E/SU6F9UFyz174vz9UbmnDIsmGcyI6kGm88JFbqMWS9CplJAsT/PtOu0oVyD2eeg6l8KMw7OYgZw4JZVARSC2Pu48bF6WcQ44VW0qb41IIkmHjxEnl0ryDh96xuBTkUx/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=O+nIzfmO; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="O+nIzfmO"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LQvmHv+Zv4qeDHRKAv+ZamBGVHPFL5cHn9l3hDAMBIE=;
	b=O+nIzfmOtLaJ5x+G41EyGS1S2xSZ4MV8OBpL7AEuctkNGiXxdc7U2BeaWACUHnXjV3bM5c/d7
	u3nu70/BXrsAp+udr3p3tmnZ557Hs/fB2a9DCGuURMxHqSzERPBpLZE0kQ1Q2ntHCRjQ7WGS/Fb
	5cgS/8CISNdbGwjIs9AHr6A=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h1CKs5n5wz1K98Z;
	Thu, 16 Jul 2026 20:39:45 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CBD140572;
	Thu, 16 Jul 2026 20:49:03 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 16 Jul
 2026 20:49:03 +0800
Message-ID: <8f3e1a93-89e3-4c49-b109-383e5514ce4f@huawei.com>
Date: Thu, 16 Jul 2026 20:49:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/17] ACPI: processor: idle: Rearrange loop in
 acpi_processor_get_lpi_info()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <1862515.VLH7GnMWUR@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <1862515.VLH7GnMWUR@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:38 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Eliminate local variable status (that is redundant) from
> acpi_processor_get_lpi_info() and make that function call
> acpi_get_parent() in one place.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
LGTM,
Acked-by: Huisong Li <lihuisong@huawei.com>
