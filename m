Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793531412;
	b=lNlkqgyrSMIzgfa1DEKGmkv0CH7GF08nukw3p3n9iu4u+LbOAN/t8lyLhAD1oOMgt5sE
	 x6tRKvZ0n98yHxKYiZ1a1oMiZloLZq9iZPECeGz1iFeiCiG6dGRYvSjqDKFM2mkpZxEjv
	 uK6tyJYHd0L+Y3pPFqpypARsvukBhxQnSY7U7oWMK4+yLobSHML4rQ2sg2zWNdOo+uNDx
	 TaRCx1KAr1nQNxekqvM1HiqzwG3O7oNcippTweEDpYu5K1ldY5A9m3qDN2GywBLb3s/Vz
	 CGtlfnD1tciUzBgMGCgqV100Nz+dvs01PpV6beG2uF07c7sEtG4fE/TONoOzndWkVRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793531412;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=o4gG/i3absZUKyk5WqO7dZSC3KzKqyXdlnRQkR3arf0=;
	b=tc/LgU3NAaFvKCLb6AqtvK60SduJyes27rUDuTzzorpCrSgZhd16lUl9hY8b/aj+a556
	 g5k8h/Q/yay1y1tA+EqVIDtjraZzjEZ+EjXcBk6LqMXEmFGO1SFiNarkbT4EoTbd1DzxU
	 ZaI4OAy0mnKecTaMaBo0LriO4U9Q2iK7zMGNKKUN6ba98th4tJpfo/+fPzlhbM48R8+/E
	 +RlUJOm00Gzwq+TvPCFWV6lavLBkHHIt5iKwtwo+fbh+ajoHYT+qvP/XhvDkh/YhMUkf0
	 c0m0Di9taf5Bv6lhtgXApGqMC2ww33CA3oHte1Ow8QZEJz5x2WdZKAuwa7OYX5srZbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Y34JQihT;
	arc=none smtp.remote-ip=210.79.60.93
Received: from mail-m6093.netease.com (mail-m6093.netease.com [210.79.60.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF92606A325;
	Sun,  1 Nov 2026 11:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EF92606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Y34JQihT
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5310d4819;
	Sun, 1 Nov 2026 19:09:59 +0800 (GMT+08:00)
Message-ID: <d419faee-354a-4712-b047-d88fa4cab37d@rock-chips.com>
Date: Sun, 1 Nov 2026 19:09:57 +0800
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
Cc: shawn.lin@rock-chips.com, sebastian.reichel@collabora.com,
 finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: rockchip: do not restore QoS that was never
 saved
To: Jiaxing Hu <gahing@gahingwoo.com>, ulfh@kernel.org, heiko@sntech.de
References: <20261101055633.101309-1-gahing@gahingwoo.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261101055633.101309-1-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa196cd4d2e03a4kunm5d7bf15e34a8a1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGB1OVkNIShpMTEtOHh0eTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Y34JQihTJ4/ryrn8Fe/mVgqrbxNaBqNU/IPUejG0cY4zW/MkLr6rkK5xwbtsL1z7KLzuFS/S1szB5Dx0HhjbJlQdBh2Th8g0WgJdAGk0fjHumW/0U6M1WWzIq8+6J/ZSWvPo0/9+m0Vsf0jT8a+yVG1G4nmhLIUZvhQiIoUjX6c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=o4gG/i3absZUKyk5WqO7dZSC3KzKqyXdlnRQkR3arf0=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/01 星期日 13:56, Jiaxing Hu 写道:
> rockchip_pmu_restore_qos() writes back what rockchip_pmu_save_qos() read
> on the last power-off. A domain that was off when it was registered has
> not been powered off by the driver yet, so on its first power-on the
> restore writes the zeroed save array over the QoS reset values.
> 
> On RK3576 this is the GPU on every boot. Read back after the restore, its
> QoS is all zeros; with this patch it keeps the values it powers up with,
> priority 0x101, mode 3, bandwidth 0x80 and saturation 8.
> 

Thanks for the patch. LGTM,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

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

