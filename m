Return-Path: <SRS0=fxtO=DU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41367C433E7
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 05:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBACF208B8
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 05:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAKUM39v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgJMFNj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgJMFNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 01:13:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E74BC0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 22:13:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so3308497pgt.8
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efg9FTe3uvnwtjsVgWH7nQgd64ldTBqAhLypV6QVYl0=;
        b=DAKUM39v1Y9ihvNReu6Z5fR987aM7WTeEu0h2bOul3ucAfdXF0TmTia5TSmGBtqkzm
         g1geRovBMMw4JaDFppUaSpYEwE19jFnOzHvorQgWg6fpJ0Y5dGEEDvnY3ZiLV0zztHgp
         CAtj+N8d+GKrFhKGHy2hJ+PHd3lxDe6Si5RrxeEBk27hVw68FtdjVARCyYQmPVl+H1Vz
         eNr5ZDjTl5nHLTVpObPYbtiVYvae+3VDc5Hk5V6LqtaVdrBYxEq5P4V/S2PHJl7eKobN
         whcQQGIaPtV1RQYseHd3Lw5tT1aFX4OmgmkY8XOsOY7VwbUnRmeCCI+X6jE4L8bCSvdX
         APFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efg9FTe3uvnwtjsVgWH7nQgd64ldTBqAhLypV6QVYl0=;
        b=TfdEWOJiyOKDxwJQn776Mq9800WjgQndekyS1nyJa+tlH3lU3xlbDXpHotqnwcm9Er
         +5iwChxrd7TVG5R9LjLoshXEhqnQPi9IsHokjloL4R1aKHiA+S+T2ALkq3AAI/YA9DpW
         gd8KuCPSNQbkt5qekeJmAvAkTzKU33fVVGy3tA3nU/UcHgZnGrdnW2bUq+L8qHUqnUl2
         yJtggGvtSXYeUWDRmYri1qWBfXtyXtjgMUQBEcrOCDQoohz/Ieshv1+GVAKmjdv4U645
         iE+7049bSC20U5KB+cTdKjJLb5Osui1aYPdugC+nGCV4i8V+m2eNv+F+yb5nvGOygtGS
         i24w==
X-Gm-Message-State: AOAM530X5xTbjkiAulSckb6u/Kx6SVxUYNTNAW1sUzehiWMzpr9gDmji
        cI02oBRiFW8TJqU3RKqR1DgKRA==
X-Google-Smtp-Source: ABdhPJxTpZWNGjguj6B7PCtCebgMA5wXT+BYZbYeOEWdL+11jRFlkSEaxJGCu6EEuDHXELY8VFRzig==
X-Received: by 2002:a63:3247:: with SMTP id y68mr15571023pgy.224.1602566017546;
        Mon, 12 Oct 2020 22:13:37 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n67sm20400497pgn.14.2020.10.12.22.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 22:13:36 -0700 (PDT)
Date:   Tue, 13 Oct 2020 10:43:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ksitaraman@nvidia.com,
        bbasu@nvidia.com
Subject: Re: [PATCH v2 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Message-ID: <20201013051334.ij3iucjmctg7d2xt@vireshk-i7>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
 <1602162066-26442-3-git-send-email-sumitg@nvidia.com>
 <20201012061335.nht4hnn7kdjupakn@vireshk-i7>
 <4fb38a3b-ed26-6c02-e9de-59ce99ce563e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb38a3b-ed26-6c02-e9de-59ce99ce563e@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-20, 22:36, Sumit Gupta wrote:
> Yes, this will also work. Then we don't need the current patch.
> You want me to send a patch with change from pr_warn to pr_info?

I have sent one.

-- 
viresh
