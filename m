Return-Path: <SRS0=pKl/=V2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4DAC433FF
	for <linux-pm@archiver.kernel.org>; Mon, 29 Jul 2019 20:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F320657
	for <linux-pm@archiver.kernel.org>; Mon, 29 Jul 2019 20:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6/EVosz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfG2UQ4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:16:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44889 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfG2UQz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 16:16:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so46112344oib.11
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8zi81LHOHqEUYJ5h1qiWav8ZTAlVex16b4xeeFlwaI=;
        b=I6/EVoszemoOmGnO4iFjE+KkZf4mW8yad0zcnup0o2vWzk84+cO5qrk8H0szXoY/yT
         dF/VG41/bLAp3LCro842eoAFVplvHIxwGBEpTU/93OM6j7gkkopwHpAJvhLbBWUoa2c2
         ZNOWp8QWsyddeXwnUn00kHkCslGISArM1EWlRfLoh0nYkvglI+yW2KAZhojjjvK85wzI
         RDRoh+mkhNIob/680owAhI9JomaSkwGmk7B89s2SD8EwAkFlhJplFkrqu57X92lglO0y
         Kj1ugsHCxSV3muxvPQhnL1vEEgylOpVZ0Uf2YVjK34Vcxy11LZCmMGRZVZyYkR9KurSW
         VZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8zi81LHOHqEUYJ5h1qiWav8ZTAlVex16b4xeeFlwaI=;
        b=qCvLg7FyVm9nt5DqcgO4n773qPbo0cCZyb4LfL78lvbJYGhxWVOq30IZxUf06fklru
         7SiPPmgQb2Knji5J5RK2VSgeqLEAy/DAwp78BFVSOoZtJHqKoAOeJYkieP7V6ae8m5au
         nKXnxeKA4ufmDzfpKhpzxBB4zTk+3kNKF+yFcZTGS8yY9Y56y6nOzZBOjRRjnbXt4LkW
         vMs6qvo4CCIsNhD4qnpVuV0aKa3Nzk3t3NXdCIA2SVjIE5Rqku0Gp8mM1+Njqkj/Z3mt
         x+6jh7+mVcu5hc+mMqZY1xfhECeoU1j6OQ4mwN/80pt4Ki7aW3yce1uh8uudiAqBaQKI
         Ucpg==
X-Gm-Message-State: APjAAAUN+8f1AfObKFD+YuMO8NRYfuVcXnCEr6wbj5A+qCL1kw8Ojn8r
        GMwF7TLmpzCmVXKgTACEYu0dE5v80F0g9Whm6J/EhA==
X-Google-Smtp-Source: APXvYqxQuUTl19e48sL3aGXbBTswfN2yF1G00rWJlxlH7ntf6qvxnBji1ehL0VdV8MXOEHv2+7g2wo55rorywH6+dhw=
X-Received: by 2002:aca:1803:: with SMTP id h3mr21244210oih.24.1564431415085;
 Mon, 29 Jul 2019 13:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com> <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
In-Reply-To: <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Jul 2019 13:16:19 -0700
Message-ID: <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 2:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-07-19, 16:15, Saravana Kannan wrote:
> > Interconnects and interconnect paths quantify their performance levels in
> > terms of bandwidth and not in terms of frequency. So similar to how we have
> > frequency based OPP tables in DT and in the OPP framework, we need
> > bandwidth OPP table support in DT and in the OPP framework.
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
> >
> > gpu_cache_opp_table: gpu_cache_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_cache_3000: opp-3000 {
> >               opp-peak-KBps = <3000000>;
> >               opp-avg-KBps = <1000000>;
> >       };
> >       gpu_cache_6000: opp-6000 {
> >               opp-peak-KBps = <6000000>;
> >               opp-avg-KBps = <2000000>;
> >       };
> >       gpu_cache_9000: opp-9000 {
> >               opp-peak-KBps = <9000000>;
> >               opp-avg-KBps = <9000000>;
> >       };
> > };
> >
> > gpu_ddr_opp_table: gpu_ddr_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_ddr_1525: opp-1525 {
> >               opp-peak-KBps = <1525000>;
> >               opp-avg-KBps = <452000>;
> >       };
> >       gpu_ddr_3051: opp-3051 {
> >               opp-peak-KBps = <3051000>;
> >               opp-avg-KBps = <915000>;
> >       };
> >       gpu_ddr_7500: opp-7500 {
> >               opp-peak-KBps = <7500000>;
> >               opp-avg-KBps = <3000000>;
> >       };
> > };
> >
> > gpu_opp_table: gpu_opp_table {
> >       compatible = "operating-points-v2";
> >       opp-shared;
> >
> >       opp-200000000 {
> >               opp-hz = /bits/ 64 <200000000>;
> >       };
> >       opp-400000000 {
> >               opp-hz = /bits/ 64 <400000000>;
> >       };
> > };
> >
> > gpu@7864000 {
> >       ...
> >       operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> >       ...
> > };
>
> One feedback I missed giving earlier. Will it be possible to get some
> user code merged along with this ? I want to make sure anything we add
> ends up getting used.

Sibi might be working on doing that for the SDM845 CPUfreq driver.
Georgi could also change his GPU driver use case to use this BW OPP
table and required-opps.

The problem is that people don't want to start using this until we
decide on the DT representation. So it's like a chicken and egg
situation.

-Saravana
