Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6493D952E;
	Mon, 10 Aug 2026 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364360; cv=none; b=cLoD/CoI0YVrnzQymEU257byVk668dkjUDh+YPy2i08Gg1oMIiFUBmpaiO/EjKfNA5aUnca6whPG9QFAkt3W5blO+wJo23AMdEs7uB1iLG/5Xs7cUVj91FkKna4n56j7XHEZgGW79Lee+1rx4FndEDgldZnk9/7rcRDfYdTjjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364360; c=relaxed/simple;
	bh=rvDl1NZrMjACOeMwLTukdq6COoqukX883McrkB8fLh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a63Zi03jhA15B7Feb9Sd3xQhhlUBYXRWXYBFpvIDxFTUc6SkYa7S5XvXA4cfFQHtwgqQqwPTcvUJxWb7MM14oTGvavsxMfkMl7vSZag48UwJpuEDlcwzzk/3jje3r+motF8tVRqls5FKk+bCpN6CITT74T/9m/T0TE9khYu1Hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=At7PjhLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ryj7KPmi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="At7PjhLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ryj7KPmi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9328814000DA;
	Mon, 10 Aug 2026 08:19:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 08:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786364357;
	 x=1786450757; bh=DBwv38UeXEElytz9teiFCRmmtzj4WSjjGc8R94lRcZc=; b=
	At7PjhLJ+qoC8h/+9Sz3M2X1AtLWdRoebeFcGKiGfSpwZvXyhRfMtJyhWVbZQnKp
	8CHhgt7pd1pS/eOHVhEXALVvlukn9KLR+rn1eDbYc/MPZJBVPdJT73XprvzyNrJr
	UWChHySxzA/GRYtjRQPz1ko2uCXBioxn6BhOMx/xAuCEmvGUK8tXvznY5k7tY/r7
	EHCt6rTosqwUQ+MrgwvzLAV5zRu7VSJQGzmh6NMwEfMFo2CsNycdbAd93khC8ONH
	i1/2xgYr6jLiVSxohDFJ6w+VSAU5ncryRd3hFdeKVJDtpJPAiQu2rdSmU7vpS/lo
	zIcQmDzwotiaFY3brpTtwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786364357; x=
	1786450757; bh=DBwv38UeXEElytz9teiFCRmmtzj4WSjjGc8R94lRcZc=; b=R
	yj7KPmiGNVki5pGQxYZvz2JGUaHQ6fJfKlk5yyDOcW+uu49YI+6tBq1Pw1pe41P7
	VMmhu0I/Gmnh8PQlqxAGAuiZuwfvYsumyYqmOqzmpj8tVAoDb4TZK/2C/CnDyZqR
	rU/ESUFLQWZ0Y7miboAf9brL0tmQe+6KIZ8XFr4xUKoKXXAPjvVyotefyMOAky14
	SCHyfDRqEF5YprflqPezecBFWck6ivLq4pRgjyytrDDwT6sj1/ffx/MBmBFiiWgN
	FKQaIkYUV/abpNyX0PdOroQIJYfZWRbjWntVxNvln9Ujg08vI8QebMS10bBGXdTh
	LlLSVzlMDh0J2qiwhtnMQ==
X-ME-Sender: <xms:xMF5alEbU2A7gQhdsNx7y9Ybnt7jIozoXHTmtIZ69eVoRrEkFpIJ7A>
    <xme:xMF5amvneVv1zlM5ftYgK7s8obtof-psYIa3lcMQO28AkBGUmIVsm9xensy_JLwjE
    c1i1jXzpTA6Uv5pbn-g5V03zrC6mmLk0m0GvbowQU-asfBRGV18TTg>
