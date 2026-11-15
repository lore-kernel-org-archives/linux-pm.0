Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778152;
	b=ndnP95UukYdpTcj+X+DPDUXSPfwjzlCsZzii1Wt80szuifpEk7IySzb6itbtlwv7+lZ8
	 n/FiOm0EQFAFDzrTdF1sTR7O4/PxmrcL+/EeVtDwKDB1yJxz2oZkI3lFG0SvE4X7xDqlX
	 jJMQtYih94LSki2VYXGpfKUbB2WUHFzK6B7vTclubrCx4dQEte4wIQEzGHtwTlvULvDsO
	 VEWI4A5tdbeBs2irq+ZsgwWq/2dBRZ+Jc1Nxd7cgLVygu7a8ElHM0FE2kJVKQMBCbUrcV
	 d7VSE8757tLXKmSwWrmputO8adCpthIsP3C+yNFirQwh7U8QZngkj7Am77mG+j/I9mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0KMb5NMrKDFmX8tPScWHInfJLWZ+dDIbMJtLLrwP3Jo=;
	b=FCV2rUh+iIQ+vbpz7K1qNiPS89u428dih5XVzW6Tw0gx7MrkYt3q1kmtz1YoKHW27Fow
	 6mKSSDqMMQhaXOqog9PX29uMwDU1jNeVJg1c3qJwZmR0nMMcWW85uYUhg1WrDjxzfdy3W
	 WzbYwnT4DnRNMsWVA3pRxO4zveypNX6Ky8SRVNucRMRuygw/WEuxycOBBdowuHZzrqzcx
	 9Je4Gke1vSmPMXBi35ZtJAOiaMAQbPWPw1R8sM04+VlqeCppE3py88NZ9RLPO6EEXs22Z
	 wPnV6GT9RrwzWeGzWO/nVLkNey1RKushPLXcHGbQ17p9Zgd4Il8pYevrSl855vqkojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIOlbVLW;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD2606A336
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95AD2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIOlbVLW
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2898559a91.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794778151; x=1795382951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KMb5NMrKDFmX8tPScWHInfJLWZ+dDIbMJtLLrwP3Jo=;
        b=lIOlbVLW5uuuNr4X3b2qYsZRqyDUPplekMFVEq04kUcDGVTlYC5c/p2vlUSAnglBSj
         S/spiNFJw5jKqRXh7e7Cv6UuneoxdAxVxFYOkm12eN63ZcU8qmktbPtW6q32MRj3lhp1
         HdThnkNABJTVxmsgbt+oFQV1zFvK9bqk3H/EGY9hL0TqRfHvc1Pd0E9abpm2zwSBCSSe
         UlAsj3aUC2qH5oc0S7+uFa1JrDnIbG/Zs20cij7aSmSuXMhCy+q3KrmDAyVFcuj2miEy
         Srkc/QrodMGaX5Fe1sRTgh0pWdjgAFfygWuCxZDgB6014NE8XNiFCqw+ML+mAgAu/Ig7
         AAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794778151; x=1795382951;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KMb5NMrKDFmX8tPScWHInfJLWZ+dDIbMJtLLrwP3Jo=;
        b=YaR6Pm9trH96iwfpclX8W9Np7yKVwYhvU2f3a1niID/MhhmLD63vTQJuJu032yEYmM
         GWviKlC2HZppnQvfNzDF165X7rrEkAeIfqfGJqH4Blz43HcP/YIWOh0WmqSdnJpEZM+U
         piNuGYFDoskmEGflerat4oV4CX9yCbAg3fGIDxCFzMmmU6qVExQYC5qVCHOTragTKZYO
         FuuZLXhK6PfEI6HTczN921FcFeJc8nHGaLnWckM0lk7hUNALnLgUYZtMXZL4a8ZIfUS+
         2K9p7VECxsMIVq2LVsHkd/n4Np6otp4SrOndzKhk9TYbExor3iQSvrDm1WAUIWcfZHwK
         gTHA==
