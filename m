Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C7C4360C
	for <linux-pm@archiver.kernel.org>; Mon, 10 May 2021 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5048A6157F
	for <linux-pm@archiver.kernel.org>; Mon, 10 May 2021 13:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhEJNXD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 10 May 2021 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349675AbhEJMtx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 08:49:53 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D16C06138C
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 05:44:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u1so8163656qvg.11
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJZh56rU3bYx3u0hyhnSmYJm+7oluLwY5PsDMkWTwj8=;
        b=dTD7X4qIOIW3q0wnQpu5kBaqCx0W1aLhKu9OI27JNbz8W1AMe4smiu22nLshqX1a2q
         EvM7yVOK23HKGKjBtvtWPVqL6hxaL0QS6mCGIHLZJRswSm0uvAblgBxyOgyfxFuwHd3D
         qnV8CwF1/83ZO3dFpVMs5U3yrI8vnUHr8PTCg5sLMSZi94FWRf9/Cbr1g8czyrzcxSRv
         jPy6LPAAIjyOrPoZLPNNFeRykjHnojG/wE9qI8VMjZ/HPgG878lXlz86OENfDVUDnF+a
         rxqkhDZoyASdeH/GJ1al729dx4GbqRZ5KceBI/35iTepDgoUrTxhsLl0J5aW9GigPCa4
         vmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJZh56rU3bYx3u0hyhnSmYJm+7oluLwY5PsDMkWTwj8=;
        b=Dssk01TLcYTiAQY1sFwwMViLSCJ1cn4vKfQoCz++hMDnw7BUt3zuAPW/CgYHAJKliK
         ZAuwC844WejOumcA4c5gMQcusFwaF76FSBanZW+TKUR5XP+gnGnC6iqvpJ28HkXyXNxy
         DhetPbDm0TbXIMasRYxf+fZlt+TL8cthrfAcBGTnxqqeMN0XMCEYr6gUMlFyTDh3OdIk
         2w9doDvgw+Vaz2QtpCBw88ApgBqqT8zXdrJ8hJjg3buZq7RVjfKBg01ohjDcp7Tk0VOA
         FL7Er1QK8Xjy2MmL5hOOoMTZrJD4m40o5cUKoOTOkxrx4q2rEvNJghN9yY8WLoyqXlf5
         XC3Q==
X-Gm-Message-State: AOAM531tefBM7IKdScAhBURz6SEMTFZ2s3hkvTHhWV0By7h+BgFDrvJc
        8w3nHT6W9/QgHEmCIGsWWPP5AQ==
X-Google-Smtp-Source: ABdhPJzJFl6qzX5SQHXoL2AsR/59ShHpx0CUAhmEN4kCRmLiFglIN+kwZNnN3Ku1cuR/w5/yol5byw==
X-Received: by 2002:a0c:f808:: with SMTP id r8mr9686322qvn.18.1620650689313;
        Mon, 10 May 2021 05:44:49 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id l16sm11425151qkg.91.2021.05.10.05.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 05:44:48 -0700 (PDT)
Subject: Re: [thermal-next PATCH v2 2/2] thermal: qcom: tsens: simplify
 debugfs init function
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210429010518.13319-1-ansuelsmth@gmail.com>
 <20210429010518.13319-3-ansuelsmth@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6fe0749e-e0e1-6094-e000-7b12f6c7b71d@linaro.org>
Date:   Mon, 10 May 2021 08:44:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429010518.13319-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/28/21 9:05 PM, Ansuel Smith wrote:
> Simplify debugfs init function.
> - Add check for existing dev directory.
> - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
>    incorrectly reported)
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara

> ---
>   drivers/thermal/qcom/tsens.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b37d5fd71f3a..e43898bf3199 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -657,7 +657,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
>   			return ret;
>   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
>   	} else {
> -		seq_puts(s, "0.1.0\n");
> +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
>   	}
>   
>   	return 0;
> @@ -669,16 +669,12 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
>   static void tsens_debug_init(struct platform_device *pdev)
>   {
>   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> -	struct dentry *root, *file;
>   
> -	root = debugfs_lookup("tsens", NULL);
> -	if (!root)
> +	priv->debug_root = debugfs_lookup("tsens", NULL);
> +	if (!priv->debug_root)
>   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> -	else
> -		priv->debug_root = root;
>   
> -	file = debugfs_lookup("version", priv->debug_root);
> -	if (!file)
> +	if (!debugfs_lookup("version", priv->debug_root))
>   		debugfs_create_file("version", 0444, priv->debug_root,
>   				    pdev, &dbg_version_fops);
>   
>
