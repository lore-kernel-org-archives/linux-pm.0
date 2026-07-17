Received: from mail-m10186.netease.com (mail-m10186.netease.com [154.81.10.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4753B83FE;
	Fri, 17 Jul 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282547; cv=none; b=dwog5fubDxjHuE0oZ5yPH5nEnoMku5xt+Kf6KGfVex4HS/1VBBpJWkXOpdN7UGvXKVDHo/LmfMInK9bUOTEDm1HnjylYC5fcPPw+fam1Qz9U7Fj4gfVhvkZhuKZGSV2z8sCudpgTlrG48AjUlr/saOKuWZz1eoPQjqFQhLl/wIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282547; c=relaxed/simple;
	bh=8KPkOoooJlwcuKBLh6Ot2Jb/iDiHjOSyAgO6QDzr1/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+VX30IojszRbHmL3rq2Ivu/yIGdoEk59hgACHwr+mWV9RzIZrFxsscy0EWLm3Xm+VhW+SrnZeI69pSx8prN1L3Vc7EleyiOWF3Bc6/ZlLFWkZllEBLrPrZ5Al6ZSG8UnWt2rE4YjHxZRdR71d0fgCGMByJWolcw9hcHO24WceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CanspQY3; arc=none smtp.client-ip=154.81.10.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CanspQY3"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4695fcceb;
	Fri, 17 Jul 2026 18:02:11 +0800 (GMT+08:00)
Message-ID: <5c0c8de1-a340-43f9-8906-3fad22135001@rock-chips.com>
Date: Fri, 17 Jul 2026 18:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-2-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260717085220.3212274-2-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f6f86c73309dakunmb26c5b98998f5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0oaVktLS0JCQhhNHhodT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CanspQY3O3PM+ZI89p8f7mNRUoyig/xUchaPTtE8hUciWBgQ795Gqv0fE7uU1lrYOBOT5Hi+p3aVpBM/mNlv+pZ6ZKfUJMVJuJ4jzXfPrqerjWVgdAxj2wJlEqBSFQYMYYGPB360EhFYww06xbQgdvGhTmWMJYb1qBET3Y+Omek=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=euhR+NFnLdb+bsfUoV9W/QJPUb0t9RuSsI5XmiS1jBs=;
	h=date:mime-version:subject:message-id:from;

Hello Jiaxing,

On 7/17/2026 4:50 PM, Jiaxing Hu wrote:
> Document the RK3576 NPU core: add rockchip,rk3576-rknn-core to the
> compatible enum and drop sram-supply from required (RK3576 has no NPU
> SRAM supply).
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> index caca2a490..d904db3bf 100644
> --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
> @@ -21,6 +21,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - rockchip,rk3576-rknn-core
>        - rockchip,rk3588-rknn-core
>  
>    reg:
> @@ -75,7 +76,6 @@ required:
>    - resets
>    - reset-names
>    - npu-supply
> -  - sram-supply
>

You should not delete this item directly. Instead, use the compatible 
to distinguish whether it is required.

>  additionalProperties: false
>  

-- 
Best, 
Chaoyi
