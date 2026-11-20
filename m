Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203944;
	b=2XLS4Jkn52Gqcgfl21qZPPK2MbuRSxnR+0ZzVcBH3UoSWuoVeSlrp4lkOLz2VYuMY3YP
	 abRBisfTgn4RIWSLYGCYB5IeJI9E+irr03jGnHYp57xingKarkV1FPWU+sPX5M3bwLHSm
	 3+ao6wBVkBzMUbR7K+xK88kqH53fu0izdDoqUULJJvTxpsn40AkY6ttYP6Mhxsg7WNYL5
	 XCiKytgWL3z4qx/CDoQftGcIjHIwNvGn6DgC1jPOzb2oCJiafRDstdZrAl4Lo0yu7mv8e
	 ABU7Vf4rmpqAZt7cSv8fDuZWZ3TmNBRvjZmjxLtIrT86d9D0zmgx5rwsuqDD/fGCwVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7wMTuKH1PWyZv3stWiDD0fMSi5lmAyg9c1ZgUZ+jKJI=;
	b=wZ+jILTvppGYEKD7VTbmMLykGS36K/PFp9Qkc0t0R3/Dj6lkwUaKbl8WfrAucuI0Ih62
	 iZoDMdEFUBrG5DefpEUbEleiCnf+yzYB5bcdqFdTM3SrcHqeeEcLmD7r387kTfQOkuLri
	 DO/+7eu09zgTlzGRKDB296MaEdB8MAKpQzTNN5XSnr+19y6lOyLaEYGyCBYnMA6+8Ifas
	 kOQX2x+DrCf7L9vjKxOZbgyCW+k+HLUYYxoFlnRmCQ9Mridb4j8n3JwE3IHxUEjGw8hvy
	 YFS9y4UjehocgfkfB7s7XGwZ5l3QoEewHkK1IiEeczdB0+sdOehdRy9HbEd8hN/v+fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Nm2ofd39;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB3606A6F4
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFEB3606A6F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Nm2ofd39
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6df5e315bd1so1117078eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795203941; x=1795808741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wMTuKH1PWyZv3stWiDD0fMSi5lmAyg9c1ZgUZ+jKJI=;
        b=Nm2ofd39x/K+7JDjUcWCmF7TxVGxpGa6INhvZBg8U2ZRx/IYA6/kq9nYHRuQ3fiUmr
         lVWQLG6GZ8QexAYTWhLVvVQHXgRmVKAnpquUeu/UtXw9s0xjyClfQeiD4aye1wEC+QVu
         jqfXAsjAmGMoKNoVuIeUPlyhDPRW21mVlwm50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203941; x=1795808741;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wMTuKH1PWyZv3stWiDD0fMSi5lmAyg9c1ZgUZ+jKJI=;
        b=IXz5mmuHLgqvVUn8igiDMzcUiKrnNIZYdwy2bFFOao5Ni8U4hH3K//qjh5+Sr/S63R
         V41zonCjfYlG0Hm1PzyZgr4gvJVTl9txrdqgfxCfCMpTZ7rySRMoo67cKmorP0guzFqU
         zgsX0ahVgHh9kW7ds/LkgSNO+0ljswnQ+rNNZlfIZZc9ghdfVERBW1CT5WajuSREls2V
         lHEq0dYcGF4KW+TKeEqhhPmG+OrZrHF2SVJcFE8OMR1gXZfAtcjlU4pCauF+VbmRhoru
         CtmJoYSBXnqL4qXl5/BGfEMY+IR8ekSlbD2hIgxo981qP8LOniqAxhS7EEZRbehiePma
         3Dcw==
X-Forwarded-Encrypted: i=1; AL+hErHjiwrcsHK7Gt2a4mgOfuswmyo/dWUq4QX1Xpge3G7YrBuLlnjwhEazeziMyGcvx3UY6nY9xvofcw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8l6+J7PVrvsNEGejMkKa7XKIz1+xfe6+7q3jTIDGQ+OOCVYi9r
	eF+xvhWHiMPwytjGqh3j9birhTnvFlrDp4tdjGMmsCckMZ4LTLM5xznW1rsNk/aXjpg=
X-Gm-Gg: AYBFou00SOA3Ja6wNnpnNewC2MfNLw/I5CDHoAIfscQZMTLneQtM9fRl/awmD41weHP
	A9l2X4kISTqy1RYIzmK75Zwir3T7qcxC7s/JVAsUQ19puNAkwsvqBQBE2YfdI0ELAoR8v5JVIgI
	GURNyuTFO9q/bEl+iBF201BPR5l91aJkl8quGfLpuYteeQ36MU4JJrRvMMonWNQHLFnpPS8vsrv
	JPsZxN+J4DyAq+BsPdHqbFo4LAzyCSBP+QPX4xlB/aHvWdOVr7jae/T+gqlmm1cdH2RnadDtqL2
	pCvZuowDsffpzvLhIPwPHU4LX8Oh46zY9GbOFYFsaa3gF+TQMFLWLi2T+t3oumlHi/QYJJQeQZH
	2wu2EcRfGstlQWjfIIqwoPRb60Aeu6BSvM6O4Fvz+ewg369KwH+hvJbfZihvI0AlqcEq+m1sD5c
	iLQYWGyqmZnZL4NYfiDTgIU0SSvvItSTna/BuMwRZO5m4E1Q+jyX3PlzbTEiaqK7xtDL3dSTaMb
	vteGeu9yupTUBdtaA3cRX+3tpcrd9DSABm3LgHhT2aRJ2AhD/WwupYORJOcrsRhauYAiABsM90D
	//p46k+S5cCrOl86PK4dao2zvxeJzAAc78mq31k=
X-Received: by 2002:a05:6820:3398:20b0:716:f44b:2dd8 with SMTP id 006d021491bc7-71b394d87bcmr2774395eaf.31.1795203940676;
        Fri, 20 Nov 2026 11:45:40 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm2542220eaf.4.2026.11.20.11.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:45:40 -0800 (PST)
Message-ID: <6ef36a84-b46b-40ac-bfc3-edffbeb8b8f4@linuxfoundation.org>
Date: Fri, 20 Nov 2026 12:45:37 -0700
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Propagate errors from child powercap zones
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, trenn@suse.com
Cc: shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261120062134.98489-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261120062134.98489-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 23:21, Zhu Jun wrote:
> powercap_walk_zones() returns a callback error for the current zone but
> discards errors from recursive calls. A callback that fails on a child
> zone therefore does not stop the walk and the caller receives success.
> 
> Propagate the recursive return value so callback errors have the same
> meaning at every level of the hierarchy.

Why is this change necessary? Does this change by itself do
what you are intended it do?

> 
> Fixes: c2294c1496b7 ("cpupower: Introduce powercap intel-rapl library and powercap-info command")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/power/cpupower/lib/powercap.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e55ef..76ca392161e6 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -300,8 +300,11 @@ int powercap_walk_zones(struct powercap_zone *zone,
>   		return ret;
>   
>   	for (i = 0; i < POWERCAP_MAX_CHILD_ZONES; i++) {
> -		if (zone->children[i] != NULL)
> -			powercap_walk_zones(zone->children[i], f);
> +		if (zone->children[i]) {
> +			ret = powercap_walk_zones(zone->children[i], f);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   	return 0;
>   }
> 
> 

thanks,
-- Shuah
