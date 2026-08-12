Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B231E83C;
	Wed, 12 Aug 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538580; cv=none; b=vEBzw0beG7aSyNQEIkFszS8Q3Ol96FSphUgwTnwzP1FMdIABvNgfxOmEGsXvR3pH4axTn3M9BI6gNdG6xhFMf5oMJJekSYipVUzyQd2RAYFKlGVPQTYwT6aW7NEGAX63hdNWBs6SLJ808RzRQ2Wp0GlBREOm72FTYCEu/82uliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538580; c=relaxed/simple;
	bh=aWEWOC/UiBCm9vMfWBtgOaZDxi/cOMiRDOtBCLercq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDTm59Wp1tw9Ws35lPpGxDbmJimPyzZE2GMsB41e9puBQ9q8RzydaciKmWLVsj+GrnLo/oBaDvRWbh8CWHFfqETTZWTmgzIlms1sp7zScCSIjNNkyF8tMEwHrg3z/Jjy09JtGaKYlXGLDUenIgbN25cwOsGY+gGWyp9iFbq5dQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NuEzMHNi; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NuEzMHNi"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 49b879d54;
	Wed, 12 Aug 2026 18:20:19 +0800 (GMT+08:00)
Message-ID: <058c3169-a45b-4f24-a3fa-a29fab630e1f@rock-chips.com>
Date: Wed, 12 Aug 2026 18:20:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, alchark@flipper.net, diederik@cknow-tech.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-11-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260812094106.1391698-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ff57cb9d403a7kunmc8d69eb45b64d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUMdVh9ITk0eQ0MfGU1JQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NuEzMHNiGUSSHGoAfQCwzwuU7wI4fsEC3/MclqNCgtvUiCMPjty0e6jWTc0PDW9D1BTgtx/pzuZggNDZAIhAhLepUw0U8VpAWf8A1r5O20/H/s50v5T5H6Vr6ugDytaCR6VW0b9FqC9uf1RxzOtvuiPXuTPyPxsN3VmProvGDb8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8AJ1Oqbln5M/WFmyknVkCV5oyd8bW8oHnGVTSKpm9uk=;
	h=date:mime-version:subject:message-id:from;

Hi Jiaxing,

On 8/12/2026 5:41 PM, Jiaxing Hu wrote:
> Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
> core from vdd_npu_s0.
> 
> The supply is marked always-on because the NPU power domains are what
> gate the block here, and dropping the rail underneath them takes an
> async SError on the next power-on rather than a clean retry. Only
> rknn_core_0 is enabled: the driver binds one core per node and the
> second core is left to whoever can test it.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> index 272af1012..965e0906b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -442,6 +442,7 @@ regulator-state-mem {
>  			};
>  
>  			vdd_npu_s0: dcdc-reg2 {
> +				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-enable-ramp-delay = <400>;
>  				regulator-min-microvolt = <550000>;
> @@ -869,3 +870,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>  		remote-endpoint = <&hdmi_in_vp0>;
>  	};
>  };
> +
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu_s0>;

Out of curiosity, I searched for code about this supply in the rocket
driver and found nothing.

Then what is the consumer of this regulator? I have reason to suspect 
they were automatically disabled.


> +	status = "okay";
> +};
> +
> +&rknn_mmu_0 {
> +	status = "okay";
> +};

-- 
Best, 
Chaoyi
