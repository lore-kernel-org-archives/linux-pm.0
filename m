Return-Path: <SRS0=fF9S=YY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BDACA9ECB
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14E820679
	for <linux-pm@archiver.kernel.org>; Thu, 31 Oct 2019 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572555917;
	bh=kOsWUibXaRq8YUzcKEc8pmXWX2utaa3I6yXkA2zu/zA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Eo7QsFlshiACP6O3eqfdFhkqywBikSKBvW95z1g7UVGTAmp2CZ2xi3aNLzIR9ci07
	 XzM2CydqqgH0l5MUAQshi8FVvA+LozugdYZ/86aPL3CCH1A6D9dxt60gqpQpzyjDwz
	 tW/DNkfUWJdKQ4Fo2rqMijoO/GTV6jBstWxGdOyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJaVFR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:05:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34159 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfJaVFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 17:05:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id h6so1958238otk.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 14:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOsWUibXaRq8YUzcKEc8pmXWX2utaa3I6yXkA2zu/zA=;
        b=HYSVXaVaaLrwnXpJWszk/6mL6cOo2YGpfL780PYlPHP1zE4NftBOWob43GpJ9qw19h
         F4vDYo4r+yg9pbPl6Dri9IQDOYFrlxDMsTsBAHA8mA7S5SMfpzCV8HtW2X8hSNCUk8h/
         YTZaT/Cxf4bbqj4tC8O3WjxXM9vlv1WCAgwI0mIaOish0dSpaaA1mrTlw7c1pUse1lbY
         qG8O4G2Km4alUMOn9VT2sa5opnI/fw67CAHvHSefMa2kvr/3ElqEQcWzzbpAWkcJzZQt
         H5qHgQJrSEnGMKKz23uATOBeaQSe+UprxMSQn/agbU1gFAQZiNFVckoS9qnepSqCoIMk
         eZnw==
X-Gm-Message-State: APjAAAX0LMWNGw4DCDrbv2ixVk7rCB49aMd1jUCbzRebe7Eb9tHiH53D
        z7y2kT+oqgqo7ybiWvKDwdslOCpUlbqAAUKDNGc=
X-Google-Smtp-Source: APXvYqwPSUeLOQI6Cq1yIxBC02S4eoAwjMA4wzKteTVwOaggTFLdpinwVbEW2DTW/gN710tsWG5p/Mq30QrpnMogI4I=
X-Received: by 2002:a9d:70c1:: with SMTP id w1mr3411095otj.167.1572555915997;
 Thu, 31 Oct 2019 14:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
 <3169109.BFaCN5124U@kreacher> <VI1PR04MB702337E37DF8E57A754C1DC5EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702337E37DF8E57A754C1DC5EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Oct 2019 22:05:05 +0100
Message-ID: <CAJZ5v0hYYav6sGns0_8EMAEPh2KE7BFZ_kftdPTA+n253oxFzA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 2:01 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 31.10.2019 12:24, Rafael J. Wysocki wrote:
> > On Wednesday, October 30, 2019 1:41:49 AM CET Leonard Crestez wrote:
> >> Current values in scaling_min_freq and scaling_max freq can change on
> >> the fly due to event such as thermal monitoring.
> >
> > Which is intentional.
> >
> >> This behavior is confusing for userspace and because once an userspace
> >> limit is written to scaling_min/max_freq it is not possible to read it back.
> >
> > That can be argued both ways.
> >
> > It is also useful to know the effective constraints and arguably the ability
> > to read back the values that you have written is mostly needed for debugging
> > the code.
> >
> > Also arguably, if there are multiple sources of frequency limits in user space,
> > there needs to be a user space arbiter deciding on which value to use and in
> > that case it needs to store the last value chosen by it anyway.
>
> If an userspace tool needs to temporarily adjust min/max_freq it has no
> way of reliably restoring the old value.

And the new attributes don't really help here AFAICS, because if the
old value was written by a user space task different from the one
updating it, that task may try to update it again in parallel with the
current writer, and so the current writer actually doesn't know
whether or not the value it has read is the most recent one (and even
so, whether or not writing it back is desirable anyway).
