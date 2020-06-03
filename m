Return-Path: <SRS0=265P=7Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7B9C433DF
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6405A206A2
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591192652;
	bh=CGaY9c2xpMeR0omLNM0VzjhM55YUfQm27cEQKg1rbrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MTvnuyKVr97bmfNc79pqXpOVENXll80jcN2LgHXBrWVoZbYTq3oKF29g/Z5j80QK4
	 jxk5P85rvEk2IThV/l34GKTa8R+Vn3yAB0iTw5KbsyQn2rv1ddahhZUJtsSRnb+K9h
	 OSenI22EWnwf8t7dZQ/aYO15De/FDvm9z1aCLbk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgFCN5c (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:57:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37620 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCN5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 09:57:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id m67so1874633oif.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 06:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6TC4c9113AqAEo1vsBLPSTROoGTTXq2Bezm2MS3IzQ=;
        b=FURfzmxjUSgiRxvMN2pqg4d4BjmN8TfsWWs2r32uYNmTLDkv0RNeJYTps0xa1OomVp
         Zz73rIZiElAw1KV4rk8OXaVKm9r7ViI6ozQrXWdziQH+C9jhP9cKj9BdkC7Gh9HJQ+Sp
         UHccvuMDLs6HT8a1+RVxMBJuGvGOwg2qaEkQ1CAOyzoV7HmHxFliRrMqwTXETpI3YkdA
         NIZ41TnP2pikdhPv/C+f02mCItDVPI3VjbckGr9MyUmfwbMLaMsxi05KoVuHeoJst0qv
         D3rfrVv7fUU5slqa2a2tO3It9qAnH6pHUb+ONZwApVjOQluR0Yci3V6mst27Z6jJFw6A
         r6lg==
X-Gm-Message-State: AOAM532DAkxbXelDtcaDbT4W5czhVjLMbO2LdQptGopcNuKhzC2VQM5z
        6dU5uu3rWnTQaGCflT2NCJiojhqxJctnR6b61k8=
X-Google-Smtp-Source: ABdhPJxT//CX8Q44gbc88jSTmZLtehtjJuqek9XZyMYhy0bmqvdYwU7ss/CYA+VpH4oJUp8gQZe+wBhEYnv5jdkGPDs=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr6578702oie.103.1591192650659;
 Wed, 03 Jun 2020 06:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200601105926.hug72sdvpywpbjr7@vireshk-i7>
In-Reply-To: <20200601105926.hug72sdvpywpbjr7@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 15:57:16 +0200
Message-ID: <CAJZ5v0jWkD4nbCqzEwtWJoZTqzvwHQgS+gnneyVwr=JENC8_3A@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.8 (2)
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 1, 2020 at 12:59 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single patch to enable
> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag for tegra driver.
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 1f1755af4f062cb1cbd55ca4a250fe272b82fe2f:
>
>   cpufreq: qoriq: Add platform dependencies (2020-05-08 10:53:10 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to 6cc3d0e9a097981c8a0317c65b8a2278593bd2b0:
>
>   cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag (2020-05-18 10:58:40 +0530)
>
> ----------------------------------------------------------------
> Mian Yousaf Kaukab (1):
>       cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag
>
>  drivers/cpufreq/tegra186-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Pulled, thanks!
