Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0295EC10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01D4206BA
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZvx2YKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDYKLq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:11:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43050 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfDYKLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2019 06:11:46 -0400
Received: by mail-vs1-f66.google.com with SMTP id t23so12145915vso.10
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woQ78Cv5MbrmOzXRr57dM4FopiomlSeZvKoUqFf81qk=;
        b=KZvx2YKbb4zUXOK0WScQKmO9RHcAHYe/scmmXa2DE0fWbsQFxYzc9l1aR5qsNO5V2r
         IS0CBQQAm6HrJZmy9x4krphraqQxx7Qit/UznNO9V8WtCvnUXfDXPwOOLKqqtAShC8Ro
         m02nEo7swePDKGolhhdo7RyRZUwQc3XlittrsTwpHxetcUqZFfnwOopbV8ggeVDzFY0J
         gcivyLaJIxYNcaKWTChtC5bgDbUXqa9F34EINGrWT11RmHP6iWuaHZjDcfTBcsUp9bsO
         Mst/CqHtA24ERZkGZC/aFfu62WP2gPRkwXQSm7n8Itf5tYUGedrfiWmjsCqdYagOFRJq
         r8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woQ78Cv5MbrmOzXRr57dM4FopiomlSeZvKoUqFf81qk=;
        b=ZoDFIOcjsu/1pV51vrTJhqSFuCL5MZ7PrRsAkF9qPBauic8ympd4UYDI6fSE5/Fz5/
         PmhGStmrvPthn37/Se6ulzcIfYfA0D3d6Ostuv5f3PiAv2XKZyH9nibaHw+gicPQJQbk
         AVs7mhkwConvUbxhX3Ok/GA8zmmaxWMOTC/AF7d591QyFH7nu3lL5EGLiOkVd6g2jvYV
         n25wjpfyK3W1fGI2i+BHFtLPRG3GRKl52+wd7SlZOSo8s85oSTgW2xzSQjew++zu4p99
         Eftw/k2qtVO3TfTwrTtZriwJ3KeKpQmo6qIloghzoqkrLDMT6dsWppmlnvEP8Q8sTfxN
         7JCg==
X-Gm-Message-State: APjAAAVDtrUhMuIr8MD7rgr9NrcdypUO4L3CTwERJDcHl53EeQHmN3f0
        hU3sLUcZd1BvRDmJlbtIVvI1iJIWcjYZExu8xbv6nw==
X-Google-Smtp-Source: APXvYqwr8vXnzIzOB9Ma6fpbr12D0teNaWREbzSwiNpY6obLIHr8eoc7QtlaNYVMnyfVWRbDZvyHLp53nKkxGjm8sK4=
X-Received: by 2002:a67:ee04:: with SMTP id f4mr20449446vsp.34.1556187105071;
 Thu, 25 Apr 2019 03:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org> <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Apr 2019 12:11:09 +0200
Message-ID:
 <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190425101109.VG5zr34gP6Nk7p1T2cco3sx2FtpRae0WbLF8DU7SXSg@z>

On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > because of the virtual device that genpd allocates in this path.
> >
> > In this series, this limitation is addressed, together with a few other related
> > fixes/cleanups.
> >
> > Ulf Hansson (4):
> >   PM / Domains: Use the base device for
> >     driver_deferred_probe_check_state()
> >   PM / Domains: Drop unused in-parameter to some genpd functions
> >   PM / Domains: Search for the CPU device outside the genpd lock
> >   PM / Domains: Allow to attach a CPU via
> >     genpd_dev_pm_attach_by_id|name()
> >
> >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> >  include/linux/pm_domain.h   |  1 +
> >  2 files changed, 36 insertions(+), 38 deletions(-)
>
> Are there any dependencies between this and the series you've recently posted?

Yep. I should have stated that, sorry. This should be applied on top.

Kind regards
Uffe
