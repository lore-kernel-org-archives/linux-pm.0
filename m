Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.83.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383190;
	b=Yn+x5HCAyTYY0RrVCZoKm6CsUZxaok9tLVfgoIfICdS4A5NPc4Nmdr0+giwm0c6NT9zX
	 Jz5ohMp6gH+dt/aWNs1eWHgkbIRqoYzyXNxKfmOamMX33+Oj0ySinnRVrndbA6th7QtFY
	 ct5zDD8wHM5667FCa8y3v8ziPGDuYmawtzeD4hIs9WLzBGXFOOkhkzwy9evyz6vU9CGAF
	 15ZPg4cUiW0xw2bNCKJm5OwrOfiqCuBhGK/i5eoyg8STL/L7M6i5RqUvGlqsfQN4EU3eJ
	 FAaS6y/kKy2N8BKP41ZhiO5y+JWtzWrY6J7XVZUXFrGTSYe1w0oo3iMZvdt5ZLIPNXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383190;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=c1VSYUCW8DjIZRH9cT9PKM8BeqoT2mVv/wXrHisLhI0=;
	b=n01JEaUZ0UGvI7Xk6+1CIeoGRpDJth8pDtCgDMMl33HPdLpp5MssIttbWcg9cMl1tbk4
	 zEqBerwXAE1uHNrv40L3dl6zbMFxVCLQYAP9sHHBNkLPb0zqZNQOd3ZlNYsukEFHaXRlc
	 txK5QkScINMozIw8yqNH6gAjyZm5RX4pd30zmJfzvwYr3ghQ5TiGlfoHDJhtqG8LhGFwV
	 4T/xBCaNKHsKrlNgvuBjaVYokcpSAv5LC4YM6RKvwxSMJCaUcgYg5jT47YgtXxA6ETSvi
	 raEceQZj9tDJFg38y6Waj40iHmFxzyqft+fzJ79+nFF0P2V1NWd/kpyNG0Qo/Ot2vPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="DsS/fXyT";
	arc=none smtp.remote-ip=156.224.83.219
Received: from mail-m83219.xmail.ntesmail.com (mail-m83219.xmail.ntesmail.com [156.224.83.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B0606A31C;
	Wed, 11 Nov 2026 07:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 265B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=DsS/fXyT
Received: from [172.16.12.11] (gyproxy-mailtls0-entmail-virt215.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 544786367;
	Wed, 11 Nov 2026 15:46:07 +0800 (GMT+08:00)
Message-ID: <4043eb42-ce62-41ff-9a7d-d840bb90364d@rock-chips.com>
Date: Wed, 11 Nov 2026 15:46:07 +0800
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
Subject: Re: [PATCH v16 09/16] pmdomain: rockchip: add optional per-domain
 power-on settle delay
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-10-gahing@gahingwoo.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <20261108065917.135194-10-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c9923f9203a8kunm2dd9fb713a378a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU1IVh9CHRpNQh1NH0pLHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=DsS/fXyTLnDgYvp4+HkqNssTj/QM61Fo3GnodXNmaCRPr2KWX7UWDRpIfJDDkszxhbuKwJP9MLaKB2+aG2VRLw1doWXQEajCGSYqF1Zu2Ok6Z8JZ2525aVYsklSN7UjrZex71vfnr33sqgYx00j4eu0zWgq2vrGIHnuomDKY/V4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=c1VSYUCW8DjIZRH9cT9PKM8BeqoT2mVv/wXrHisLhI0=;
	h=date:mime-version:subject:message-id:from;


在 2026/11/8 14:59, Jiaxing Hu 写道:
> The RK3576 NPU power domains need some time to settle after the idle
> request is released.
>
> Without that wait, the QoS registers are written while the domain is not
> fully up, and the first cold power-on raises an SError.
>
> Add an optional delay_us field and wait that long after releasing the
> idle request and before restoring QoS.
>
> Rename the DOMAIN_M_O_R_G macro to DOMAIN_M_O_R_G_W.
>
> The NPU power domain is switched off when the driver probes, so the first
> power-on goes through this wait even when the bootloader left the NPU on.
>
> With delay_us set to 0, an SError still happens even with the regulator
> kept always on; with 15 us, 536 cold power-ons in a row are all clean.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 56 ++++++++++++++++----------
>   1 file changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index db3879846db6..e3cc60fa2277 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_clk.h>
>   #include <linux/clk.h>
> +#include <linux/delay.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/mfd/syscon.h>
> @@ -59,6 +60,7 @@ struct rockchip_domain_info {
>   	u32 pwr_offset;
>   	u32 mem_offset;
>   	u32 req_offset;
> +	u32 delay_us;
>   };
>   
>   struct rockchip_pmu_info {
> @@ -185,7 +187,7 @@ struct rockchip_pmu {
>   	.need_regulator = regulator,			\
>   }
>   
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
> +#define DOMAIN_M_O_R_G_W(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup, regulator)	\
>   {							\
>   	.name = _name,					\
>   	.pwr_offset = p_offset,				\
> @@ -200,8 +202,10 @@ struct rockchip_pmu {
>   	.req_mask = (req),				\
>   	.idle_mask = (idle),				\
>   	.clk_ungate_mask = (g_mask),			\
> +	.delay_us = (delay),				\
>   	.ack_mask = (ack),				\
>   	.active_wakeup = wakeup,			\
> +	.need_regulator = regulator,			\
>   }
>   
>   #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
> @@ -258,8 +262,11 @@ struct rockchip_pmu {
>   #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
>   	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>   
> -#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
> -	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
> +	DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, delay, wakeup)	\
> +	DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, delay, wakeup, true)
>   
>   /*
>    * Dynamic Memory Controller may need to coordinate with us -- see
> @@ -681,6 +688,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>   		if (ret < 0)
>   			goto out;
>   
> +		/* Some domains need to settle before the QoS registers answer. */
> +		if (pd->info->delay_us)
> +			udelay(pd->info->delay_us);
> +
>   		rockchip_pmu_restore_qos(pd);
>   	}
>   
> @@ -1314,25 +1325,26 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
>   };
>   
>   static const struct rockchip_domain_info rk3576_pm_domains[] = {
> -	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
> -	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> -	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> -	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> -	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
> -	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false),
> -	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> -	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> -	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
> -	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> -	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> -	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> -	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> -	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> -	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> -	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
> -	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> -	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +	/*                                            name    p_offset pwr      status  r_status r_offset req      idle     g_mask   delay wakeup */
> +	[RK3576_PD_NPU]		= DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
> +	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
> +	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
> +	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
> +	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  0,    false),
> +	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
> +	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
> +	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
> +	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
> +	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
> +	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
> +	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
> +	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
> +	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
> +	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    15,   false),
> +	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    15,   false),
> +	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
>   };

1. The settle requirement is on the top-level NPUTOP domain only.
    PD_NPU0 and PD_NPU1 do not need the delay: when a device is attached
    to npu0/npu1, genpd powers the parent (nputop) first, and by the time
    the child domain switches on, the settle time has long elapsed. Cold
    power-on of npu0/npu1 without any delay has been clean in our
    validation. You can just drop delay_us from both entries; keeping it
    on nputop is enough.

2. The same failure mode exists on the display pipeline. PD_VOP needs a
    15 us settle as well.Please add delay_us = 15 to RK3576_PD_VOP.

>   
>   static const struct rockchip_domain_info rk3588_pm_domains[] = {

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

