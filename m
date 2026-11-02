Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602326;
	b=Y19YYGsOAfwRc1rQJ35Ry9b/sgP5xQysbeZri6dswkMdmKWPvD+PXpKos/WsWb8aCwuL
	 moNiwWKJz6A6nwULOyROn3F3sOkQY8pcisIrtMeMDGCb2Rs9MYVH0Nhc/XsXK7winceeS
	 YLz95AOJrRMtLJdukQdIbF1zDuET1IbTAkE8GJQwTnl+O7z5Ny7vo/dBx9Aqkio0fhkjJ
	 XlGnl5uhsOlxiZR2o6FD9u3QmHdzeUaUXeb9K3vjwaszZw0TyH8zUwhsZwA9gTOUALOXR
	 I3jTBWz/3mod7AOOZZpcII2xpcToEoDj4to/t2UsDs1Wh5ruI07b8jcbRJJ88gnnFNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602326;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=PTkCharFQmf18BmR+HlsgqRfDjWer5Tuunqxyv1lgvw=;
	b=P78y9WhmnPVOhlybvfZHFeWp+w+1Qpe5PX8Hp2r4VTsPDccmelcxdKeDUWCm/4mZy0C5
	 if5w3iTfiPpiwvI2KPikxVdzMU+oRK1n6kAbGDaULXPaTiyGdSC0Pnzq3CnB2NwN5Bwxb
	 RUdg3kpWe1u2lJQsKaJJOjSUM8NKww5WvADKPuZGMg2NYXE200wECjDKgXDZYISZw8oa7
	 uPF+L8Pf+i7+mQX7Oo0VLLgso39xCvNnx79mHUlpTQ+LMsNSbZly1GGwIcdcCy3Ifkyxt
	 QZkvwrwjYvyno9EIc+7ClN+SWz49rDkuWg8Msthp1+2Yl5dxFt7xlc/fJWewYIbjMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=bC7DjVmf;
	arc=none smtp.remote-ip=210.79.60.242
Received: from mail-m60242.netease.com (mail-m60242.netease.com [210.79.60.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE0606A324;
	Mon,  2 Nov 2026 06:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DE0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=bC7DjVmf
Received: from [172.16.12.11] (gyproxy-mailtls2-entmail-virt217.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5325ade18;
	Mon, 2 Nov 2026 14:51:49 +0800 (GMT+08:00)
Message-ID: <b012a73f-1834-471f-982f-84244b863dce@rock-chips.com>
Date: Mon, 2 Nov 2026 14:51:49 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: rockchip: do not restore QoS that was never
 saved
To: Jiaxing Hu <gahing@gahingwoo.com>, ulfh@kernel.org, heiko@sntech.de
Cc: sebastian.reichel@collabora.com, shawn.lin@rock-chips.com,
 zhangqing@rock-chips.com, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261101055633.101309-1-gahing@gahingwoo.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <20261101055633.101309-1-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19b074e4203a8kunm1cd43e6020218b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU4fVkpOTxpJGEMeH0xLS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bC7DjVmfge6voq7J+27TJQ++JcPO8y+rqy/5dy/AkhYlmSBOLipVPasTo2cW/f5wkVlem1BYf3uSkAFJqo97BisVIUOmbU2hq7ArQLIR0neW+8FAUptzDiVC4yicE2S53tgbbYPuBUK169JCV9CLVu/+mXP+F183i3iknXpAbVU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=PTkCharFQmf18BmR+HlsgqRfDjWer5Tuunqxyv1lgvw=;
	h=date:mime-version:subject:message-id:from;


在 2026/11/1 13:56, Jiaxing Hu 写道:
> rockchip_pmu_restore_qos() writes back what rockchip_pmu_save_qos() read
> on the last power-off. A domain that was off when it was registered has
> not been powered off by the driver yet, so on its first power-on the
> restore writes the zeroed save array over the QoS reset values.
>
> On RK3576 this is the GPU on every boot. Read back after the restore, its
> QoS is all zeros; with this patch it keeps the values it powers up with,
> priority 0x101, mode 3, bandwidth 0x80 and saturation 8.
>
> Only restore after a save. Rockchip's own driver does the same with an
> is_qos_saved flag.
>
> Fixes: 074c6a422d86 ("soc: rockchip: power-domain: support qos save and restore")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index db3879846db6..d1c025bdaa08 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -97,6 +97,7 @@ struct rockchip_pm_domain {
>   	int num_qos;
>   	struct regmap **qos_regmap;
>   	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
> +	bool qos_saved;

The fix itself looks correct. One minor nit: the downstream Rockchip
kernel implements the same guard with a flag named `is_qos_saved`
(you already reference it in the commit log). Reusing that exact
name would make it easier to correlate with the vendor tree when
debugging or backporting QoS issues like the RK3576 GPU case.

Reviewed-by: Finley Xiao <finley.xiao@rock-chips.com>


>   	int num_clks;
>   	struct clk_bulk_data *clks;
>   	struct device_node *node;
> @@ -474,6 +475,7 @@ static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
>   			    QOS_EXTCONTROL,
>   			    &pd->qos_save_regs[4][i]);
>   	}
> +	pd->qos_saved = true;
>   	return 0;
>   }
>   
> @@ -481,6 +483,14 @@ static int rockchip_pmu_restore_qos(struct rockchip_pm_domain *pd)
>   {
>   	int i;
>   
> +	/*
> +	 * A domain that was off when it was registered has nothing saved yet,
> +	 * and writing the zeroed array would replace the reset values the QoS
> +	 * registers came up with.
> +	 */
> +	if (!pd->qos_saved)
> +		return 0;
> +
>   	for (i = 0; i < pd->num_qos; i++) {
>   		regmap_write(pd->qos_regmap[i],
>   			     QOS_PRIORITY,
>
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

