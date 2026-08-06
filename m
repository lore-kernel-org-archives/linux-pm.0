Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA5392837
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996466; cv=none; b=m6pbWnIufd/Pq7bAhlHhpTGBEPx3PadjP3jlolk6Nkd3G+simFX71j7m1EtwazEz+bCJbsqALoGL3g/isXjlx3AaSB92qjnfRvFPHkmCK/rHLZnX+BkOshtHnZXtyFQ+Sbcycamp8lxA9LfDyaO4g8N1rtwEsDS4NKqDpq3S9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996466; c=relaxed/simple;
	bh=eZVbKbJlRy6iKFYcyypMSZExqhzl7Fd9PRmhKUenaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaZEbjZUm2pSilvPatuAN9yXDp33MDFQfHgIcpKH+YViF3uTU1w0Xm2Ay/j2OlSSPIYF+IXkqKYcBGY7Qa/O0zGnlTPeG6SP6SL57lqxOO6CgZ6G3eL44p1WsD6XwlFJ1yVKpVJao6T4rGLmX/N0r1cHL0wcroJgwH7qxZGY2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlgsYWs6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlgsYWs6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so421836a12.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785996462; x=1786601262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmocOSK9hgh5E+Lsrtu82Yd/W9gDMariJqutM9LyXaQ=;
        b=QlgsYWs6s0ab8MKlwfxCcXX30Fh5L+cmDaJlU+VRyqVSnfcDnxC1R0Wy/m24okJs31
         jtEkTQx4tOF0FlBjkDnbrlj8ezjtSqURQUvJXpq4Ejmxz6BdKwDNZ0ckkg3yxyy2xYuR
         78M34W8J0iKyFRv0f6U/YLysXqh6RD5ZbOXTQ1GDTEMqcYOTYBdX/A0bzHg8VffdFCVp
         2pFe4vntR4Yg6unzQ/HTs4073t7KGTespfdZ6TsUZHexCjbkkntCuTtdVmZHs7UNzrOf
         196Re2O0ZQbPE69280+DU2DEoSDz9bd1yXpjnfVhkxFc2KQ8BJrbnvRlI4IohYx+mPfM
         77gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996462; x=1786601262;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmocOSK9hgh5E+Lsrtu82Yd/W9gDMariJqutM9LyXaQ=;
        b=W3iz8iS+vrEToY3yBospBvFrAgzI6a+iRdwBk+YdOYwNPzW3cSEp+JlI63P0QNCzvu
         gutsDpftzHUtA9CL2nPm8R8mdijqUcigVjTm8uCykaYCDqph5h/TLKvuy9gWlLsnShkl
         fqh88bgmeBsG0G5NKwmNa99YBpjGSRoIbZbxozNsVLqDrKEibAa7JkqViWRr5lPttZn9
         qB5v18il7fMmWf+qmXgOCTlNbgYQNZY7GTaYAtzkI4apqfPqnzjPYLYuCb8bgq0co30B
         FPRWvjZnzXlr54wvvBysVNg6v+8j3JxGqFA76mK4Ssk2ltZdngGO3LctK0pihAoaroXg
         qhMA==
X-Forwarded-Encrypted: i=1; AHgh+RoxqOC2b7zh3WZQlt4UlBMNfEmokcpyM8+fVxcp0IbHS4vcDBhtue1BYUpFXLD+xxidSRwnL2xfxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/u9IeCwO3/wvjF81t6pmfsIC5fzmEiyl/v1hAs2NUNJUkcBGs
	2dKThAONMBJjmZ4ho7cVlGUG3V7ukUA28ZWBVlwVy0EvOHF6xThEC939dfqBesHgqeU=
X-Gm-Gg: AR+sD130Kn4kiRYEC1R/zCzmk4256vzy1r2N59KgNua0o0pCaHIX4l25P6TLV5pcVwP
	Gcj24cH627R56p6DiN+zwAGwciLVI3+8nIz42zu1JaDqOno02kHHFYV1BDvMfkePK7EK2fSIFEQ
	nyQsfo1B/jgI/nZG68t7euF8iwYnL5781z26/fUwoEql4vdfHm7P0E8MN3SZChwZcI1nYa/GTi0
	lPud0wNYq9mYa3Bhno6XrtK3FrZBK9m7hfAceY9gItS2NcCuBwxTar965XBYicpgZKsHbdmsM+n
	ChVwO00RrxGlfbJJ30+6K8lWhJVC432/ETumsKxLOZohKPtlRXBTKrFINoOMJ+QpT2pQ5VWk5e+
	DZRX6M+HwJVIUuQXUNIU+5peXEhPXTcJscygMrKL0QC6L/5Ibpaxda8W5tgbiVJBUtFhGycabFM
	kcyBaiObWvipO3nokf3nt4lEx+28j+x6rmAjGMV0FnHPEs9YMKFcrjd2kFtq3G
X-Received: by 2002:a05:6a21:178a:b0:3bf:a517:cdcd with SMTP id adf61e73a8af0-3cb9c1a3bb4mr5836488637.12.1785996462270;
        Wed, 05 Aug 2026 23:07:42 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca908068sm20402627c88.12.2026.08.05.23.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:07:41 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:37:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, 
	Fabio Estevam <festevam@gmail.com>, Anson Huang <b20788@freescale.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6q: fix out-of-bounds write when probed more
 than once
Message-ID: <f3oyofuwnnygmazuduufjvvafqpgqxfnvnf6dcxfc63z2ozz6o@vxk7bozr2ctl>
References: <20260806050239.90188-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806050239.90188-1-kmehltretter@gmail.com>

On 06-08-26, 07:02, Karl Mehltretter wrote:
> imx6_soc_volt is allocated fresh on every probe, sized to the number of
> ARM OPPs:
> 
> 	imx6_soc_volt = devm_kcalloc(cpu_dev, num, sizeof(*imx6_soc_volt),
> 				     GFP_KERNEL);
> 
> but it is filled through soc_opp_count, which has static storage and is
> never reset. A second bind after an unbind keeps indexing from where the
> first one stopped, and writes past the end of the new array.
> 
> Unbinding and rebinding the driver on qemu's mcimx6ul-evk, under KASAN:
> 
>   BUG: KASAN: slab-out-of-bounds in imx6q_cpufreq_probe+0x3b0/0xa34
>   Write of size 4 at addr c5e90480 by task binder/73
>    imx6q_cpufreq_probe from platform_probe+0x88/0xe4
>    platform_probe from really_probe+0x108/0x384
>    bind_store from kernfs_fop_write_iter+0x1b4/0x28c
> 
> The write lands one u32 past the end of the allocation.
> 
> soc_opp_count is only read a few lines below the loop that fills it, so it
> never needed static storage. Make it a local.
> 
> Fixes: b4573d1d657a ("cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
