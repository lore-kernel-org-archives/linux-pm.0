Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CACC87FCA
	for <linux-pm@archiver.kernel.org>; Thu,  2 Sep 2021 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B408610F9
	for <linux-pm@archiver.kernel.org>; Thu,  2 Sep 2021 16:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbhIBQHc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:07:32 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:37635 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhIBQHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 12:07:32 -0400
Received: by mail-oo1-f49.google.com with SMTP id k20-20020a4ad114000000b0029133123994so682366oor.4;
        Thu, 02 Sep 2021 09:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noRspc2dl74kvsIlZlemvY9SNK8DJBm4g5AU/WVo8pU=;
        b=YLE1s2W6Ui3+IZ+EryH0ZQtQOaXGhZsxUFK2IlPEtNOA29zYuJ9ui+3e0UhVmCJJic
         4zdaqt1niQv+DikR8yekwBKkCFzQYkA4EFGyj7czqg9BCew7y+uTcREzWlvVz/mWsone
         7CsYQRc4Hh5wytKZ8OpbvG8QK9oIe11fSvRRM5J1O2Y6cpca6OmS9bgtKMgIdPksMgAm
         abpIEnIQdMBJQkeTuv/iT7lAycz9ZoH3/6ATKiuXYsxSYAWfgqV0jQ/zknUN8+/GVA6k
         fwuHr0r6Wye6W+XaJ9OrCo2IB/tnshAOFTLxiZ+Tv6bN5sbgvy1phNSyW1xhnkv/VDpv
         XpWA==
X-Gm-Message-State: AOAM53286AF2RnYoxKjvgHDlNn3xgIPNNq0aL4VBOYMzI9avCkCVYJAy
        9T2yTq1fyZp8ZQlK3YF46lqflvar+Hx7cdTHMD/Vfs1X
X-Google-Smtp-Source: ABdhPJza1L9WjBcQ5NFXXf4trA1rdFcAc6MdSk2ECoOYT/Ayk9kBsgrRxlQ0Bub8CfLw6dkF4qG8GSaB8wPJXhLZaGM=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr3238224oom.1.1630598793016;
 Thu, 02 Sep 2021 09:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630487322.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1630487322.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 18:06:22 +0200
Message-ID: <CAJZ5v0iU5szi4xOQLLtX=ihCmX0fEGMkkfDCvXR7BBu2S4sh4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] cpufreq: Remove ready() callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 1, 2021 at 11:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Remove the last few users of the ready() callback and get rid of it.
>
> Viresh Kumar (3):
>   cpufreq: acpi: Remove acpi_cpufreq_cpu_ready()
>   cpufreq: sh: Remove sh_cpufreq_cpu_ready()
>   cpufreq: Remove ready() callback

All patches in the series applied, thanks!
