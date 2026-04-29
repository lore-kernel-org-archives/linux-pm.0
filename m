Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6A3A874D
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499419; cv=none; b=IZua5oc3ZIxaXfFSVWtgMGiFB0ms/pgdjFtz3efp1cGHciTUeXQgaom1kshaL8iZWdpeclXxdhqCw0u3q8kJ/KRN+qXKRMuFYv974YKi+4ANoZUk6s85SnCv5i7y+sxJvA40Qr/2RTkZhJ4rp5tR1FEehp6+isd6gWgubPpDmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499419; c=relaxed/simple;
	bh=lQPMFV3UBniNE5TPtLxJbCY73NJAe97giEAIZDnA5Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idUztw4e/9AVdcgR1AJ3Zi9WtVM1yXCmxoObsHQRIANMbwik8yFDPFj7j8LovlnpRavnshNK8ooMmZoyu/pyeh8mksCYfsYV1iwpUUengVTzbI/ZpwxBWmJlbVmI3hmlQeXIroTADM6931Tm3JmViUArifW+ErK9GNfa6U3GdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy7rgT2/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy7rgT2/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so67452a12.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777499416; x=1778104216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7A0oyBdV2oVNxwK3m6aqaDPWQuh9oviLJlPC2BstVY=;
        b=Oy7rgT2/UPK9QbLkBNoTfq5nqZmVg+okMUBOf2x9OGx+n75T69G36Tp1VZmVcMxG5M
         Lm9GRn7gkI811rijZ/Y5hHb9fFexVECRMmDlfbU74hw5yFS8L2uU/Nbjbx+CIUPKOsTh
         scAxRr7Zgj4GvGj85sj1T/M8E1ykBRiZ/K2yiVR3ApeNu9K+mQbm5cNTd3ajh4wblbxR
         MgCwugIiXuyb+HxgcF7tEb5WfxtdON485vNF7B2TeV5PqAMq08Oj9S9IXk+ky8lqM01L
         c5vi/hZn3TOwfI+HqM7Y8WfMxunue3SJqGnGYWd/j5OXAmDU2vjriShGNMpTZUjEryuf
         mgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777499416; x=1778104216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7A0oyBdV2oVNxwK3m6aqaDPWQuh9oviLJlPC2BstVY=;
        b=coGVnGNBkJS1c0O17YA84wnI/4LOjlpIWa+MctomlbT1Vrr3Z3HmC++ndDHxKdrHNc
         etpl429yoVanWnRAclBBepBX2jbuX9OnvxFF3kJMWgP8dwDu94kSopNvZq/OqqbmaZpA
         XLm55ysKfC/1ZCmSFcWbWBfF6Q6o3gS+VRVO0Sjg2Gme0F5IwcPRELaju24VL2tL4jJf
         e/zghK4SGzCoUQr2Jq3ofmMYDKCBFJEGJcyDNgYme9rpXmZGPN9buXXpE7+gOdJGdkn2
         DSCIZxbk/huOBGEtM+urP1p0jLXZqOUgR8i3JUg9NfoC0dX7WYq228htJC/0NliFS1zD
         RnMw==
X-Gm-Message-State: AOJu0YwhwPjVi5Li097hzyrQ6Gau3ND9s2nTNYTJSNBoYBSIgSrzN2BI
	JjWMdqBSXYe9rQyR++eKvqTqbBDA8HimWt3F5xVjXnMHZm61osdAN5pvR+Ac9Hud
X-Gm-Gg: AeBDieutSorN08LpsCgTRArZ138ylKxMPNBDIbiB9DXfToOD/kiAKEgixGqUE9WrMgM
	Jjf/5HTyJlCGm2rEF7M6FeYcDHtKO95JWQBVJmBLeO+8/nlrkIbMQLXex6yiPjLhE4y4egXfg5A
	rLDf7V2j0n/cBPzf/ijcVp6dUuw8QeO0YPqDRFRrKKt9VtazWViFDU96Fc7nnOtKdsfmxP6taXV
	RYDivdGL6L5OFdynWG4cVFnum1vLerP1W/O+tZIKrE6VnxGTgjCl4N+oqTsPgGPZ7McSsrMWLlt
	pXsOi1yeyyuJVHCYdgXt9u7idK/eN2g3Xg6mQ4ZhtCgvx4wWzsBNkXDA4qoXZnwRvrugh68M4wj
	YYKLrAyPpFBMfcowxGAWUEOTcl/UFQnH3oVsM0B9exS1+AwJ3l1Jf7a5YBQnzWwIRdpzeNfE9rJ
	+VIfC2hMKaue8i7jn3xEAW9/XxYEOmWec4S0adkYYQDVMhMyPA8YPwT1pvc2gp
X-Received: by 2002:a05:6a21:99a3:b0:3a0:129a:9748 with SMTP id adf61e73a8af0-3a3cf64411amr195571637.25.1777499416197;
        Wed, 29 Apr 2026 14:50:16 -0700 (PDT)
Received: from [172.30.1.27] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd64f21b4sm3016787a12.21.2026.04.29.14.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:50:15 -0700 (PDT)
Message-ID: <9c96df3d-5505-4786-8507-9493314d21a9@gmail.com>
Date: Thu, 30 Apr 2026 06:50:13 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] PM / devfreq: Optimize error return value of
 governor_show()
Content-Language: ko
To: Yaxiong Tian <tianyaxiong@kylinos.cn>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, zhanjie9@hisilicon.com,
 nm@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401032838.66168-1-tianyaxiong@kylinos.cn>
 <20260401033128.67925-1-tianyaxiong@kylinos.cn>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260401033128.67925-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-04-01 PM 12:31에 Yaxiong Tian 이(가) 쓴 글:
> When df->governor is NULL, governor_show() returns -EINVAL, which
> confuses users.
> 
> To fix this issue, return -ENOENT to indicate that no governor is
> currently set for the device.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 975f82d7a9d1..c40568d2a4dc 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1377,7 +1377,7 @@ static ssize_t governor_show(struct device *dev,
>  	struct devfreq *df = to_devfreq(dev);
>  
>  	if (!df->governor)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	return sprintf(buf, "%s\n", df->governor->name);
>  }

Hi,

Applied it. Thanks,

Chanwoo Choi
