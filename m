Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A7C43460
	for <linux-pm@archiver.kernel.org>; Fri, 23 Apr 2021 12:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B9661461
	for <linux-pm@archiver.kernel.org>; Fri, 23 Apr 2021 12:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhDWM14 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:27:56 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33476 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWM1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 08:27:54 -0400
Received: by mail-wm1-f51.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so5730780wma.0;
        Fri, 23 Apr 2021 05:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPSEBMBxuY2qxFd9Jq40HNvNekQAZ7IBtDRxyp+3gRo=;
        b=De913AcaOV3DDD5NuMzvaEYOOxVWi6LcAC7oB22LQI9jpWwD/Fj0NVTcDloVRPcREE
         0+LPqOdsJrQoWRxxl1CkGNMJP8YpI3vbsnFxmnrmWK6cL9xeCgIx+IOMysk3kL7fwFOL
         LqVPELCAN/dnfj1URNkkukKmvfHeuRh7nIe+ttUdkiWfvhIyBnZ/wM4RnRGQlEcMOtCU
         vx+ki0iat5TX052v85B5ZPbSa3lHpynAzFfI4UNY/FSdM3ieROfwlNU6BkG6zE6xC2hK
         GvaDJmL/Dl3JChOzsElrngb/3ydK8/VoQgxC4eZf9eIcRYoOYi+64YFrdsOgFcw7LcO6
         29LQ==
X-Gm-Message-State: AOAM532gpswfqVNfA94zlFr5Iz8OwGQGHAmsWdr748jZMbgC0OnwyWdO
        GdoE6ekMGiNh6DnLIjJv/rrYv1LNtf2z6y7ZGjI=
X-Google-Smtp-Source: ABdhPJyg+2UaV9jbnBUgS2M/YrT69lv88hjYkJzn8sPUQXoMf/etRwvl7sAIVHfZ1dPhMpZSYdg+syUkZlKqXQwYsiU=
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr4032368wmh.184.1619180836688;
 Fri, 23 Apr 2021 05:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:27:05 +0200
Message-ID: <CAJZ5v0hivxQjA2AZpPxVadzaM7gB+L3BRnoNyeD7hyvr-3Fh4g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to TF-A
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, ksitaraman@nvidia.com,
        sanjayc@nvidia.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 22, 2021 at 10:31 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs which is
> in charge of deciding on state transition based on target state, state idle
> time, and some other Tegra CPU core cluster states information.
>
> Current PSCI specification don't have function defined for passing runtime
> state idle time predicted by governor (based on next events and state target
> residency) to ARM trusted firmware.

Presumably that's because this is not a good idea.

A basic design principle of cpuidle is that it should be possible to
use every governor with every driver and the changes in this series
make the platforms in question only work with menu AFAICS.
