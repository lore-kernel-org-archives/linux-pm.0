Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85ED309DAF
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382390; cv=none; b=aTaigdAOKnk0IzSu98lxhcRjk0D1/xoGbxf2sGZkXJNOMD/As7HuJpagZeKiAiK55E14s6f5/02mZLcwSG9tk0Bzc/GwbUwoNbuGWBXrWwcrir0P5DHWepYXtLVY1dQSXPqO/1dXOwNSWo3L51jePrIJRRaRmD1SGZCkIQZvLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382390; c=relaxed/simple;
	bh=AhexoEk7brYe/xI71wk2EbMOxE3C1TWTrH2lxzjDfT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jk3EbVBmg6QGhNPPyhmIPjAcK9m2IKh/KDhRZzN2xN+WqBssSeIKXCaB/QjbMsoB75hFnOE9wlMMCrfg4EBj5BLdvVi/1Xpmk9vrSNkGRa4NpwKdClPmefz+wkpcn3VSctrOftnmf3wVHGOI0isSLmRJd+4d46MJ/xmFV8VgVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZj3Bf+E; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZj3Bf+E"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1268616fac.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774382385; x=1774987185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mqwpqpt85vnLl7QZ+wcSOA8++zHvCsIpbTY5IaLZsdg=;
        b=OZj3Bf+EtV1B9P42Ij3z9Ad4txUXKoOjBU55SImq5wzacDB4CjwzAKoRNncTplXnu5
         pPXj6jonK3PA9uCa6GHGkPp7Zv9l8cjeyZNjL7hCu2u6wPakCohvNwkwJib/t3Qd8X0S
         T072wgTHc2Kf0p0T5npSM3GLdnhsi7iIo20jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382385; x=1774987185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqwpqpt85vnLl7QZ+wcSOA8++zHvCsIpbTY5IaLZsdg=;
        b=d61Ys/aPD3X9Y1YdsMAg/Hg9QOdmrOWF9LhY++ZunRNW1+ERTciSb+WNR5XQpGVOEi
         7LE6opokcLchCmKmbRDwavGFI56Qw/4W2aaEzapjogt/R44Bf166RS2geTy3BbaiHqxk
         VGaPoZnghwo0LiOetWfHm3VvG77ff6thx/11+ISGlx0eHY039IuQGZHe9/E5AiM535h+
         XTxerAw7H755m+QQ1X4VfObehU0lfpztJVZDQ65QyQpILzIWcrmJ3Fge3Bwv/A5xvmem
         4JMM855XccfntekdlKhrrUfma0K0QfTR7o9aYB4okAL15iC+ePssBGvohzXYtOIMoXYP
         gbNg==
X-Forwarded-Encrypted: i=1; AJvYcCVupyS5kG3XNgv+aOvexl2bbks4QwBCEwNwXIpFSQb+TsgvjhbfYgSCBL1PN8g+/yw8GzvjrhCUKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bCgyDhGeked9TC1NqcMovx0/JzVvUrkCRfElxf4Cdm+ucC0b
	FKk6ACIL6sIUzpoQYIENXqNWAjKsZjw1sMwowoqux6ieVSVyYVblHP76fU78GF1EFJM=
X-Gm-Gg: ATEYQzylI0a3m57vmMbbRSiXfggYLpQIr2lokezqD7h8ue3KQ0dE0y6P+TIPrZojpCG
	/oF973EVSJEVwBLrxDZVu9HBZXUpUg6EiXw8iNFZ2cIIlk3tJf5lbpuimfrf025gL33nzVq57SF
	ECHPCWa2hze4fk16AqI1FWVqkxduHoyIQ7mvLZlYkbE/n+yCIrxij8JsICQTkgfpRL0SdmPmVWM
	YJEnk8mWg+IVQFCG0zVjcebuIfjJrBFkbRYnd7m86U3/Dv33ZhLIYN6roNEYLVTLchPBIRe/7kS
	NcRXmhto860urljWdR1Db9dx5NrWRvjYxUM7+73QFpq+mMp6Zh/9ImVJpfm1B4VE2Hlx6sES3yv
	M6RgP6kl3tOQSPBfFp7rLovL+jKy9ocuLaLBknN84s/WJtQOyHgzKx8Ygg8Pdf64XqPzugur20u
	pkHGahCL2jOErd9byFOTRqhdEao6Cqwh1ednU=
X-Received: by 2002:a05:6870:fbaa:b0:417:565d:e3e with SMTP id 586e51a60fabf-41ca6ce4dc7mr543503fac.1.1774382385287;
        Tue, 24 Mar 2026 12:59:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c976ce5b4sm2144028fac.6.2026.03.24.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:59:44 -0700 (PDT)
Message-ID: <1c76b560-c40f-4069-b056-c4addc33f470@linuxfoundation.org>
Date: Tue, 24 Mar 2026 13:59:43 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] cpupower-frequency-set.1: trim trailing whitespace
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260324013543.4776-1-io@r-ricci.it>
 <20260324013543.4776-2-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260324013543.4776-2-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 19:35, Roberto Ricci wrote:
> Remove useless spaces at the end of some lines in cpupower-frequency-set.1.

Why are the spaces useless and what happens if you don't
remove them?

> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   .../cpupower/man/cpupower-frequency-set.1     | 42 +++++++++----------
>   1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-frequency-set.1 b/tools/power/cpupower/man/cpupower-frequency-set.1
> index b50570221a5b..fded317c8c51 100644
> --- a/tools/power/cpupower/man/cpupower-frequency-set.1
> +++ b/tools/power/cpupower/man/cpupower-frequency-set.1
> @@ -1,52 +1,52 @@
>   .TH "CPUPOWER\-FREQUENCY\-SET" "1" "0.1" "" "cpupower Manual"
>   .SH "NAME"
> -.LP
> +.LP

thanks,
-- Shuah
