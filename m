Return-Path: <SRS0=ei9F=7S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FCAC433E0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Jun 2020 12:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6796206E6
	for <linux-pm@archiver.kernel.org>; Fri,  5 Jun 2020 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591359760;
	bh=M3jMtFN+CSsczEUa7TDYXsE0fUJWoZIKVdF95MVU01w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FZMv5ZDLnxGRv0jV9XBnQt77XH5nsnOy2UAmh0t9iOCF6P9cu3uqa2waB4x63CF4/
	 gTd9Jydvd4v7U1uei510LKwYQ4kSyiiv3qGxyn6hKqicuOANyuQxfBLIrOVkPrdhA0
	 1Bm6l/ZsAM9djFLRVECfLniqc4fYMFRPOiqmXeQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFEMWj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:22:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46968 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFEMWi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 08:22:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id g7so6334541oti.13;
        Fri, 05 Jun 2020 05:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPWXKsqwL8hOgvzZkdc7ooHkJ32A3QWoyaocwxX1J/4=;
        b=iwnArzSaI7HfMoYylo2xGnXRpbMY8DZthcPrTmTlEqQMkM47QSXofSrofsJZY+uXzh
         o7yM6Odx/y68wlh0Doe9q1O3jhm1mTAwyoe3XSWbsfpjT2BqcaBNhJMfWb+x+xpIFGEX
         Cn+2bC/+6pq3YEu4Cr4imFnQKSXzgT22WI+PoT7hYDN+pnWa2XuHVo5/2IZDBERioJp5
         mApcWeRuE4lmdp/t1EbGHZQczwoe2vIl9mMIGdSbSpIRumpIPi2HeWsZhA/TZxDLwJcb
         qUDvO+hJhYAJcXbcFFGLhUvOS9Fj1nnHK+5ju+cnCnGMSYB6S+ShvMoQMSGeKpitFpuS
         u97w==
X-Gm-Message-State: AOAM532Qe1Lf0gKu5uKlhWHhY6/YIUEtN4oQQc7PJqV8IbNNIBplBToE
        u01+nO0/CPRFn7UdTUQqpkhjbdGG8mOqSxdLHhQ=
X-Google-Smtp-Source: ABdhPJzC9F6xc6dWDWIJplrkb7S6UF6TISH4Vi2pH+J29xJPCWjBOhYYpET2qLjnm079/QRrBAOOECTFl9mN+WIBwxU=
X-Received: by 2002:a9d:5185:: with SMTP id y5mr6991224otg.118.1591359756787;
 Fri, 05 Jun 2020 05:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <1590804511-9672-1-git-send-email-wangxiongfeng2@huawei.com> <20200602051609.ahot4qv2nlb6yh3t@vireshk-i7>
In-Reply-To: <20200602051609.ahot4qv2nlb6yh3t@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 14:22:25 +0200
Message-ID: <CAJZ5v0harpqoN9=jPyuD-P9B1jvRcBShUZT5=8J-uymqEKyCyg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] add SW BOOST support for CPPC
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Thanu.Rangarajan@arm.com, Sudeep Holla <Sudeep.Holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 2, 2020 at 7:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-05-20, 10:08, Xiongfeng Wang wrote:
> > ACPI spec 6.2 section 8.4.7.1 provide the following two CPC registers.
> >
> > "Highest performance is the absolute maximum performance an individual
> > processor may reach, assuming ideal conditions. This performance level
> > may not be sustainable for long durations, and may only be achievable if
> > other platform components are in a specific state; for example, it may
> > require other processors be in an idle state.
> >
> > Nominal Performance is the maximum sustained performance level of the
> > processor, assuming ideal operating conditions. In absence of an
> > external constraint (power, thermal, etc.) this is the performance level
> > the platform is expected to be able to maintain continuously. All
> > processors are expected to be able to sustain their nominal performance
> > state simultaneously."
> >
> > We can use Highest Performance as the max performance in boost mode and
> > Nomial Performance as the max performance in non-boost mode. If the
> > Highest Performance is greater than the Nominal Performance, we assume
> > SW BOOST is supported.
> >
> > Changelog:
> >
> > v4 -> v5:
> >       add 'cpu_hotplug_lock' before calling '.set_boost'
> > v3 -> v4:
> >       run 'boost_set_msr_each' for each CPU in the policy rather than
> >       each CPU in the system for 'acpi-cpufreq'
> >       add 'Suggested-by'
> >
> > Xiongfeng Wang (2):
> >   cpufreq: change '.set_boost' to act on only one policy
> >   CPPC: add support for SW BOOST
> >
> >  drivers/cpufreq/acpi-cpufreq.c | 14 ++++++-----
> >  drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++--
> >  drivers/cpufreq/cpufreq.c      | 57 +++++++++++++++++++++++-------------------
> >  include/linux/cpufreq.h        |  2 +-
> >  4 files changed, 77 insertions(+), 35 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Both patches have been applied as 5.8-rc material with slightly
modified subjects and the changelog of patch [1/2] has been updated.

Thanks!
