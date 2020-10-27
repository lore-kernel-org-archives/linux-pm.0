Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25209C388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB85C2225C
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhwMfe8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895906AbgJ0JqC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:46:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408996AbgJ0JqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:46:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so1128463wrq.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VYa/0M9CM+BFisp0qH8kfuZ9SqVMtB0gZkYPNI1LHUU=;
        b=LhwMfe8w6zLfJePcO71XK8ee5zI6g7hCE/+/Iv80FqeoYy8S9+GElomDGzzytfo39Q
         2bJ1yAOuAmnVikJKD/7z19CmjhO4va2e6Rlp4ZTxhjWpV0uvTy3AO3G9LYuDTMF26lmg
         UKJPPgs1OEadT8weo63Ekv/JXNjO8jym8S7zYRkmRr24jFhOQhQTlWa5KzhLt+e5KN2a
         PK645FT3m5ueILODfTBsE3KC3zhymiuHpIksxb7uVQfo/eiC+nn+ZM2TkCZXX5x2Q+BD
         Ciged51VnfWoZRt+kfav00GdfBjjZYrUT13fBnMonVnqBF+VUuzocc9x2NxJyrBbLPrG
         Umgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYa/0M9CM+BFisp0qH8kfuZ9SqVMtB0gZkYPNI1LHUU=;
        b=jqBzp9GV7GWrzkx/ZMYJRQlFp0ENTrJqico6uvJ1myOupa9ihMqK1D5oxaa/atBzPC
         wEH/K4UTyYY8xTObxpOr69ZxXDUUsnUAWcyvKjHhsMLGCrf5HQfFR9M+7kEi0AH6veb5
         DYzQrvX829lgISUXoDYO/ZePtAVP5yQpcyVg0j7L0UcAxDz4eclrF90i5DmFY4xdjvIA
         1vmw+vHs/V+Y54oRCmCS/vvKDelLIxfPzmSlkMplGKg51qaYxhuSLoqvyfeUD1UxZVSb
         TsaCuB+sl7aMReyGNB/hqXBAULf96uRhP51qK+3rvRTbtuaAZwZVwWFTEmxwz7bvyzvC
         Mnfg==
X-Gm-Message-State: AOAM532tnWATj3c8PQTXUs80zr9MdpTEeaFYkz5Ohq086EHqN0zd5pjn
        Ss0y9HxxNNvZGyj7vFSxyxMgYQ==
X-Google-Smtp-Source: ABdhPJwi1n98cnvdQ4wWt7HHvJ6RTxLPMC9CSUIOBLuZQdN6syw6ubyoZ6lhMUyNR1z5RFzQ5I/kyw==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr1671184wro.291.1603791958130;
        Tue, 27 Oct 2020 02:45:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id o3sm1321735wru.15.2020.10.27.02.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 02:45:57 -0700 (PDT)
Subject: Re: [PATCH] thermal: rcar: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>, niklas.soderlund@ragnatech.se,
        rui.zhang@intel.com, amitk@kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <72412b5a-fd9a-a23e-aaf8-1a7b6eaa16c5@linaro.org>
Date:   Tue, 27 Oct 2020 10:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 02:06, Tian Tao wrote:
> On RT or even on mainline with 'threadirqs' on the command line all
> interrupts which are not explicitly requested with IRQF_NO_THREAD
> run their handlers in thread context. The same applies to soft interrupts.
> That means they are subject to the normal scheduler rules and no other
> code is going to acquire that lock from hard interrupt context either,
> so the irqsave() here is pointless in all cases.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