X-ME-Received: <xmr:xMF5ark7MdxNFHjLit9ke_hfQCurH1GciG56iSGDUyERr5wpYhJRHahHg237q1GC8od6vSwafBoeWOvyVuovRnKejhtpDiU>
X-ME-Proxy-Cause: dmFkZTEDDqrNSdgSsKCPCdPI3lxCUuqB8DUfkCYBJ3tKCtz/LAyfDJv3pqAO+Y0tOOyUvz
    09OhP42vTck3IcUy6AJUmupZeSfBoWtnYR8IXLhk+1ZuchcO5HP/wvlEP6+ULFcaLKhMEw
    wYpu+Z+esai9O/xmG04bWobemuAAvK84/9bBP1x1Nn3hXc4hXirNczsQ30KX0XhyE7e+Z4
    irM+sZHZ6wnwR4KMWD8ZqFwgyXGAqE5KfkpvN0bopVdsIYR+OamtCXyhHhrYVHfvnvbRDw
    HNLmEfzoet/7qsMfkmuoBR3Aw1YYbgyFVW4W9TA0U9C/jbVCLSeTB6thsaHqXQghI3TVKB
    YzfCKYJM0wU5yeW4G8xc779ghB27rDlqfAmgtbWRIhzPMK7HyeYVLO6OG9hDXPWG2Wp/5d
    UkpAR6BjIgoFUz3R4Wtlin8X2C/wRtVQpm/zwY/SryyJWqCJmU0Xctr9MfJwmo/ejpsxZw
    11bH01BBoJ8zc8ac6NrfyBODrLuUJeLfZDXgMYW8AQs9xMnOQw+l6ZRoQNMu0XNzAcn+zK
    HO17OMMy/W5h/5aj5ZbWq1WK49rDKSDyTSmVssfwktD3GTjpUHE8cJLiZak91Agd6+983n
    NHB7i8+KX16HUoTXQsbi4TOPims+cGYSDmHBUBArVyCZKL91wWKUagb50TZA
X-ME-Proxy: <xmx:xMF5apO4XwBvlUnDgGrnuWw7I2BqkD6YMXbYBgzGc-17lYIFl7rrBg>
    <xmx:xMF5anxI4HY9O4mHGEF9t7rPsthJhP88sud1UIY-zSU2guds4BsX6g>
    <xmx:xMF5autoVZSScBTAkYxeyOv0uu1pwVhDpKfz_ZzDPb_EkfxmcxJ1Tg>
    <xmx:xMF5aibTb_uX-TDzltbXqQ7NPv785UfAZf9trYiIoWq_8C3m68dmyg>
    <xmx:xcF5asiIf3ZigFz8JiPSeH-NAlgtL5Zul_hi9y8d1QA4x4BUmQD7RRU3>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 08:19:16 -0400 (EDT)
Date: Mon, 10 Aug 2026 14:19:14 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: phucduc.bui@gmail.com
Cc: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	rafael@kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
Message-ID: <20260810121914.GA2757863@ragnatech.se>
References: <20260810111841.77898-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810111841.77898-1-phucduc.bui@gmail.com>

Hi Bui,

Thanks for your work.

On 2026-08-10 18:18:40 +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> rcar_gen3_thermal_request_irqs() may return -ENXIO when no optional
> IRQ is available. The caller currently treats all negative return values
> the same way, disabling hardware trip-point support and continuing probe.
> 
> Distinguish -ENXIO from other errors so that the existing behavior is
> preserved when the optional IRQ is absent, while errors such as
> -EPROBE_DEFER, -EINVAL, and other failures are propagated to the
> caller.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Link v1 : 
> https://lore.kernel.org/all/20260807093058.42840-1-phucduc.bui@gmail.com/
> Changes in v2: 
>  - Update the commit message.
>  - Move error handling to the caller.
> 
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 94804816e9e1..04a57ff724f4 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -527,8 +527,11 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	priv->info = of_device_get_match_data(dev);
>  	platform_set_drvdata(pdev, priv);
>  
> -	if (rcar_gen3_thermal_request_irqs(priv, pdev))
> +	ret = rcar_gen3_thermal_request_irqs(priv, pdev);
> +	if (ret == -ENXIO)
>  		priv->ops.set_trips = NULL;
> +	else if (ret)
> +		return ret;

I'm not sure I like this.

The old behavior is that for any reason we can't get the optional IRQ 
the driver still works, but without hardware trip points.

While the new behavior is that if *something* other then the IRQ not 
being available we fail probe. What is the gain here? What benefit is 
there from the driver not providing thermal readouts if say for example 
getting the optional IRQ would return -EINVAL ?

>  
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund
