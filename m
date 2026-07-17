Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427E175A77;
	Fri, 17 Jul 2026 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252196; cv=none; b=IMjB3ecE1j89nizyp8Vsjc/5DGToBABOp7Xk+J9wu89Cur9ChrNVvXuj4F2DrbSG6vQ0H/TDPH2o+Pa86pZ0+YtG5ArkjUZV7mXAUzByiUkobPB6kiO0u6ZLBc57NQCqqf8tiGx8quw/Yf1oEzWzLEd01TIXNH6zejuNV+HHkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252196; c=relaxed/simple;
	bh=f8ZEQqRkKbm3zUd5m1bO/EPaMTR6iLAfeaMRxw+h+oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ewNbCextrOwpkaxf2/+Cvl5CMyv7KZC38ZVBDYlLpgJIKyfU8IwHfCgMIz2ZSMaBQEiJjk236fRVJPHazxWy1Q5R7jdjFjvQoe3rrfqNkPaOOK3/fOGIKvm5FTHvLKbGwWKlIEiyWsB6Ydp+p7EdGpe38DuaKPQDaacbRkxIxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HtLMLu+W; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HtLMLu+W"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lBdQlx8yL1iWGrx37Y9CQRjJtJvMp7aJ6tFmDW3iD8U=;
	b=HtLMLu+Wa2K4jl2vFJj5NsPsNXEfhk6VJONHxO6UqA2KsRDO3XLf2E+nezWJiWGRmUa59gHqi
	t3NGTlUSl5OFrQEvsngwTQffrtJE7TALy3Lx8WmWZAjB4/mFvbgOOzWyVgxazkSXMiS54I2PJg/
	3aTPQnTlIzcsJr/7sjj11DI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h1XMK0gB3z1prpK;
	Fri, 17 Jul 2026 09:27:09 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CCE040537;
	Fri, 17 Jul 2026 09:36:30 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 09:36:29 +0800
Message-ID: <fad2a12f-79b7-4f4b-a438-6e2a10943911@huawei.com>
Date: Fri, 17 Jul 2026 09:36:29 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/17] ACPI: processor: idle: Rework
 flatten_lpi_states()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla
	<Sudeep.Holla@arm.com>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
 <2064627.usQuhbGJ8B@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <2064627.usQuhbGJ8B@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:39 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Rewrite flatten_lpi_states() to make it easier to follow:
>
>   * Rename its flat_state_cnt, curr_level and prev_level parameters to
>     state_count, curr, and prev, respectively, so their names match the
>     names of analogous variables in acpi_processor_get_lpi_info().
>
>   * Eliminate a redundant local variable state_count.
>
>   * Move definitions of local variables to the code blocks in which
>     they are used.
>
>   * Reduce the indentation level in the inner loop.
>
>   * Use more meaningful names for local variables.
>
>   * Move two statements that belong in acpi_processor_get_lpi_info()
>     from flatten_lpi_states() to that function.
>
>   * Use acpi_handle_info() for printing a message when the count of
>     flattened states gets too large and drop the message requesting
>     ACPI_PROCESSOR_MAX_POWER to be adjusted which is pointless.
>
>   * Add a comment explaining what happens in that function.
>
> No intentional functional impact beyond the message printed when
> the count of flattened states is too large.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
