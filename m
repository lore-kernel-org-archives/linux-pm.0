Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F7C4338F
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 09:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E679C610A7
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhHJJix (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbhHJJix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 05:38:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF4C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 02:38:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e19so6675212pla.10
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmGUDQVffEqjbU2fZFvw8N47aHxiBCcFlMvcbAC01SE=;
        b=rc8M6nZCQwEpSRpemhf/Q1rL6/CIirc2mlzmVyR1qN/PYfCrHzBm4N3m2WofOIbmFG
         bHD+r/QwBap/2vi2ZQL00lgZHY3qzqSxS9+61KYKaEziQfCzrQNwofBekE5aGPl0rZac
         lgeZyr7TouXlOCti0z7vr1MUrNtJH7o3cbfYXtBsN8coOIl/c1J9+GNbEH3jZ+mzn1w8
         KQeH0J1FAXbbaEDcz8gYjnwqXz6NNTqDIB6nncZaDvnIZMT4wHv8BWFVAWKKCXR3reOz
         IaK0BCjbmZTrdfcS59kLCjx23dXcKSm/FHYfNs8E1MN978YoNK8eOj4/FKlva8ZAVbRC
         DEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmGUDQVffEqjbU2fZFvw8N47aHxiBCcFlMvcbAC01SE=;
        b=kxBM3fUzhaTEJ35zWgHnN18lXlaTLxkwCfjtBCjQzIUygncpITEpoXQhyA/zOdIONS
         E51mU3ode3TMLXw475u5XGS2nlghEBz8q5Di6oH1evKWPOf5lFR7mRUPXs8GwTih8NA7
         X9kY7EBxes0LxaMXAU5YW/jFyBYbX/WniIOIIGKHz9p4u41z8EwBp4M/IbTDe54zUwd2
         n/8IQDXHI1qZDPMH9OLfXMr0wvmCxgmubJ/gv2DpeeVVdGJz0DyJTiRr7qXgX/QlaPxB
         59WHd4JkvF2g5xpNYIUxVBt3cb/xmTl9jVOWV6mPlhRLMO9p6JMBzFf4FinhoQVk7lod
         US8Q==
X-Gm-Message-State: AOAM530DWHFQyR7nhM6xKM0KbsSIF0OzJKJ2UGtaVQWY4soffAHR/UiQ
        1E3okurr2hmwt+iGNFEvqHraYg==
X-Google-Smtp-Source: ABdhPJyGot8stnvmdsgoYb49sCstnXWOftc1D8Kb8lVuCM1UKO0gCMI8K/5WCQ9Pe/Wf9Xq6iuAArg==
X-Received: by 2002:a17:90b:802:: with SMTP id bk2mr30864189pjb.51.1628588311453;
        Tue, 10 Aug 2021 02:38:31 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c9sm21394623pgq.58.2021.08.10.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:38:30 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] cpufreq: Auto-register with energy model if asked
Message-ID: <20210810093828.drel3kuurmhd4ki7@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <b48e2c944db072c220a1b0ae0c3d94eb1c4da7ab.1628579170.git.viresh.kumar@linaro.org>
 <f96f852f-0d73-7ad2-d7a9-eab6a5b7f454@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96f852f-0d73-7ad2-d7a9-eab6a5b7f454@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 10:36, Lukasz Luba wrote:
> The of_cpufreq_cooling_register() should be called after the EM
> is present for the CPU device. When you check that function,
> you will see that we call
> em_cpu_get(policy->cpu)
> to get the EM pointer. Otherwise IPA might fail.

Good point.

-- 
viresh
