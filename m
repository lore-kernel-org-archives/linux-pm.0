Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26BFC282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C33E20857
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ig18VicH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfDVHLd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:11:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46784 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVHLd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2019 03:11:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id o7so3148284pll.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2019 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fuu/HgA3Zck7zUDGxDbhlOoVzdybExIgvR3jeuv+sjs=;
        b=ig18VicHKk8Rw/qe7ccl4KHcbu6bDhuD5OMZuE0huyrXrUTOEflofw9HL5G0O5sI7q
         F8IuWbzcdsNka3SNKpNH9kUCwPbN8PTmpO+XmCWYETNfRJVh8HS+jW8lq9iMDfSdBzJB
         jPvR2AF7ezPHNnj3W3ACHvfSWyAGjQxod1zPRTnsCiCoANLvRdBBWhZCprGuYvjdxUcY
         ubICmfYPj9RsfYsaoyS9Er6Hh2xkpuJnrxMKzDbGDHaMztB+AYjuawPPAjcx7i+t+cCY
         xQ+xqeBzqj6mr2fuXqgeGxbMyS/5ZSGnQlpoOHdsBj5EdtCNWIkXax1CDPTUEiEr1Ymu
         l35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fuu/HgA3Zck7zUDGxDbhlOoVzdybExIgvR3jeuv+sjs=;
        b=S2kBmxhYlNbVazaYbrHPe4xIUgEYZUAh8N5cAkM4qA+qmI0iZOObuOuAXL9Ff4DoTa
         jAAqIXOxoZsIgYk73ZnQUmD7D+Myn1/Et7y4ohDmzPv9I6r+czOuR57PSSnBhtCXjwx4
         6siY97fNtahChF8cgYSqGqj9jAq8V/UmIw3Jmv42fnJhRskl4SpycpA+8QntxvWHCphB
         ogKme7v45f5UgwF2bg7E9H/6lFiTY6LI7rojbHrupbnwkmr8upe1xEVafegVQnX0SFN7
         heOmsYU8HR3H8C8fezye16XddCBQ7Nr4t+yMfuc8l0jg0WHy82muq36euLX3LrrFUupU
         EK2w==
X-Gm-Message-State: APjAAAXeChrv4cY4ykp10QVzsXVRTX6i2gy/9XKy22NjTsHaycqKQhdt
        joPzbSClvNRieAS0PX+mZlQAIA==
X-Google-Smtp-Source: APXvYqyR4OF+DNTsKPnb7mdRvFuV/v8ycBt8AejFu30hTf1XlslAFyXq+n1QcvRzpBj/6wqvKISdLg==
X-Received: by 2002:a17:902:3324:: with SMTP id a33mr18792821plc.186.1555917092584;
        Mon, 22 Apr 2019 00:11:32 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id n65sm29065250pfb.160.2019.04.22.00.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 00:11:31 -0700 (PDT)
Date:   Mon, 22 Apr 2019 12:41:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     mohankumar718@gmail.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [RESEND] drivers: cpufreq: use kstrtoul instead of obsolete
 simple_strtoul issue fixed
Message-ID: <20190422071129.mttd3t3646rli4lc@vireshk-i7>
References: <20190421150556.23341-1-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190421150556.23341-1-mohankumar718@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190422071129.Bp8wThwLcxAC7PQKOmD-EHBoRi1nMLZ8asQApsBZgTA@z>

You mentioned RESEND in $subject, which is incorrect. This isn't a
simple resend but you changed the code. You should have mentioned V2
in $subject and ...

On 21-04-19, 18:05, mohankumar718@gmail.com wrote:
> From: Mohan Kumar <mohankumar718@gmail.com>
> 
> Replace the obsolte simple_strtoul function with kstrtoul.
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---

Mentioned V1->V2 diff right here in the patch.

>  drivers/cpufreq/elanfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
> index 03419f064752..6d861c2364e2 100644
> --- a/drivers/cpufreq/elanfreq.c
> +++ b/drivers/cpufreq/elanfreq.c
> @@ -184,7 +184,8 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
>   */
>  static int __init elanfreq_setup(char *str)
>  {
> -	max_freq = simple_strtoul(str, &str, 0);
> +	unsigned long int val = 0;

A blank line here would be nice.

> +	max_freq = kstrtoul(str, 0, &val);

And this looks wrong. The value isn't returned by kstrtoul but an
error message or 0.

>  	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
>  	return 1;
>  }
> -- 
> 2.17.1

-- 
viresh
