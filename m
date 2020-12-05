Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D1C4361B
	for <linux-pm@archiver.kernel.org>; Sat,  5 Dec 2020 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C90522E00
	for <linux-pm@archiver.kernel.org>; Sat,  5 Dec 2020 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLESjI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgLEST0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Dec 2020 13:19:26 -0500
X-Gm-Message-State: AOAM530rZvufIYDMZt26gNUG5RApapqZ8Y2cP44Unvq+L5DuhIBfaW27
        U9TU/9RADUs/Kfq22fh8C9NRNNahT2VNZFvQKUw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607169800;
        bh=seGZVZkmbRbAGNfBaEwnHNJz6yAmsoeRn++CrRNw8OA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/m6oqK22Erl2MqrnLg9eD3zf5UZc624z12peBhOxMCoQSHvq565ABgL4KeUGqMCy
         ygRbYLZmmSysPgbITLaEWVvQHbe6mtpPYf4uQCAV7b5/XxsKP5XQGHSiwUNYpSHT5R
         YxRViUUjMyuUmZzJAlT/OAog8jqGUmOPa1hk84r1ZLOjYrQ5eq2rChijzsOd9NFU60
         QSi5t0K15s+8dfBk+yikh2S0qiGu2duVPD99RY7mu2T9YSGClka9hKLnUzASWeNkPk
         tkJRvlFvtQbefPdwgx5i5c9RBHnUV8fS9IH8pOBNPfJw4d6GxiythCGuwrld5Zkwl4
         CqKxhhRHk03ZA==
X-Google-Smtp-Source: ABdhPJwAH/kp4eaHl02pSf3B6JIRqxzOHZ8IjG0Ih32p0Z4u2qbz20IUOtVxN383FyxVTPjMQLENzpJ5tq9ps+LN6Mc=
X-Received: by 2002:a05:6808:9a9:: with SMTP id e9mr6349307oig.4.1607169800015;
 Sat, 05 Dec 2020 04:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20201204165030.3747484-1-arnd@kernel.org> <X8rFzqURIVHeH4SL@builder.lan>
In-Reply-To: <X8rFzqURIVHeH4SL@builder.lan>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 5 Dec 2020 13:03:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BSN7sUvRLgbpJTFws-=-Va30LNLvLEXbN46KewOy2dQ@mail.gmail.com>
Message-ID: <CAK8P3a2BSN7sUvRLgbpJTFws-=-Va30LNLvLEXbN46KewOy2dQ@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: fix rpmh link failures
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 5, 2020 at 12:27 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Fri 04 Dec 10:50 CST 2020, Arnd Bergmann wrote:

>
> Your patch looks correct to me, so:
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
>
> But we're going to have to sprinkle a handful of these throughout the
> tree and we're not a lot of people who "understand" what it does (and at
> least I keep getting them wrong...)

Right, I already ran into another one.

> Perhaps it would be more reasonable to maintain this long term if we
> drop the possibility of compile testing these drivers independently of
> rpmh and command db? (I.e. drop the function stubs and rely on
> RPMH/COMMAND_DB to enable building under COMPILE_TEST)?

Agreed, I think that would be best. As long as RPMH and COMMAND_DB
can individually be enabled for CONFIG_COMPILE_TEST, all the
drivers will get enabled in an allmodconfig build, and we can just
list the dependencies.

I don't really like the headers too much that have an
#ifdef CONFIG_SUBSYSTEM with an alternative set of
inline functions, unless there is a reasonable expectations that
drivers work fine if that subsystem is disabled.

E.g. having the option to disable IPv6 makes sense despite
the complexity that adds, but compile-testing a driver without
a required subsystem that can also be enabled for compile-testing
hurts more than it helps.

> And just to make it clear, I think we should merge your patch to fix
> v5.11; then consider to simplify this past that.

Yes, sounds good.

       Arnd
