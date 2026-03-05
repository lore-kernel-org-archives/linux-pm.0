Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BD378D85
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706805; cv=none; b=qIjOlFhbvfA0eryIXwbkQ6zWY0+Fy1GwTcy0gZtf0ZFMe2h2fYP4w9EMoQnZpLk/a5LLy6bU8CJXU/yRb8gnvK5YsIhtt5PifaB3oixGGia0Fhfsi5X7qgGc9AjCJR76UgT9n4HGfYRH/gI+RFs/X30K7xsBZfnUzQ7dZDfJgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706805; c=relaxed/simple;
	bh=O2ceNp0v1y7OfAwh+zyQ5ZRZ8khQkWInlECudLwPWvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8zPf1uHTYyLCV/u/CS5AUrmb7IdhT5ZoSqmb9ceoPihjW2yBgqHArtG1qzBZv2JVpeek7FtPGUJyM/vw5LsCTAMheBtXc6DicuivW0DStKIoizPqSQX/qmbM4ayPFtkNSr+hXW1Pqu+x2ewRloozsr7KT3UIpoTBDY4lB58qrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy60p-0005YH-Bg; Thu, 05 Mar 2026 11:32:59 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy60m-003rpi-1E;
	Thu, 05 Mar 2026 11:32:57 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy60n-00000002Foi-2UBF;
	Thu, 05 Mar 2026 11:32:57 +0100
Date: Thu, 5 Mar 2026 11:32:57 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	fra.schnyder@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com, 
	peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] media: verisilicon: Fix kernel panic due to
 __initconst misuse
Message-ID: <azwbgxp4pl3m6klyvd5htmy7h7pc76nqvvgmi6pudvfl7zippl@svv7tiibyrci>
References: <20260305100149.722-1-ming.qian@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305100149.722-1-ming.qian@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 26-03-05, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
> 
> Fix a kernel panic when probing the driver as a module:
> 
>   Unable to handle kernel paging request at virtual address
>   ffffd9c18eb05000
>   of_find_matching_node_and_match+0x5c/0x1a0
>   hantro_probe+0x2f4/0x7d0 [hantro_vpu]
> 
> The imx8mq_vpu_shared_resources array is referenced by variant
> structures through their shared_devices field. When built as a
> module, __initconst causes this data to be freed after module
> init, but it's later accessed during probe, causing a page fault.
> 
> The imx8mq_vpu_shared_resources is referenced from non-init code,
> so keeping __initconst or __initconst_or_module here is wrong.
> 
> Drop the __initconst annotation and let it live in the normal .rodata
> section.
> 
> Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
> Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
> Closes: https://lore.kernel.org/all/n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp/
> Suggested-by: Marco Felsch <m.felsch@pengutronix.de>

This fix was suggested by Krzysztof :)

> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> v2
> - Remove __initconst
> - Add missing Reported-by tag
> - Add missing Suggested-by tag
> - Remove comments of sentinel to pass checkpatch.pl
> 
>  drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index 6f8e43b7f157..6fbe3c581032 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -343,10 +343,10 @@ const struct hantro_variant imx8mq_vpu_variant = {
>  	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
>  };
>  
> -static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
> +static const struct of_device_id imx8mq_vpu_shared_resources[] = {
>  	{ .compatible = "nxp,imx8mq-vpu-g1", },
>  	{ .compatible = "nxp,imx8mq-vpu-g2", },
> -	{ /* sentinel */ }
> +	{}

Unnecessary change.

With both fixed:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>


>  };
>  
>  const struct hantro_variant imx8mq_vpu_g1_variant = {
> -- 
> 2.52.0
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
