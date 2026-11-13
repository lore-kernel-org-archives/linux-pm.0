Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536675;
	b=hfM+VTDUgY7BEbSUj7p/2x5gkt7WQCHvzUcVBHKY8EBFWJ4RXE1zUwh5STHXSvaSi+6V
	 lP0uzyVnPzN3oI02b7qbKSDaYw2JUCeSimFw6yyZn7Ar+97M1fwgSqiLq8QGOfXlh+TNt
	 +2M6ITvUzGibtBaIeJ1bqDlPUuo5KFnYFSgm4z5Gsd+ksLFkX1IPm1qezm89GBsclmBZE
	 T4Z8Z1ssVO8Cu0Ts+lpjjxdOfDbwmRBkKVMKkHZs9mWJEgYqIY4SGadHmHd0tiKryVDKL
	 itZ8K+pjfa5VKYRfInOy1xJvtEC2VSX6SGSTlCoKKvkHKakWj/N5KbBidmC3XZf9GEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536675;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=bTGRVU+qryeU7dBfNfUwT6BNGpiqvf3fX2t69htDQ2I=;
	b=qywr+TK2yK6f8G8jSGion7sJMSpXjNcdCpjZELk1vZNTCbgFbVXg0VZq9C6nKp5VOMu6
	 j5CCMSZsuUsgLh3oNttb2D9JywqtWUEFXxVcnrdaeYR6KP3MQKSMyuarpenFU+Yf/NEUw
	 UlaZYP3oHpy4IvZXqvn6TRdPnP/DqFbqm3z7gWENtDsmCol+jGffkHzrxXkTMHS/4Mz3T
	 9ZDTBkc2ZNPJpCD+ycqBUawS+nfPjSKckkod78F22z7C2K7AqFQXnKs3qkReQGx1sAL8k
	 uAOFYZG3jyBbZeBTokx4FXq7nGrljrndOlJTq6h00jBOTybb/JnkDa2SEnAIfvdM3iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=LlDur80H;
	arc=none smtp.remote-ip=154.81.10.91
Received: from mail-m1091.netease.com (mail-m1091.netease.com [154.81.10.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FD606A33D;
	Fri, 13 Nov 2026 02:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F4FD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=LlDur80H
Received: from [172.16.12.11] (gyproxy-mailtls4-entmail-gy2-virt39.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5485cd352;
	Fri, 13 Nov 2026 10:24:19 +0800 (GMT+08:00)
Message-ID: <8d6eb19d-3c3d-4240-b933-4f9e032c4acf@rock-chips.com>
Date: Fri, 13 Nov 2026 10:24:18 +0800
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
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain
 supply
To: Leonard Lausen <leonard@lausen.nl>, ulfh@kernel.org, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 detlev.casanova@collabora.com, zhangqing@rock-chips.com, inindev@gmail.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, gahing@gahingwoo.com
References: <20261019092417.391522-1-leonard@lausen.nl>
 <20261019092417.391522-2-leonard@lausen.nl>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <20261019092417.391522-2-leonard@lausen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d2b857ae03a8kunm92effb9b4b583
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkJLVhkYHkkYTxhMTh5DGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LlDur80HtdgHZdi5vlfLf5OWv1qA83R0sKHOEFlyFM1qIr6fy5RT50fmG0Dl32WO/dPLmh1FQwBPFxp+RgUJU+DFRnM5umHc8x3RmJrogwDSiMCPhxfc0/4GIP7uMsWlMxz/5sre/Gh5we5HOguvBAThZFmMqX1okuRe6prX+qU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bTGRVU+qryeU7dBfNfUwT6BNGpiqvf3fX2t69htDQ2I=;
	h=date:mime-version:subject:message-id:from;

Hi,

On our side, the GPU power domain on RK3576 is off by default at boot,
so boot itself should not be affected by this domain. The ack timeout
reported here only shows up once the domain actually gets power cycled,
i.e. when Panfrost starts doing runtime PM.

Traditionally on Rockchip platforms the GPU supply is managed by the
GPU driver itself (mali-supply, together with the OPP core for voltage
scaling), which is a common pattern adopted by many vendors and has
worked fine on previous SoCs.

That said, this change follows the same design as RK3588 (domain-supply
handled by the power domain driver) and looks good to me.

Reviewed-by: Finley Xiao <finley.xiao@rock-chips.com>

在 2026/10/19 17:24, Leonard Lausen 写道:
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

