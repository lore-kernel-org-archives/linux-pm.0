Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5AC433EF
	for <linux-pm@archiver.kernel.org>; Thu,  3 Mar 2022 04:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiCCEG1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Mar 2022 23:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCCEG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 23:06:27 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7223163D72
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 20:05:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso3256425pjq.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2022 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CIp7VVuWt9UyGTVpPLb7+VHA+YcMDNT9FMgsXkanxKg=;
        b=PhEeZ5ArChIlaQ8fLKd1T3w/HxXGqb9unw7hAxYEkfPFOO3AUp6fQVUkY7rFiuBc8W
         IFvXGH6wmPMkHdzJnzFqLt3fUZp/xc78RdLYhcpBdIcCPsWDIPWEE00/QOUwgI/3ytna
         G2V8FQbuFxN16+jOFY3dApIAd+5FJ79cW4eAOF5BQDEX6yvuh+ueoFCB52QgutqmY5Je
         uQRyuc4KMGrr9QRP0apbIso2Z0bx/6EdKgOzbBX66nsMi2J1tlhWHn63qj/4138mZP6H
         CAJ8+f1Ss5TckSxzwocuIRZZqwrVzCmrtTUcxZ3+p0dsK72hHJwqINP7vvlkqp7DnZpy
         YE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIp7VVuWt9UyGTVpPLb7+VHA+YcMDNT9FMgsXkanxKg=;
        b=52pKUn6wfRftCsNvs6xs+MHPJnkaPIRmZ3nZdb6UhvFmNm9+dZ1PMTLdpb9CgTgdRh
         S01hyeMGc6cvX2bstDpXJNLHJu53UFUeWu8r8Rnx3t8sXG5UWu24e6d4w5Om9eGqo4Gj
         fycX2GcSI8QB+ThNy98ktotbh4g5sp+vJeKnpm4eui46uo5xBCGUxjjsiSTEpLZo/Noa
         D8MJDPLHfS5UJI7K4cAM41uJ4JRnB9RdUi+5fqGIVIYkgEGJU/+cQh3fmmPZf40jRQuP
         eFwsgREfrNZVFKK3X+uazGwKTk+KqYON9mhol2E0yuiFl3NNcrScwDEwvF9bT6xRNcjV
         2+0A==
X-Gm-Message-State: AOAM530KavEMxySNrCzf5vDu2/5s+mD45g7OPnwrgJUeLpnNcNw+kjQH
        tttMvdTmu9Y5IrxfkR0VWU10Ew==
X-Google-Smtp-Source: ABdhPJxIGr193KVkbJwozHZtcGXgR2EUiiWeNS22x4PqNWxU3rWMb4wKTDN8yRE4MgGOUzHrJAJR7w==
X-Received: by 2002:a17:90a:d90b:b0:1bc:4ec7:d867 with SMTP id c11-20020a17090ad90b00b001bc4ec7d867mr3226102pjv.226.1646280342001;
        Wed, 02 Mar 2022 20:05:42 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t5-20020a654b85000000b00373cbfbf965sm615600pgq.46.2022.03.02.20.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:05:41 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:35:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Introduce "opp-microwatt" and Energy Model from DT
Message-ID: <20220303040539.ocnslxyswnvua3o7@vireshk-i7>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302112917.27270-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-03-22, 11:29, Lukasz Luba wrote:
> Hi all,
> 
> This patch set solves a few issues:
> 1. It allows to register EM from DT, when the voltage information is not
>    available. (Some background of the issues present on Chromebook devices
>    can be checked at [1].)
> 2. It allows to register 'advanced' EM from the DT, which is more accurate
>    and reflects total power (dynamic + static).
> 
> Implementation details:
> Existing machinery in the OPP framework now handles "opp-microwatt", similarly
> to "opp-microamp". It also has helper exported function to get power from OPP.
> For the EM, it adds a new callback in OPP framework to use this new API and
> read power while having an opp pointer. It's agreed to work with OPP-v2.
> 
> Comments, suggestions are very welcome.
> 
> changelog:
> v5:
> - added dual-macro to conditionally setup needed callback and compile
>   on !EM kernel gently
> - removed 'advanced' word from OPP patch header description
> v4 [2]

Applied. Thanks.

-- 
viresh
