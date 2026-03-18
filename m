Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A1340A6C
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773807972; cv=none; b=TkVm79Ocr3L4TBmLR2ISHl2Su0HgK1ufmpwFqIZqG0bBdXGmM3j4l80DdYh4qXXrYfwoJjoBd6gMLi7sPvNt+GCQG/v0v+Dke2muhIpc7lcQ9Op37HB1yn2Z52OmTY/Ys53xX0q1vSAu/XeA7/c1t7AM+sr3NmcKF9KYl2b0noE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773807972; c=relaxed/simple;
	bh=ao9pSc5sCw1GKQta3ufNSBs2/9w6iO/iOUzMVs1r/cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWOBsq2dvS2qbQ/9NV8eSS1tqW32vuOZAR3LSnN80Ab0ZCASxKm9NxU99Jubm4rout4e5EG29LxBhQ58fs9VTXIQg6s5UmjwMlrC8vJnFmDrEEplHCsAE0CosIWMaFPbqyCWSHYPgoRQ039s6em1cXmo+h04oG4Q1NUpJBAKXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjMVcqtI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjMVcqtI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b04d051664so31701545ad.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 21:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773807969; x=1774412769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mS6wQL3flAzxGUNqpCFuEf3Disb75RCg1Pcn89gYA7Y=;
        b=kjMVcqtIaUZpb1hqixdNEhuHaA/V+FtH3DPnNiWf5RE1pQn+XkkgLyEyi0aWuOHhhM
         8JKscMu2+ifSBrmaWr4NnZPkM2MWTUm/eqyQlrZEr2oqyjxYh/H/cvGxpV2xLzEQ35ZH
         /CKRd81AQxTNMFpCGArIUBRkWNl5JDwIBRRtoEPtuDS+p39sipdLod15MH6426ytRH3z
         1rbUJUc4qAhxPLyS4oesKFYXh6H4VzW9GNmtAHrsUd5YLY2mkpw106SsEGN4hIX+gv/f
         2evbuOZCMDPuiEs5nFptfZW5ua4fV6m+UKzFoRiVyZhyjAi1MZ9B1Y6ETKGqiUa2j3uW
         ZnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773807969; x=1774412769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS6wQL3flAzxGUNqpCFuEf3Disb75RCg1Pcn89gYA7Y=;
        b=m3bulgiKAmjY+UIT/FzNtMqX4lMlVy7UDLROc6aIFMYDG0A1T+xuoQLidVpr5O4/qz
         +6yNB7yMM2oJESD0O928ljnGtR4xQy3aMf6tjsIF4zRR1Tz3PO0xvT7reeBhDSt2tUW1
         6budS2DwFdN84hPeWYRKj69UglSi0kQDlfM3y4ntYLvDQosMyeHTlFCfk9VrT/1oCut6
         BF8FMALEpK0Tp6auRIZRCiVHAV7ADq3fw1f4N3d+0xx3/YYkqrCiGabQW25d+aThxSJZ
         tO9qc2EqM66W095zTsgc46TDIRL9YTJKGk6xILn31s0vZPTNLBuRyMIzZxED2Gt4Il30
         JqOg==
X-Forwarded-Encrypted: i=1; AJvYcCXkdbWxhDQwk8PD3pShZ+0PJLBQyDkzxNkkYcqVj/cQGONE5aunNt/x4EPd6L5Io9MKwLynq+aF9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTw3/zYnyC9lR2f+Y8EN3G+CHC6bKtJ/weaz+Afoo+2vn27XvC
	ywEF+ipWu6ITZnI73faD1vw4iHjhZUVoGFMptHox3pJQy4J+LaNY026g
X-Gm-Gg: ATEYQzypxZIJjaFVG0eNfoYGH/uVBofX0DdHIvZcbHPrYH7wA5rpvc3Yp8spbhZ/cpP
	XYGKLwMCfJm2nvPP+QHYH8+uWTtf4tGxxXKPS5aovOJ5SvffyawYIHkPluO+dFuEC2qO/rVGpN0
	dJ1IPbZBVyNqKOB1NTLxlWUsqw89z2CJk5gi8EPCsEe0Co8AtR/iAp7XFoqR0PaNCrNYApkocsm
	da5Spy2/gsMGRdbc7VItwanxQSlXmcmNcvRrnetWNpghsagIU2WGk16s13PzXAE0FkuLbz2Sy9A
	va3oWRSNcFXUsWy4CXDh9jP0C10AsrhLjZ0YvWeKhtQtaimfjDVCi6/ekzLD1mTk9JhCu0NmjmH
	RWZDOD2KseiB8ZxpcNkD7QQcB0zaZzR2Ezf+wxpPBHrjLLP33FzNNC2yBELD4zgNRJsFcORTgBt
	rKlMgBvXbjhcrjAaaOAcxMACkL3XcW7aTKlXI=
X-Received: by 2002:a17:903:2c06:b0:2b0:5fbe:12ff with SMTP id d9443c01a7336-2b06e3d3502mr21630435ad.30.1773807969311;
        Tue, 17 Mar 2026 21:26:09 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:1959:174c:5a7c:eeda])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e41927bsm13325195ad.10.2026.03.17.21.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:26:08 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:26:04 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc
Subject: Re: [PATCH] interconnect: debugfs: fix devm_kstrdup and kfree
 mismatch
Message-ID: <abopXJPF-UD7YsV1@google.com>
References: <20260318024815.7655-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318024815.7655-1-hanguidong02@gmail.com>

On Wed, Mar 18, 2026 at 10:48:15AM +0800, Gui-Dong Han wrote:
> debugfs_write_file_str() uses standard kfree() to release old strings.
> Initializing src_node and dst_node with devm_kstrdup() creates a memory
> management mismatch. If a user writes to these debugfs nodes, the
> devm-allocated memory is freed via kfree(), leaving a dangling pointer
> in the device resource list that can lead to a double free.
> 
> Fix this by using standard kstrdup() instead. Since the interconnect
> subsystem is strictly built-in and cannot be unloaded as a module, there
> is no exit path requiring manual cleanup of these strings. The error
> handling path is also simplified by taking advantage of the fact that
> kfree(NULL) is a safe no-op.
> 
> Fixes: 8cc27f5c6dd1 ("interconnect: debugfs: initialize src_node and dst_node to empty strings")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

LGTM. Thanks for the patch.

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> I noticed this memory management mismatch while working on similar
> debugfs string initialization fixes [1] recently.
> 
> [1] https://lore.kernel.org/driver-core/20260317185920.43387-1-hanguidong02@gmail.com/
> ---
>  drivers/interconnect/debugfs-client.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
> index 5107bff53173..08df9188ef94 100644
> --- a/drivers/interconnect/debugfs-client.c
> +++ b/drivers/interconnect/debugfs-client.c
> @@ -150,10 +150,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
>  		return ret;
>  	}
>  
> -	src_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
> -	dst_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
> -	if (!src_node || !dst_node)
> +	src_node = kstrdup("", GFP_KERNEL);
> +	dst_node = kstrdup("", GFP_KERNEL);
> +	if (!src_node || !dst_node) {
> +		kfree(dst_node);
> +		kfree(src_node);
>  		return -ENOMEM;
> +	}
>  
>  	client_dir = debugfs_create_dir("test_client", icc_dir);
>  
> -- 
> 2.43.0
> 
