Return-Path: <SRS0=qrRL=VT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF3C76188
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 05:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D80219BE
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 05:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6TtVKr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGVFnr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:43:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40729 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGVFnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 01:43:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so16811550pfp.7
        for <linux-pm@vger.kernel.org>; Sun, 21 Jul 2019 22:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCQRh8f7Am9Pu3Zrt8ca1tiYCAmgZh8iO4K+Ia+HeDY=;
        b=R6TtVKr6FzRXGzpuk4JA7iix7Rqg/Vj3Jml5vRJxELGIZUOhzNNDE+ORehUvK5+iLl
         34dKdx5dh9Ut0OilqkR3jl7qf3z7nuSnyrxQ8X2g2ylzFyyNI4ARLewsc9mz0zxcRZQM
         FTDztbAtB5f93ji0gTdc2ocUGsq7LyRPCPmvutWPqOMLAk10C9bb2DEfH7e6ues1cx7A
         zDuafqss/khT0E8w7sdPyVOIhJjuI+SmronKkfeqQcxZVefr3Uqhk0RE67MOLgJelL1X
         fa3xSvPr/Ax34q1v2Ns7ZtFNrwZbgdS8LWKdoOy07EMDUdiRuPJWE7SPLKUTucmknMOV
         ZIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCQRh8f7Am9Pu3Zrt8ca1tiYCAmgZh8iO4K+Ia+HeDY=;
        b=QDTdaTFlGjUjDEZD3W0aQwzogYFjfTvIou38V7MfoH2cjTfG8cHsVIdgGycU4hIWtn
         P1MBedxmZU6OWHBU7F3pAG3Zw8C36D9dNYCTobayIv/u2lwcp9zdE9Suf8wUoPJN4MzO
         jOdc2PdC9HsBeIzrvpq3VqGN/7Kn1hXA1pOCo4j92vyy1ljPiK1RazSiGpNtKn+3oFu9
         4ZbeauUto/ai9eUgHLucr0usZf9q+uzKL+eFzJkaz4KcIyBC60aqS0wMikkHiJEgIEEV
         WYwhhPZDbs9Ah4uOvXxfMzjhX3LDwafzZP1XqXI5RHo8hsX2zijJNt2e3Ujo1uP0hifl
         dn5w==
X-Gm-Message-State: APjAAAXC6xKF9mjmqpttUA0yB89PUevZcPblb+VdLQSLgVRW3PU6NkrH
        PFORjV/eudd5iE8imhjFmbq4Ag==
X-Google-Smtp-Source: APXvYqwGj+0Wjj4RUowbz6W/lmlIStZnbmKiIZOWeUKE5oUz5EPZK0z/QTRB0FLK7EZANdtJypPPLw==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr73019980pjb.138.1563774226648;
        Sun, 21 Jul 2019 22:43:46 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i3sm40833413pfo.138.2019.07.21.22.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 22:43:46 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:13:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ap806: Add NULL check after kcalloc
Message-ID: <20190722054344.w3vxrxaozd2tuajd@vireshk-i7>
References: <20190721180815.GA12437@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721180815.GA12437@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-07-19, 23:38, Hariprasad Kelam wrote:
> Add NULL check  after kcalloc.
> 
> Fix below issue reported by coccicheck
> ./drivers/cpufreq/armada-8k-cpufreq.c:138:1-12: alloc with no test,
> possible model on line 151
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> index 988ebc3..39e34f50 100644
> --- a/drivers/cpufreq/armada-8k-cpufreq.c
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -136,6 +136,8 @@ static int __init armada_8k_cpufreq_init(void)
>  
>  	nb_cpus = num_possible_cpus();
>  	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
> +	if (!freq_tables)
> +		return -ENOMEM;
>  	cpumask_copy(&cpus, cpu_possible_mask);
>  
>  	/*

Applied. Thanks.

-- 
viresh
