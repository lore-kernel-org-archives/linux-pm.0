Received: from mail-m103131191187.xmail.ntesmail.com (mail-m103131191187.xmail.ntesmail.com [103.131.191.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58939498922;
	Mon, 19 Oct 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.131.191.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404338; cv=none; b=TJIh8cM1vs/AwGKzcNfgxtI98IHUbqb1D0dMcCmf/ZqKZhemFwei2MmaUF51l6AbZ9R1bUmDlv/wugwQ/nlxs09OyYkBqz2mXA32fPT+f/Y9msQrML/TSVc0QRCOsIssswv15pJUQlxQcMlxoNV9wGqw6910Qgy0Fu+LseaoCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404338; c=relaxed/simple;
	bh=aP6gpqF3SRKV+cz/DZ3F4I5kr6Ch5wFAFsX4kBbIe6E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CThoDaqtWBwNXr5L8j/sl5MGZjDFAB1I7+xsdO750MblLVR9kJkGq0QSGNWmpVaDYcPgMYSsrBrt7GmyF6uXLNAXXtC9W2ynz4z4YbVN/Hgk32YFyRusAmDT4gG4SSJWnuYtlZsVzT40Q5k587vkD7Ny8HUx5ZRbYTWiBFVPolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OzAuOrMS; arc=none smtp.client-ip=103.131.191.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OzAuOrMS"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 518c72105;
	Mon, 19 Oct 2026 18:05:22 +0800 (GMT+08:00)
Message-ID: <dd24624f-25cf-4f1f-aafe-064c22b0226c@rock-chips.com>
Date: Mon, 19 Oct 2026 18:05:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, detlev.casanova@collabora.com,
 finley.xiao@rock-chips.com, zhangqing@rock-chips.com, inindev@gmail.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, gahing@gahingwoo.com
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain
 supply
To: Leonard Lausen <leonard@lausen.nl>, heiko@sntech.de, ulfh@kernel.org
References: <20261019092417.391522-1-leonard@lausen.nl>
 <20261019092417.391522-2-leonard@lausen.nl>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261019092417.391522-2-leonard@lausen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1539f76c503a4kunm93d66b22706dd2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh1MVh8fThgfQx4fSEpPGVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=OzAuOrMSSc4NEyK3dbA+prFmbfSJSxw5HEAON51DvF6GTPJVffqPDlex3dFUBRy2S9HvYOPftQFIgl4fA7JvkPCNi5LZ7D9ENmebMHjkcDak22FxF26WQsuQpxniuyaMosRo5/Uhu85VIqI5d2Uw1iAQcEZXPr6Z44eOMxaejwk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=217PjOf4FEFkv0Sop8OiYO8Cf7p7mV1hzNZL4FLAjcY=;
	h=date:mime-version:subject:message-id:from;


在 2026/10/19 星期一 17:24, Leonard Lausen 写道:
> On the NanoPi M5, boot hangs during Panfrost initialization. Before this
> fix, booting required blacklisting Panfrost on the kernel command line.
> Loading Panfrost after boot reports a GPU power-domain acknowledgment
> timeout:
> 
>    failed to get ack on domain 'gpu', val=0x113ff
> 
> Add regulator support to the RK3576 domain descriptors and mark the GPU
> domain as regulator-dependent. This lets the existing Rockchip
> power-domain regulator handling manage the GPU domain supply.
> 
> A corresponding domain-supply property is needed in the board DT.
> 
> The regulator-capable descriptors are based on the regulator support in
> Jiaxing Hu's pending RK3576 NPU enablement series, without its NPU settle
> delay changes.
> 

It looks correct to me after checking TRM that PD_GPU need a VD_GPU on
this Soc.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Link: https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahingwoo.com/
> Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> 
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index e193f978d5f35..b41f9fcb62bfe 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -176,41 +176,42 @@ struct rockchip_pmu {
>   	.mem_offset = m_offset,				\
>   	.mem_status_mask = (m_status),			\
>   	.repair_status_mask = (r_status),		\
>   	.req_offset = r_offset,				\
>   	.req_w_mask = (req) << 16,			\
>   	.req_mask = (req),				\
>   	.idle_mask = (idle),				\
>   	.ack_mask = (ack),				\
>   	.active_wakeup = wakeup,			\
>   	.need_regulator = regulator,			\
>   }
>   
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
> +#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup, regulator)	\
>   {							\
>   	.name = _name,					\
>   	.pwr_offset = p_offset,				\
>   	.pwr_w_mask = (pwr) << 16,			\
>   	.pwr_mask = (pwr),				\
>   	.status_mask = (status),			\
>   	.mem_offset = m_offset,				\
>   	.mem_status_mask = (m_status),			\
>   	.repair_status_mask = (r_status),		\
>   	.req_offset = r_offset,				\
>   	.req_w_mask = (req) << 16,			\
>   	.req_mask = (req),				\
>   	.idle_mask = (idle),				\
>   	.clk_ungate_mask = (g_mask),			\
>   	.ack_mask = (ack),				\
>   	.active_wakeup = wakeup,			\
> +	.need_regulator = regulator,			\
>   }
>   
>   #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator)	\
>   {							\
>   	.name = _name,				\
>   	.pwr_w_mask = (pwr) << 16,			\
>   	.pwr_mask = (pwr),				\
>   	.status_mask = (status),			\
>   	.req_w_mask = (req) << 16,			\
>   	.req_mask = (req),				\
>   	.idle_mask = (idle),				\
>   	.ack_mask = (ack),				\
> @@ -250,25 +251,28 @@ struct rockchip_pmu {
>   	DOMAIN(name, pwr, status, req, req, req, wakeup)
>   
>   #define DOMAIN_RK3528(name, pwr, req)		\
>   	DOMAIN_M(name, pwr, pwr, req, req, req, false)
>   
>   #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
>   	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
>   
>   #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)		\
>   	DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>   
>   #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
> -	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
> +	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, true)
>   
>   /*
>    * Dynamic Memory Controller may need to coordinate with us -- see
>    * rockchip_pmu_block().
>    *
>    * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't try to
>    * block() while we're initializing the PMU.
>    */
>   static DEFINE_MUTEX(dmc_pmu_mutex);
>   static struct rockchip_pmu *dmc_pmu;
>   
>   /*
> @@ -1323,25 +1327,25 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
>   	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
>   	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
>   	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
>   	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
>   	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
>   	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
>   	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
>   	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
>   	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
>   	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
>   	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
>   	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +	[RK3576_PD_GPU]		= DOMAIN_RK3576_R("gpu",  0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
>   };
>   
>   static const struct rockchip_domain_info rk3588_pm_domains[] = {
>   	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
>   	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>   	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
>   	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
>   	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
>   	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
>   	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
>   	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
>   	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),

