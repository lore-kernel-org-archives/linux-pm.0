Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E42BC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17920684
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 09:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556097921;
	bh=+Yolj/Ebv3KHvMaI0pOoXjrUD8vd3WuLtJWrxZiEVdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SCD7Lfu1mjKDiowvGYz+xP2U3GAso0NCaD4bwJ2FbssUpVhhLv6roTz/TMVIAfC+K
	 ZBz8gWrgllTeXwAs4JCQatT4VldG14x1xEXs/oqSU9rbruQxZfBtMDTBx2SaOmlbBt
	 svXBhd8dWDlrV//Ha9dTwz61dwAbfV5gpOSZjvq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfDXJZU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:25:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34940 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfDXJZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 05:25:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so15535565otp.2;
        Wed, 24 Apr 2019 02:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bi+IcSWROdPLyY+BUL6cQHvJllQ8oSNNVQGgF0Uixpg=;
        b=CCoJd3OL6SASYvdCjprSGGqfFaiHHrv3A9m4D8IuWuZf9xnmcjvLxYDamnpUZtWK59
         K1yDE+iOA8ITQQfY6I5zfBhDKk8mnYIS0Wr0LxNDDOzbvZA3Q7GI+YLTl3Wjj31yh6Sl
         er12MQ7FHipuEMD4YOFfxWoQ7Indej7uqWOB1h/qHGY9lZyeTOqDPF0TrMj8LVCUXS0m
         6KkQOAcGdsw5zJTk2kYMbuWZX6L2btfzwgC3OUGpIZ4OSrrVoh+FQauIDeop6yMOq/nt
         Fd9qJ9TfZQwBtIe0mf7JREBE8alaNkzJ6iU+0XY6Uge+pTIkUnchUMw5s5m29ofKbOBp
         jqqw==
X-Gm-Message-State: APjAAAWvwIalvezoVlVjkzDqU4g2TWY1ecpKrCY0CtzsF1PmGOqBkjH7
        RySPVwQTv7hLj1dvm/DZ2bwUVSDmxZe6Gl04PCo=
X-Google-Smtp-Source: APXvYqyrm1hP1Q2W0IUCtL6eLwN85plGy9syyTvIiRC0e76IQgr5Y0k4OWKMy6Qzpih7Ep2J5p4WjwOvzVshkcql73w=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr18180708otl.220.1556097919232;
 Wed, 24 Apr 2019 02:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190424023223.29614-1-andy.tang@nxp.com> <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
 <CAJZ5v0hSq60Hv44wOVr5J=rHMFUPFrVKxRYOS4w+zg90oUbMag@mail.gmail.com> <20190424090252.7cmwzxf4t5lwjat6@vireshk-i7>
In-Reply-To: <20190424090252.7cmwzxf4t5lwjat6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 11:25:07 +0200
Message-ID:
 <CAJZ5v0jOOKW92X8iGPZD8Dfye4K9seXgiYaTLURby9Y3BbMYpg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Tang <andy.tang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424092507.BHw5YqTZRVI-nbhOWHX5mzWAFLRAGkqvGZAHKDCen2k@z>

On Wed, Apr 24, 2019 at 11:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-04-19, 09:24, Rafael J. Wysocki wrote:
> > On Wed, Apr 24, 2019 at 6:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > >
> > > > Enable cpufreq feature on ls1028a chip by adding its compatible
> > > > string.
> > > >
> > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > ---
> > > >  drivers/cpufreq/qoriq-cpufreq.c |    1 +
> > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > > > index 4295e54..d308c4d 100644
> > > > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > > > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > > > @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> > > >
> > > >       { .compatible = "fsl,ls1012a-clockgen", },
> > > >       { .compatible = "fsl,ls1021a-clockgen", },
> > > > +     { .compatible = "fsl,ls1028a-clockgen", },
> > > >       { .compatible = "fsl,ls1043a-clockgen", },
> > > >       { .compatible = "fsl,ls1046a-clockgen", },
> > > >       { .compatible = "fsl,ls1088a-clockgen", },
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > So do you want me to take this one directly?
>
> I actually applied it and then realized it is powerpc and so dropped
> it. You want me to apply it ?

No, I can do that, thanks!
