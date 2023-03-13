Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B2C74A4B
	for <linux-pm@archiver.kernel.org>; Mon, 13 Mar 2023 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCMSCY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCMSCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 14:02:24 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F032530;
        Mon, 13 Mar 2023 11:02:23 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id j11so52168207edq.4;
        Mon, 13 Mar 2023 11:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LI6HZl1dWxXiE8aiWYSTqqxQ7O/RS1dgdEkXlAEEvw=;
        b=bf2lKIbiT9khQUbf60QBEIvdiJ5iZ5fW2h0/uMPwbftVI4T5ZcRLqkXxOSFh74ploG
         CR4U6KxVCmMX7GMPcFcrJZcwP3vvZtz+bGodrdq+B3Di9HoeLIdOq0wxYbQYJnfa4j0c
         Y9mqD99rz3aJVbsgQguaDa5mkjSglhc2jL4sufIyLRponmAmbF68pJZBeGjKHo0Eag9l
         wmHwvAtNnDnjt5/ryYYJiTN9tQSV7pdUqWmPhXuHFa7J0Owue3GUITz3g0i1jSLXy+BQ
         JLCV2f5wX9RH+cpdgopxup0aTLVxRurVYyt21hoCY7+ee7GrAtj/nat6+qeTeaHSJBxb
         nDzw==
X-Gm-Message-State: AO0yUKUdQaJcUPMCj3dgbez9O7YhV6LdOQpjx3Hfud56xnoBbzs+FZ4x
        UeeNkbV499RZ4XdQev2LqpaFv6MHPf1VoALinFA=
X-Google-Smtp-Source: AK7set9+/0CkrJd1Qu1sgxW5sX8ZdYd83Y/WRHUJHCjY0B1v9B85zEDqZYM7unl3Cqvz5Bh54Dj0CPeCjaZiPDPVETk=
X-Received: by 2002:a17:906:13c2:b0:8b1:7aec:c8e6 with SMTP id
 g2-20020a17090613c200b008b17aecc8e6mr18510176ejc.2.1678730541493; Mon, 13 Mar
 2023 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <2692681.mvXUDI8C0e@kreacher> <043b2c3e3024ffaeca69046ae546303ff65694ed.camel@intel.com>
In-Reply-To: <043b2c3e3024ffaeca69046ae546303ff65694ed.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 19:02:10 +0100
Message-ID: <CAJZ5v0hwe0ctNU2hLwTorp=JQT_Q3cePw0JQLvcrvQaD5jc5Tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thermal: core/ACPI: Fix processor cooling device regression
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 13, 2023 at 5:47 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Hi, Rafael,
>
> The only concern to me is that, in thermal_cooling_device_update(), we
> should handle the cases that the cooling device is current used by
> one/more thermal zone. say, something like
>
> list_for_each_entry(pos, &cdev->thermal_instances, cdev_node) {
>         /* e.g. what to do if tz1 set it to state 1 previously */
> }
> I have not got a clear idea what we should do here.

For each instance, set upper to max_state if above it and set target
to upper if above it I'd say.

I guess otherwise there may be some confusion in principle and I have
missed that piece, so thanks for pointing it out!

> But given that I have confirmed that this patch series fixes the
> original problem, and the ACPI passive cooling is unlikely to be
> triggered before CPUFREQ_CREATE_POLICY notification, probably we can
> address that problem later.
>
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Thank you!