X-Forwarded-Encrypted: i=1; AL+hErG7+9p8S4DsnEL7VT1VhyPTsBV3GZjtZfG/63URqAAHK9drthKcSbvxUsQDxo2tijh5dGLmmeM5zg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YV6HCkuLdSD+ldrFI48X3b1WYAJj8pthr/6GsSfmkA/w8wuE+
	FoWdCy7nTTDNm/vfe7Aeuo/1TuHXLKo47DrOyZ9/GPsztGlTXDkXxb98
X-Gm-Gg: AYBFou3jjy+kHggKaC1/Ld4gXmPo2/huR6qJnLZZAa7NsgTN/bvU6DpSjlKXDh6xPuB
	/5+PXDNgigdPkwYGbdB2bsBFfJfUfbn50N4wqFksuBtAG4j9z4wKRgJA96yD6omFu67chEaGvRw
	/C/ZBYhaqyGymeRVbeKT1HZ4X6NDu5yNHtFi+Og6EzYmcDyn/MkLT8qZn8JTXfHBl370EwJkPMs
	BCWfPPNu+J3Um7di/7OcQZn/Uv48PL0ymgYtUzSwj0nbxwOobMPD4jutLTi/H77ePphhMgWqh2u
	jo3UkQ67ioM73yIuQV1atH/kpuzKI2xUaFypRdJwbkrgqv8ALG9QMbR0aaFGUNkHzoDDKEDKJcb
	c8N06Wu221FqIYa2OtU+hrEImLnuA/zd8nHdKMk48ymt/LVWhkv39E1uVk5x2tzO2KS4aSCKusR
	GPEdHmiRT6LVgn+sZimoPCB9G1l9rcq055DxLWeJSIA0Tot9XGDg1Cr54e4o5NnfkXw2TuYqE+T
	bbvJz+tukDt5HsXqRUHdCeeN7mHnIEafjvrOyOjoARnFcOl5XOkT3zF7aQFJ2HgSZvkKNbiIZW+
	FwapTJSniqmmS7Wxm29J8H58b1tCb/BaAGIQChAx1+BQQ4hxWJyrYR+xeEOOIdnCfc+i
X-Received: by 2002:a17:90b:2d85:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3b1b0ca53bdmr8704447a91.37.1794778150825;
        Sun, 15 Nov 2026 13:29:10 -0800 (PST)
Received: from [192.168.35.214] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm18846067a91.9.2026.11.15.13.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 13:29:10 -0800 (PST)
Message-ID: <d8ba1575-f5b3-4794-8b63-f139897074e0@gmail.com>
Date: Mon, 16 Nov 2026 06:29:07 +0900
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
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2] PM / devfreq: userspace: Fix memory leak in
 userspace_init()
Content-Language: ko
To: Malaya Kumar Rout <malayarout91@gmail.com>, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, kant@allwinnertech.com
Cc: skhan@linuxfoundation.org, me@brighamcampbell.com,
 linux-kernel@vger.kernel.org
References: <511c7f13-3344-44bf-a960-044fc2401789@hisilicon.com>
 <20260729133523.357383-1-malayarout91@gmail.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20260729133523.357383-1-malayarout91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 10:35 PM, Malaya Kumar Rout wrote:
> Fix a memory leak in the userspace_init() function where allocated
> memory is not freed when sysfs_create_group() fails.
> 
> When sysfs_create_group() fails, the function returns without freeing
> the memory allocated for 'data', leading to a memory leak. This patch
> adds proper error handling to free the allocated memory and reset
> governor_data to NULL on failure.
> 
> v2:
> - Removed redundant 'out:' goto label and returned -ENOMEM directly
>   on allocation failure.
> 
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  drivers/devfreq/governor_userspace.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..8211aadb81f0 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -89,15 +89,18 @@ static int userspace_init(struct devfreq *devfreq)
>  	int err = 0;
>  	struct userspace_data *data = kzalloc_obj(struct userspace_data);
>  
> -	if (!data) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!data)
> +		return -ENOMEM;
> +
>  	data->valid = false;
>  	devfreq->governor_data = data;
>  
>  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> -out:
> +	if (err) {
> +		kfree(data);
> +		devfreq->governor_data = NULL;
> +	}
> +
>  	return err;
>  }
>  

Applied it.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
