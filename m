Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559382F8E89
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421283; cv=none; b=LsM3/jTF22FgkTd2RvF2pbnrgBAx87RKOR8eW290Kg+UpoXODgv13wREjG861GdqEsqaiijcfyRimSW68dvSeMFUZ0M+nREl1VcODbEb2bGrxtHCG4g/oAK3iyixm/6Dw55sO+cw458waykQL0QLFdU0FFt0rvY/vgq9g5LXdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421283; c=relaxed/simple;
	bh=tF9rAEVCV1Zmu19XOcuxYFCjGVU8FBzBnf639u/M6NE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4Lq+NkYUANJI62YXL44G7xBUyoNMMkE7SIpHx/unE5oCK9kQitNStc24ZFKT6/aYw0nrpvN9aCFFP5NLm/AK8kSRUr00uchHF88ZpqBp7OGhDieLQG0mxRQ5cJ1wfnhCWUGL3hwz8yjPGzhQq+2ZqrMwVlfXU5VrPrTG11bfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU9PZEK+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU9PZEK+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef4223be7so1214753f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421281; x=1782026081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9nSQ+yfDg6eGkA3F5El5qmydZTplBrIuCCSHAiRy4+I=;
        b=CU9PZEK+UNt9MKRD4jCLvDGGBx0GfpBXYgfBBkvEl7NRvilZUhoDBi0nfo+ET+0lim
         kRPWwMSqe/lH4cgW3gunjCsN5+A3Axccx61N614kTcRPcFMNjLpxkNuUA4+p6caQY7GN
         b2HSA9yerDtds1CyuisDpXH+ui43lJ+v8ovn1rQdMplDnlQaF+5Ip9TyGaiNemQ25v4c
         mFwA2UxpqXTeLymNDQF8Zvuc3eKlWaZpVU/PFss108NfVlLC7VA7FmnmpXWyM3wTkQqJ
         ATq9DuuM6LL94MoRf61nqMhA4/UVxW47JkbLmbBJUGPOz3iZXXndOoXp58psnKriKypE
         VT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421281; x=1782026081;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nSQ+yfDg6eGkA3F5El5qmydZTplBrIuCCSHAiRy4+I=;
        b=aiarsxkdqqX8j7N/0n6Y/11B1NTbkkFEtC6ooq0oHWx7mGLdOTP+yjd6Y59daN72e3
         bjJR3mlf0df62HfotQlano6NtDF11fCMfHygGHYlTrBxvglEIqkHayxHz/sdwIUR1oSA
         CtRaKEypgR5dNY8T6wMxSvyRhf8d2/ITodlPMSc+xVFqeoX+PcKqoGP8DFMSErOdEVGw
         uTR5D58Ab0xDYPi32k0CQqUi4q1N0ynKfv4G5I6a491tWYdKb4J1WF3ggwGQ8hqTGM38
         c2EY6kkrRpdzxB6LnxYcycVTPmceZQbP44eoigRuQSdkFQN4+ZfsB9FsweXu5J7uysMr
         CF0g==
X-Gm-Message-State: AOJu0Yx7UXPizKWtHT0Sciut3GR6ik/6h+9YlbNX585mcrzOPsADguw4
	SY8Wr8yvXkf9g0uxpSUwenF7XU8We2FSXS8qYzfA9L5TcT1DmvT9v2kw
X-Gm-Gg: Acq92OErqCWnY5LEghrXRPfEYnCKCZdtQoCO57KeZ5BMA9oDMApp2OM9zA7l1AY9SMx
	Act0qGnZROM3ctmFF3T5qAbVza1hpgh1zefB1CLG4nUye4c1Gdam7NMM6b9V/xQu2k5daGtgRYH
	/gZBJIkO69n3ZBxaoqrEd2mwewdCtmt1m2AESfeQqhfGNQATu61U/4UzH7Fv/fUucl9xeCXkkVE
	WFzjiOmk7AK/CcZq7HfLR4RVOI0sBW3Xht0AXXxzuTgqb3s2IQfc9IljMwyGhkEU9yHk7yJGd+U
	kuGszTaST4OJEyCmwcx4PJqQZtv90ROT7MeZVuDgmmuBRoIpnBmwo/SQ8nvJQqFS2lNSS3AhzDe
	mWDfwqp/L+xUaIDm8mLGs7r2iTICNA+0F5c44gZs5MYMZ8kd4lNJmxWqeTwTQRF4qL5n5nznlcj
	OjK7T5afP7JufXxXttZRUMc07Wk6+qb7kk7BdBaR1t/YkLVjF2BVvJgg==
X-Received: by 2002:adf:e003:0:20b0:45e:f672:40fb with SMTP id ffacd0b85a97d-4606db97637mr8781427f8f.22.1781421280445;
        Sun, 14 Jun 2026 00:14:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm23787783f8f.36.2026.06.14.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:14:40 -0700 (PDT)
Message-ID: <6a2e54e0.892a62f1.395abf.7552@mx.google.com>
X-Google-Original-Message-ID: <ai5U3pZYrRQ6eBBr@Ansuel-XPS.>
Date: Sun, 14 Jun 2026 09:14:38 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Wayen.Yan" <win847@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/airoha: Fix FIELD_PREP using wrong mask
 for sensor interval
References: <6a2df293.6b2684af.263065.81b4@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2df293.6b2684af.263065.81b4@mx.google.com>

On Sun, Jun 14, 2026 at 08:14:28AM +0800, Wayen.Yan wrote:
> In airoha_thermal_setup_monitor(), the TEMPMONCTL2 register is
> programmed with:
> 
>   writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
>          FIELD_PREP(EN7581_FILT_INTERVAL, 379), ...)
> 
> Both FIELD_PREP calls target FILT_INTERVAL (GENMASK(25,16)), so the
> second one overwrites the first. The sensor interval field
> SEN_INTERVAL (GENMASK(9,0)) is never written and remains zero.
> 
> The comment above states: "filt interval is 1 * 52.715us, sen interval
> is 379 * 52.715us", confirming the second value should go into
> SEN_INTERVAL. This matches the Mediatek auxadc_thermal.c reference
> implementation which correctly writes FILTER_INTERVAL and
> SENSOR_INTERVAL to their respective non-overlapping bit fields.
> 
> Actual effect: FILT=379 (should be 1), SEN=0 (should be 379).
> The filter interval runs 379x too long and the sensor sampling
> interval is uninitialized, causing incorrect thermal monitoring timing.
> 
> Fix by replacing the second FIELD_PREP's mask from FILT_INTERVAL to
> SEN_INTERVAL.
> 
> Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
> Signed-off-by: Wayen <win847@gmail.com>
> ---
>  drivers/thermal/airoha_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index b9fd6bfc88..e8a33234e0 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -403,7 +403,7 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
>  	 * sen interval is 379 * 52.715us = 19.97ms
>  	 */
>  	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
> -	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
> +	       FIELD_PREP(EN7581_SEN_INTERVAL, 379),
>  	       priv->base + EN7581_TEMPMONCTL2);
>  
>  	/* AHB poll is set to 146 * 68.64 = 10.02us */
> -- 
> 2.51.0
> 
>

Hi I already submitted the same patch in the AN7583 series. Can you review
that patch so we can try to push this fix? 

-- 
	Ansuel
