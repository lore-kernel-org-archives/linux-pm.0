Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302219644B;
	Mon, 13 Jul 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932914; cv=none; b=SusFE5OrF3VQNU8O3ew+dKqkI1d1u2F7xEhzKg0wNk6r6u+FEcXG+trnZPZ7dV1tsTioWgpdogfogQ3chHp+qfPRUuCTNld8fGeMWBHaz17CqqgJLVJSvhI3VJvGmPL+64NZ5Lsf4AtuZ4n1GRHFcHHrhA3W+lzGs+f9+ZLkA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932914; c=relaxed/simple;
	bh=VnNQUNNWfqJOOiJYXk+lRd4b5j5mxp8/oV1/E4Au1hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CzQGoiIG+5pAWXScrz2qDlpfD5kG5yTPZdWGSY8GfgCeCyBO1r3SCeqIs04Wd0bbvrxObkFFOQY+FkQ5Vo/PpJKUYiAZ4a6FdrbrdXIuvBFAibyGlfEJmWytHZtCz86lafF3KVCb+IDf/tD27O0G3u9U2F3HImrgy7Qeild3OIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a2c76d27e9811f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b08b7908-6ba1-47a0-bc27-f9f3a9c617b8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:974d90335f713990e03f3fae66e8281f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8a2c76d27e9811f1aa26b74ffac11d73-20260713
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1774913962; Mon, 13 Jul 2026 16:55:04 +0800
Message-ID: <b7803ac7-c9e1-4905-9256-4b67e41ad1ac@kylinos.cn>
Date: Mon, 13 Jul 2026 16:55:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: spacemit: k1: disable hardware on driver remove
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, dlan@kernel.org,
 rafael@kernel.org, shuwei.wu@mailbox.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <1db7d94eeaced9a92e3670d28e0c97c22f15f108.1783931396.git.xiaopei01@kylinos.cn>
 <DJXB4PDMYX0G.1TC9VBR96MHMA@linux.spacemit.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <DJXB4PDMYX0G.1TC9VBR96MHMA@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/7/13 16:40, Troy Mitchell 写道:
> On Mon Jul 13, 2026 at 1:32 AM PDT, Pei Xiao wrote:
>> The driver uses devm_request_threaded_irq() but never disables the
>> hardware interrupt enable, sensor enable, or sensor power bits when
>> the driver is unbound.
>>
>> Add a devm action that clears K1_TSENSOR_INT_EN_REG,
>> K1_TSENSOR_EN_ALL, and K1_TSENSOR_PCTRL_ENABLE on remove, mirroring
>> what k1_tsensor_init() sets up.
>>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/thermal/spacemit/k1_tsensor.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
>> index 79222d233129..cf79dc7d403f 100644
>> --- a/drivers/thermal/spacemit/k1_tsensor.c
>> +++ b/drivers/thermal/spacemit/k1_tsensor.c
>> @@ -199,6 +199,29 @@ static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void k1_tsensor_shutdown(struct k1_tsensor *ts)
>> +{
>> +	u32 val;
>> +
>> +	/* Disable all interrupts */
>> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
>> +
>> +	/* Disable all sensor */
>> +	val = readl(ts->base + K1_TSENSOR_EN_REG);
>> +	val &= ~K1_TSENSOR_EN_ALL;
>> +	writel(val, ts->base + K1_TSENSOR_EN_REG);
>> +
>> +	/* Power down the sensor module */
>> +	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
>> +	val &= ~K1_TSENSOR_PCTRL_ENABLE;
> Why is only the ENABLE bit cleared here?
> At init time the driver also sets:
>     val |= K1_TSENSOR_PCTRL_RAW_SEL |
>     K1_TSENSOR_PCTRL_TEMP_MODE |
>     K1_TSENSOR_PCTRL_HW_AUTO_MODE |
>     K1_TSENSOR_PCTRL_ENABLE;
>
> Should the other bits be cleared in shutdown as well, or is clearing ENABLE
> alone?
Hi Troy,
 Maybe Wu(author) have someting to say about these regs.
 Thanks.

Pei.


>                             - Troy

