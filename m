Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1925C433E6
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D076527B
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCIQCs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhCIQCe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:02:34 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485ACC06174A;
        Tue,  9 Mar 2021 08:02:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ba1so6811497plb.1;
        Tue, 09 Mar 2021 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/zo2jfoF6PwZ9TXZrzdcWMw/MqCL+4M9acRioKN5rc=;
        b=hGc1sc9Zin0NGlvn8UZ3ktU9arWOLbXIZq3+A8CoH3V2/H/PmWhrFCMyXjXjtPvtAI
         +Wxtnu/GGNsv0lUC+sdFCzNApr22GGZNq+gXVG/HlJGQU4Mza+7MjTVRTAxGc28GCjKE
         hapAcGKKW8YB90Xnj45SXIMO7IuHBw7NHFTykzsxiE29+GCrbhTWV4hrnoZNIepV5bOf
         g4yC/xg/McAFp/qkVFnRtoOLAwl+PKI3IvKXDVrORrQGnLw7QohlXx8MOxAqJCI+oAFr
         hPsxTPAxQv4GRc/6XoUZqOGNXLl4uTjnrK6Nu0YPXDwm5oczLxlrvakJTz9U22sDrqCU
         qJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/zo2jfoF6PwZ9TXZrzdcWMw/MqCL+4M9acRioKN5rc=;
        b=Rmw6DbBebjRXb5tYFaP7mlBe+t1JVNP/LL+MK6WMWAC9rAKPXyF16cm6aQFUHqaIoC
         fwqONeHSsFdKlkwzDE+d5lk4q2Er/bOjHaUDBzbo491F72aZuuTnRlUVB1Ph4Oz4meXV
         fA2F4JWPBfijBHyID9KcQGsKFxwchtpunJgiZt0jNf7HXLymaXix/J4FMP4XQTb21ecR
         P/Q0wkKtldG+FQVGueEjBzt9vsYNyRUp60MY6KOIsBGvl2SwmK+Iq6Lo1oHb0qUhg+8g
         eidBSXgZCYLILC4xdjiOdRwVDhTKLWus3q/rKhOHczXxZqZsXlTobRpQK+sBDy4n7hI7
         o49w==
X-Gm-Message-State: AOAM530AZ1zydDHdFKTT9R48JMTxOPpVaC+mJ68kY3fuTd0K5vEp615u
        rdGO9/JVaGcGyjFvRd3EzRA=
X-Google-Smtp-Source: ABdhPJxIU5SiZTXIDieOgpkzSZECuHkiBOixDLlYNAcoh6C3BBtVCOUOMI2OneoxF56SgTzabizELA==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr5347330pju.195.1615305753784;
        Tue, 09 Mar 2021 08:02:33 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id t19sm13127374pgj.8.2021.03.09.08.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:02:32 -0800 (PST)
Subject: Re: [PATCH 08/11] PM / devfreq: check get_dev_status in
 devfreq_update_stats
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <819323f6-3b2e-403b-3068-06d4c09af354@gmail.com>
Date:   Wed, 10 Mar 2021 01:02:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> Check .get_dev_status() in devfreq_update_stats in case it's abused
> when a device does not provide it.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/governor.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 31af6d072a10..67a6dbdd5d23 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -89,6 +89,9 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
>   
>   static inline int devfreq_update_stats(struct devfreq *df)
>   {
> +	if (!df->profile->get_dev_status)
> +		return -EINVAL;
> +
>   	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>   }
>   #endif /* _GOVERNOR_H */
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
