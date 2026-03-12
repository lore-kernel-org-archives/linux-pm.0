Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1660823DD;
	Thu, 12 Mar 2026 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315318; cv=none; b=VVZXhNjLpsyNdYxBlmq1yR7SMGf73p2IoK7NG+k4Q77PZTAe4LzxQtS5TuqDEbmkYlYthsQyHq5qNZYiNvETO0YxuJ+BX+xiejOpkdDtvydx7Ibmvm+v5WWW56zdGTUL1vnv7uJjU65ODKBq+ABN6WQbFnSbznBWZUUm25XX9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315318; c=relaxed/simple;
	bh=GtBat+R/pyhZkB8Po8nPF44x4eXM9WeY9qeDYZdcdSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5ilKgyFyiVcjg0K6DlvFcw/gd2bS+o+ab9ZsjaaLNf//2mgzxX5dpPMJbb048zcsEOq0mgILlnXRh/EhqqKgFaousJe31rV6JUC0m8q+evcvWuw4pNhvMf4zsj2EJlT4orPGQW5xJsmB8dwEPlMYmH2S64M747Z+CKxz25eJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dJhsYg1t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dJhsYg1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773315314;
	bh=GtBat+R/pyhZkB8Po8nPF44x4eXM9WeY9qeDYZdcdSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJhsYg1tIAkUYcwaeb/qjN8zKwot2XEMsB6U8kv+lrb/G2Ua1uKgfe/OREl99U0/t
	 3VP0bPIN/ZQXUiUIRi97pAKmcNei2hs9cWo059Djv1e7YeW99ciUSuk81nb8cFsWNI
	 T4WcTFHxYAENyw97wfhC95/YrUt86XtuWD58yFIAbwcpE28BHBVTh3ROcPrRpkZXNs
	 AgO255jH064DA0WKbz3ub22/7Lom6+Lm1Kii4mlSMdeBqZHBVfs1WH+C+cNTQw4DCo
	 0obbQmxEBm35CPOvTjz8jMFRpCLOyF7lSlutRJpQtcOe/1UeHhdIlJqV8eTNJUaJw1
	 d2DPAov26RjqQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4ed7:ba53:777c:9c6a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FF9C17E05B5;
	Thu, 12 Mar 2026 12:35:14 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: linux@fw-web.de
Cc: angelogioacchino.delregno@collabora.com,
	daniel.lezcano@linaro.org,
	daniel@makrotopia.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	rafael@kernel.org,
	rui.zhang@intel.com
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: fix mt7987 thermal crash
Date: Thu, 12 Mar 2026 12:34:57 +0100
Message-Id: <20260312113457.532062-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <8B371D2A-3C7E-4514-B495-9ED58FB60A80@fw-web.de>
References: <8B371D2A-3C7E-4514-B495-9ED58FB60A80@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/12/26 08:39, Frank Wunderlich wrote:
> Am 11. März 2026 10:35:19 MEZ schrieb Laura Nao <laura.nao@collabora.com>:
>> Hi!
>>
>> On 3/9/26 07:44, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> On mt7987 we see a crash due to missing ops entry.
>>>
>>> [    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
>>> ...
>>> [    1.564481] pc : lvts_get_temp+0x84/0xc4
>>> [    1.564492] lr : lvts_get_temp+0x60/0xc4
>>> ...
>>> [    1.620900] Call trace:
>>> [    1.631753]  lvts_get_temp+0x84/0xc4 (P)
>>> [    1.645471]  __thermal_zone_get_temp+0x24/0x11c
>>> [    1.656502]  __thermal_zone_device_update+0x9c/0x52c
>>>
>>> Add the new ops member added in 7.0-rc1 for mt7987 too.
>>>
>>> Fixes: a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic")
>>
>> I think the Fixes tag should reference 
>> "thermal/drivers/mediatek/lvts_thermal: Add mt7987 support", as the 
>> commit introducing the ops also updated all existing data structs (seems 
>> like mt7987 support landed right after).
>
> Ok, i will change this. Have not looked on order how commits
> are applied. Both commits were new in 7.0.
>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>  drivers/thermal/mediatek/lvts_thermal.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>>> index a9617d5e0077..5671531d4c23 100644
>>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>>> @@ -2026,6 +2026,7 @@ static const struct lvts_data mt7987_lvts_ap_data = {
>>>  	.temp_offset	= LVTS_COEFF_B_MT7987,
>>>  	.gt_calib_bit_offset = 32,
>>>  	.def_calibration = 19380,
>>
>> You'll probably need to define num_cal_offsets too, since the number of 
>> calibration bytes was also made configurable (not sure if this is 
>> already addressed by a separate patch).
>
> Thanks for pointing to this.
> Should i change in same patch or in separate one?
>

I would suggest including this in the v2 of this patch, updating the
commit title and message to mention that both the ops and num_cal_offsets
were added.

Best,

Laura

