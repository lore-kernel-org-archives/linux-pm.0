Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D93DDDDE
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391725; cv=none; b=EuXlHo68jNYVsFBjzKY7mz2zR/1Dn4+40RTs1M5vvkATgEFqs6pj5yxxmPJUg21Lyi8KnzsYZ/BXijzmQgEoOz4XkYMBTpDWg6aPZI0hkvykMexrLlBk/omjmtQ43j/LtilyfvM+QyLx8Hor9+2cke48umAgn/Er96yGixQiPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391725; c=relaxed/simple;
	bh=0L4XVH1RatRMUnOcb3s8s0yM9FwbW/K5J4m77k7HPEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvNeAIrkxVBNoY+5quhfTF253WkTE6rwBKtImaha1pndCRVHwoIyzcGJL/1dqZ4ZpSBrJexgxN4ZYvPkIc4jSzwYT53wCwlLGoZj5+8naMS3pkfswrCpf4hjdljYgNltx5RnAiGIYP5G834TYTaZuxi7P4+ya/sMJij4/Nob+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e7cym90H; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7cym90H"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso3358622eec.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792391723; x=1792996523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKi2z3pi3oxPdtq2njVr3OPRIkpSJmJ+atF7S1CFI8U=;
        b=e7cym90HTIneY8egdzDlq6uwmQcaqUcHwYKJOxiQr/SiHMlVW/CTQSN67+OaPBaT4K
         BeFO+XGXTLMjoH3wHnPu9Vh6ssOCppfNb074E8r+JEwZOGRw27Q74FlAPy3gD6Chba4q
         8Objcyfr2/EkDidq8EKJaHNQvJTKWY0e/D33ygSMBca2rgQje7oRCELYvsAuHgahRVj0
         AYV8e/X/1sqjp3DsuuwNMvRdJ2Env1EGdob41DfHm3mvzmELgkVsmorm13oRuHNctiP5
         CR7zOYINrGdLvHfZeGuTWznbeck5lBC/WkB1LoMia1PaLPN1QVNCXv8NBpuJ8VQlbxh7
         pJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792391723; x=1792996523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKi2z3pi3oxPdtq2njVr3OPRIkpSJmJ+atF7S1CFI8U=;
        b=vZZQtId6hmjsPnnvryS8o6X7Gj30WbfldNOtSLxTmBwLbNw8tcvOPz06+yWNJhAw0X
         OXbUJ2nqLGeorjgCXD24O7HmjWZVmOohkI3RYv90iiGEYQ6cDdvSKENgzdLLoLaWgrOE
         AaKar8zwPeJB8yAn79gJ0sq96X6GMUqs2V/zv69r9ZCE68TYseXVez+PI6qQH1D4uI7T
         kKpmCXfLLD/xj7oHTeLKVlpdZ5MdpIm573WCJHbLwYdcrfCORF2Rb5Nl0agJvXeqplT6
         o4btYjZTDcc5x4GYo/li5OrOUKdqKXnuEP3Xp8KrzCRJGsB0jD/9foyjJijIOaAeMzYo
         B/2A==
X-Forwarded-Encrypted: i=1; AKwUvByx+H2B9pW80bcRV8Mzf7O0MeU8kd63gNF6mkC38aV+7oE9Z7yExViwtk9hpXXdCSvZtCv6IEjmjg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVOHha4rB67JfC3lawyJKBqczplBSg+UBOYTF5iM9alOLxwnzl
	wU2qhLFHOMFX4HqZnomvSP6Ypp855u0G4hUP2iDES+JRR/cUXPsVn07Z9CEOBdQCDE9oqLNDS8r
	Um65t
X-Gm-Gg: AYBFou200dujm2p5CYaG0spjIRtjHvPU2uET+qRAlGwm2Kf7NF59IkbMsYpiFASsutl
	waShb46jPJLfFtiywctEl7ab000Dt6iyEwOTuzJNYm+EBWb66Kia/Kj/9QJEvblSCmVsu1nfr5r
	laQK4B8J0vEz0N/AqcoSwovbuIAjFoG88lMOiZsgWs8r1idHW1VT95mowChhtJRNz/JFHbkMce9
	ccS1arJtVoq7MLFawudPcgsoLO0U3rDZlCwAHDJDlskVx1i4vZCkbJFl+4W37S6MKeibKS5wI8+
	rE3pvTkkKlyK5jQUUM7wMFdFt9JIkUQaow9UHpaGhFqO9OEXJ5MiePXkCPPlpOVCxuzDOGo25x2
	FkzP8llfTYNoidk6TrrlP3BAM6lv7g+cmYZb/IDLCGynwv3dgzs34s6uP4xi8iqG+KRrOZTJZkT
	MKitUL3Vaeb43tPfi2bS202CHdrfxErfEeHX4+pbfiUyH5Kf3VnbmTb7KRfbk56P6ow4tg1haEU
	NSRa8ZXYuU=
X-Received: by 2002:a05:701b:42cb:10b0:169:b1b1:1445 with SMTP id a92af1059eb24-18512e2515fmr10313720c88.31.1792391722239;
        Sun, 18 Oct 2026 23:35:22 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm46711875eec.12.2026.10.18.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:35:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:05:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: longrun: fix typo in kernel-doc
Message-ID: <atW6JlE-pkObg9MX@vireshk-B250M-D3H>
References: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017071434.1250140-2-manuelebnerli@mailbox.org>

On 17-10-26, 09:14, Manuel Ebner wrote:
> Fix typo to fix:
> 
>   $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>   Warning: drivers/cpufreq/longrun.c:126 expecting prototype for longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  drivers/cpufreq/longrun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
