Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345341;
	b=lYOG2BdU1BZez9HM0mmE0pFcH7mhsh/oJhDtlupg8zfq8to1I6JC917jgLUPzwlcnlRn
	 +cmdZaoei0NKXMXo6yJSrgTl02K0AwUmSTPobFhw5hfKI60OYnCJt8rVsJsLGJS2An/6+
	 fZ6FK0cWhmITznmgF9KgWYd94npiLmuJV+JhmrOA2eY1nyodOxBhJ7lZ/Fc8q2w4lt2HM
	 S9TR+RlqcRxYZ1XOSYJLptcUE1VWQD/dmw2ybEis0Y+B0tXbOm4VxiCHuSOArMBl6PwsN
	 T/CdEv8kxgf/S9OsB4sEUtoTDfd+6Ne84dAREmVSMlkhhYrrXqOnazpHB/+4SCDX8kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
	b=Gyiq+3iCCrQz/PLKvYA8oK1hJA2AvCuPQdDEnPxazjIpAcQrkHwivl17t8l9bCh79p/u
	 UDFdSsCDSnUIU1pkkBwf6lz5Ous426MjyPFCsO5Xome7m1KCHrog16Asn0pz9gM71UqeV
	 lsHj2eAimD5eE1X2kzHG+XGcp7jHJJMPTnYVTOKBR9Rh5EPx7/pmra+OKNikIDgPypfuS
	 Znvz80XQYIl6I3Q856udDbSrRGwpTCOT7LqasgdMUIZcUWKvKnDoWfO997lXZhpqhpAE5
	 Srd1K4kJQy4RQQryQHhfD8kd86qG182QpdhplYHxajcX+Q1xyAhqyXqvVRY92DKIFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LUTsHQn5;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F54606A327
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 21:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F54606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=LUTsHQn5
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843b6f8e2c7so2494595a34.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1794345340; x=1794950140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
        b=LUTsHQn5ZJW8mYZW5YfwlOg7lEaXPFJhF1fj1LiLj2ZFzlW3nDis0Q1Tq9El9EWe+y
         OSqB9dXc91gk/BRCUg4mONoadinDdNRHzVJkErEfq4x3gEQR60Ykmvqt8lKVk4h/JtZ7
         Hg17odOVxyiE9w1c1tdfC+nLgHnnpSKZ+xBOK4XcDK9+RaQrhqhaRioOvyoDAOUuh8ZC
         HyFLlwZhg00EOZm7NYVPzxpIgEGhOTb1l5E2JBJzN2uJOoiFmSYdAkT5hMSiMAtMODVa
         oAPsQuw64G40MY1gPEbC6fw6NulPHzpfdv7TjQ0oQ7/BVptrMUdp1jArriJC3eGG6jxN
         NFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345340; x=1794950140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPELBkmgWuDcQIUl+1C2gUiqdih6G+ZfnSfUpv7B6os=;
        b=PDDX4vhp231cRjxsmLMtN4Hu/G+7yCBFgXh9oUek8vDKFVfJHrYEswHSOzhHjiyTeu
         r6Ygr1Ca+0rYm75ArnrCvzAc/DmebcHtUXYGHn2+OQ2AdnIC7bMNpAGPnv2UAGnTtdwG
         swbYEph27RDBiPPmMrhbcQj4v1rdLRQQtV232Vh7LFVH5Wt849qCgQHtNb5GOxZ2jsR4
         zhfK/T0/xOJj4vb7HutA2c8sjP3abqFslKaJEiPqeBFIi/WLIxQagTyFDcUOIKgzpEFW
         Uvqlm1t0LGbGZnBqmxtCb8yhhMpQqVlJMbgWwJCTBR3pheLXJf8OiexTXduqHcfZ1rNQ
         kgCA==
X-Forwarded-Encrypted: i=1; AL+hErF7/PUT+Nj4u2LGhicW7cXpMy2XxfrMa4TmBHQwgk7O2QFshMxdNcMDXOWyf3uxguh8I6F7Xdmavg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+w3VO9ORs+ZAGqOxqcvFS3NAH7J3fPCDbDcTo8JAIvOmQZZYya
	dK+Ebfqu5czrDoXHNHzAqU9CuWaLLvo+l3N75+aKtoQzIi3ekIBQmS71V1twysRttSU=
X-Gm-Gg: AYBFou2fYOERexlv6enTnmWwNYFNsKXxleI+1ZZ54z4BBwyN2G2CThaAOEsjVm9NZ5u
	nv585YCm3pXc/ze4fI6dzLkDFJ+0OHKW6l9LA9qPO3TtyJGk8l24bfKN4PJi+HLrSd4MA74CZe6
	oh53U/S3UlM3s7wfK79sha7ekV/aGYlCJWYsgogUCj3OrIgWNvWBxCH2ScVi7r1CUNz0OLTjC2h
	WvZTN3o0N/5C+8QboMDSc/c+K+BKTFPQFqvGOn/yY37aXlMzmB1Ipw9iDMzt5+KZs7k93HZffsh
	g7By9CrtkOVqW1iIZaofWKvnDCMQJzqSvG6AHWmZ4TazzDqqSJRyN8g59qRd7O1yidJz39SLz8A
	cE6MQKqUR+Fz0XWQA94gOrVMZKsHSrs1NyRa32yjyxGMhkUT3gnlkYinxluYei6oSR4nDkOG32L
	bPliQp1fjtxBMH1YTzVfEHb5Ni6yNHCEvThVya0dQq86Ql7rYe02roTdxtf63B56HOJCZUqxvsh
	QuYTVGgMnCbpQBN1DIlWv3xn3bcxdMVrH30/todXfa/sbYPhsGLiJ24NHfqjY3Gxt2SQor6qWEr
	1/5GET90m7bKlLnSagqGB1PG7GVxUQ==
X-Received: by 2002:a05:6808:c226:b0:4f0:a3f9:9f89 with SMTP id 5614622812f47-56b96ad0741mr201899b6e.18.1794345340222;
        Tue, 10 Nov 2026 13:15:40 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690573604fsm3142441b6e.9.2026.11.10.13.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:15:39 -0800 (PST)
Message-ID: <be330e7a-f37d-4347-b815-22bba165defd@riscstar.com>
Date: Tue, 10 Nov 2026 15:15:38 -0600
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
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in
 atomic context
To: Anand Moon <linux.amoon@gmail.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 12:14 AM, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
> 
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
> 
> Assisted-by: LLM
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Alex Elder <elder@riscstar.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/i2c/busses/i2c-k1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index ff32876e24d3..f4b21d7efaaf 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
>   		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
>   		       i2c->base + SPACEMIT_IRCR);
>   		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
> -		usleep_range(20, 30);
> +		spacemit_i2c_delay(i2c, 20);
>   	}
>   
>   	/* check sda again here */
> 
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9

The use_pio flag is set for atomic transfers, so spacemit_i2c_delay()
will use udelay() regardless of the delay period.

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>
