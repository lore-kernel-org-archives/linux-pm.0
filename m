Return-Path: <SRS0=E4ep=C7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5483CC4727C
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B312220D
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600788964;
	bh=yBYKnp2qIyIar4+QEHF6IHFHyA4o1eDMQTBvugxuVxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ejCnHbb4+srQDkuc8K1c4ZbkxWXj9CJ2Adrjvpbm7Qs3EBR8FXMHRYGnaJNo3MEO+
	 PNEfr+R3bRWlpqS4LTJKQCf9G+fvsMUq/lGSMTwx3B37c4FxS24QBqsmDyIomHEPr7
	 SxAgKwSfjxtNWTZjsFlwJb1AdkCld6ZaUVGR8OCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVPgD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:36:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37559 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:36:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id a3so21523366oib.4;
        Tue, 22 Sep 2020 08:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBYKnp2qIyIar4+QEHF6IHFHyA4o1eDMQTBvugxuVxY=;
        b=jQLRIlgyi4R6sFeho/H09CXcD1Ls1erL2apqizl+eKE3MBnk+/YwF7bJnx5zKTLVkk
         qVKYFC4OAGXVhj06EwH2W9ZOHw1RjQD+nGq6tSMuEuoLqSvYBBxHrRyVtLqhdxl5CVJh
         ZZbZ1uBoOfoDxfw69e1bL2Px492kmWjAnftSWuce/cQhUaH1mXOXmbHS9WkuwtiKGkjH
         aDEEwZPkeZ3avsIp2HAAcKdjCAWvn2dGjTdYGXkuH/g5gYEfz5ZU5gIlsV7LMQv+Fjha
         mF8oj9Qkgn2722do5L/r8EotqdyMMLDiWYBTkK7+D7S5tjiPYKV10OvUHolORLHGt21Q
         Txfw==
X-Gm-Message-State: AOAM530GWfmoc2vl+DmPKfrJG1PsaV5RxafpqiIQ900fwK6YsKfRK9ZK
        6jDr1SgdNj7X9cm87aoyhsm8Ads/K7hGTs7dbq0=
X-Google-Smtp-Source: ABdhPJyQ3oBma7ZSM0DZ1lCdbgYp+HqDIHEHTk6w56xE90nMDiJZNDikOMvJidF9A9Okh8UaErkOIhUH+UFs4ZgqHZQ=
X-Received: by 2002:aca:df84:: with SMTP id w126mr3134469oig.103.1600788961565;
 Tue, 22 Sep 2020 08:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org> <CAJZ5v0gdMroJY0d9n2+_P2uhBNw1xp5yn=jhxdejDLq0WmkPTA@mail.gmail.com>
 <160071818317.4188128.15658877054019388462@swboyd.mtv.corp.google.com> <14eb0558c8ff820280bb7354cfe33326@codeaurora.org>
In-Reply-To: <14eb0558c8ff820280bb7354cfe33326@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 17:35:50 +0200
Message-ID: <CAJZ5v0jPQoXtNY3YMe=TEEAOJjF-GbVe4msc682dHamoveatzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 6:51 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-09-22 01:26, Stephen Boyd wrote:
> > Quoting Rafael J. Wysocki (2020-09-21 09:18:17)
> >> On Fri, Aug 21, 2020 at 10:49 PM Sibi Sankar <sibis@codeaurora.org>
> >> wrote:
> >> >
> >> > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> >> > status of the PM domain unaltered during suspend/resume respectively.
> >> > The flags are aimed at power domains coupled to co-processors which
> >> > enter low-power modes independent to that of the application processor.
> >> >
> >> > Specifically the flags are to be used by the power domains exposed
> >> > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> >> > power domains are used to notify the Always on Subsystem (AOSS) that
> >> > a particular co-processor is up. AOSS uses this information to wait
> >> > for the co-processors to suspend before starting its sleep sequence.
> >> > The application processor powers off these power domains only if the
> >> > co-processor has crashed or powered off and remains unaltered during
> >> > system suspend/resume.
> >> >
> >> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >>
> >> Applied with the Ulf's R-by along with the [2/2] as 5.10 material,
> >> thanks!
> >>
> >
> > There was a bunch of discussion on this patch series and I thought the
> > consensus was to not apply these patches and instead implement a custom
> > qcom specific API that does this instead.
>
> https://lore.kernel.org/lkml/20200913034603.GV3715@yoga/
>
> The power domains which were targeted
> to use the flags will be replaced by
> custom qcom specific API. So let's not
> pick up the patch series.

OK, I'm dropping it then, thanks!
