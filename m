Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC203C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 09:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BAA21773
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDUm/16H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDXJC5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:02:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43185 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfDXJC4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 05:02:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id e67so1109360pfe.10
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwJWBfXGuJEaev7l7LV+ex082+XmEKHmms2Uv5DMQQQ=;
        b=qDUm/16HZIGVbyCTCOG6FC4f6zD4nF968TjEPNBLnk1txcyrG4V26SBXtw2qwWdWbd
         GDohNmRrDup4JgMbjH4ZZ+iTgb3+Se2k4PeVZT3VX+CQUtt4zffFM5fwaTJwgolqSu4z
         pOIuAOs869bVyw1NTZWX7utRAxBBOzc0wj+umQNbAKpmnhqmc5wdvNAG+QA19zvRB1xx
         ZnSpjyeelRBGteHxwNZyw/o8fJHajBdKKQ7cdfQ8me/fcRoOC0NOvvsAauHMGBK/dqnd
         J41HziGieF3rMs9b17gXVSHqSu+ms/6jhPoz0bWBT2kynwlrtPbTSOsB2cvKHvXOjozs
         gjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwJWBfXGuJEaev7l7LV+ex082+XmEKHmms2Uv5DMQQQ=;
        b=Mq5/YXVA1oHdLC5W9+VW9A305KIAROAnuG4E8KoS3X9mhPfaPxuF50ho4nwOM46IcQ
         IR6KTilLR1O80eCfVmsr9D4xcP8NHd8uXE0KAgqGp8LN+kiD7xrwtTeAq8CVOtv8Kg9J
         GucLXlJDxAA71vgytBSMRYopK+Rjvc2XagEno/h/CVHdtmEWmwe6AkkKnbvd1sackrRu
         gUVXEndjlQlLv+RJ0LQ3dq1IFI2hTPqlsMr7fHAbkhHevdlRYduoZXtw+4TS5MVDUhB8
         36evoqCzvtIk0I1bSqBB0OFqVere0m1iGku2kj7XtlY/ovMriSGSa87LuWfvfOZxsEfB
         y5dA==
X-Gm-Message-State: APjAAAXka8Yh+JCxjALzlnLxU4RJv2Enl3Zy25an/3tfZDW5uAFzw5s1
        4rKXNiV23eeDx4imtjYURh1crg==
X-Google-Smtp-Source: APXvYqw560mz5cPdHJUPiXi0cG2iZL09qeHwmkPqevmJs3RG5O8uUWjIlepfoylULnjQaZysooNfyw==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr31850624pfd.234.1556096575713;
        Wed, 24 Apr 2019 02:02:55 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id f87sm30237512pff.56.2019.04.24.02.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:02:54 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:32:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Tang <andy.tang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Message-ID: <20190424090252.7cmwzxf4t5lwjat6@vireshk-i7>
References: <20190424023223.29614-1-andy.tang@nxp.com>
 <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
 <CAJZ5v0hSq60Hv44wOVr5J=rHMFUPFrVKxRYOS4w+zg90oUbMag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hSq60Hv44wOVr5J=rHMFUPFrVKxRYOS4w+zg90oUbMag@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424090252.PPApL88vG-hGFuJNTgwLmkr7Fxzu4_HdXcJKPKlbjUU@z>

On 24-04-19, 09:24, Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 6:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> > > From: Yuantian Tang <andy.tang@nxp.com>
> > >
> > > Enable cpufreq feature on ls1028a chip by adding its compatible
> > > string.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > ---
> > >  drivers/cpufreq/qoriq-cpufreq.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > > index 4295e54..d308c4d 100644
> > > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > > @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> > >
> > >       { .compatible = "fsl,ls1012a-clockgen", },
> > >       { .compatible = "fsl,ls1021a-clockgen", },
> > > +     { .compatible = "fsl,ls1028a-clockgen", },
> > >       { .compatible = "fsl,ls1043a-clockgen", },
> > >       { .compatible = "fsl,ls1046a-clockgen", },
> > >       { .compatible = "fsl,ls1088a-clockgen", },
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> So do you want me to take this one directly?

I actually applied it and then realized it is powerpc and so dropped
it. You want me to apply it ?

-- 
viresh
