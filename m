Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397106;
	b=gMV0B62sp498ffIheJ1qAhQBxw51bV9fFZHl+vs/FJHOi0g7lfXxHTA/45W7h84yOGYk
	 ayabhObaOPYtfdcC7FT4J9w8jA/u6J8NWLAa2ZOn0DPJKMOh4oBXaWcYTQKoscrElEQvd
	 DAIc7I4RsJfKsx8ayhmpkqmuJVMTcO1Mz0zHyVhD0kZRSSP6j7HqB87Hom0EPjv/cM1gH
	 OzLwORyAgKfAV9l+jmh0/iklHqXZ5jIuYv3zg2+rli77OqHA96sAFn93RVoUg5Mizyj2d
	 +XPYwvxOjyqgcnNVctmxU3CnR6ORyUSHvuukvxSB6pGxeoCwz0fojRwpE+oyCh7iUhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397106;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nowaq5krQmYyET3/kT0HLFoDfuX9S6TMbuwqRBo7zJM=;
	b=Em/lvWJHsaLtbE+r5yEfeBP4/mBLgfJLHgsNriaciGcrWRA9QlQAHUzvmDgwhcOtttp7
	 84wAXfIOif74ivlW2W+ihGs7Tlq0jIxMm6Yf7s/a+VmnvJti9DytyqQgZCoZKUvxJOZ16
	 wCeWk7RD00h/5vNOZTrqFbfEqctQU7sC5YTBsxSi0TdP2tXx05g6PL/kemVJ7Kt2MbxI1
	 JM6oOQT6zmvgYIEJHoD2TqNyjqikkcS0tEKhu9XzINv5EemS885/j3rZev6vQGVXKID4m
	 1mG9fM/tTdaXwuRdcwx28Wr+L21zwZAG1TUPY0/rpBwl0DajCv3WPJQB2OKUGx5g0XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=aCTajLHP;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CA606A31C;
	Fri, 30 Oct 2026 21:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=aCTajLHP
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B01D4B0;
	Fri, 30 Oct 2026 22:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793396968;
	bh=YfYRQdKxBnVAUwjO81ld0nM62cSdG3LQxtwd8SV6nK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCTajLHPVXes4Pwnb7DjKOtGZYX1w3Hp06r5sjl0219fRsNg9xlnPnpr90LDvrRCm
	 bLagfybbHkHT5FrAcPA7spWbLsowJqkZ7Gj736JPd9psOnIGIqMCg+vz/7sBbhcmKm
	 hHhCVuKdOyrEFb/9j5gz7hyGPyI48l1Rz92lr6fM=
Date: Fri, 30 Oct 2026 23:51:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	Phong Hoang <phong.hoang.wz@renesas.com>,
	Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v3 12/15] media: vsp1: Fix setting control register by
 display list
Message-ID: <20261030215141.GE3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-12-e052903a3832@ideasonboard.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-12-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:52PM +0900, Paul Elder wrote:
> From: Phong Hoang <phong.hoang.wz@renesas.com>
> 
> According to R-Car Hardware User's Manual, VSP HW does not
> support to download register settings for the control registers
> by display list, so set those registers by APB interface instead.
> 
> This limitation is especially enforced within the VDK.
> 
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/vsp1/vsp1_wpf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
> index 821887815eb2e38d3a51791161de8cd3c135ef3c..4a5ad8e4903e99d5a522af2239889d7899f629cd 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
> @@ -332,9 +332,8 @@ static void wpf_configure_stream(struct vsp1_entity *entity,
>  	vsp1_wpf_write(wpf, dlb, VI6_WPF_SRCRPF, srcrpf);
>  
>  	/* Enable interrupts. */
> -	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_STA(index), 0);
> -	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_ENB(index),
> -			   VI6_WPF_IRQ_ENB_DFEE);
> +	vsp1_write(vsp1, VI6_WPF_IRQ_STA(index), 0);
> +	vsp1_write(vsp1, VI6_WPF_IRQ_ENB(index), VI6_WPF_IRQ_ENB_DFEE);

Unfortunately I think this will cause a problem. For the V4L2 and DRM
clients, all should be fine. The configure_stream operation is called
after starting streaming, which calls vsp1_device_get() to
runtime-resume the device. For the ISP client, however, I think this
function can be called from the .buf_queue() handler before the start
streaming operation, as vb2 enqueues buffer in the driver before calling
.start_streaming() on the queue. We would then try to write the register
while the device is suspended, which won't lead to any good outcome.

>  
>  	if (pipe->iif)
>  		return;

-- 
Regards,

Laurent Pinchart
