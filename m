Return-Path: <SRS0=sttx=DX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AECC43457
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD8A207BC
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 16:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfcdoIjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409116AbgJPQCZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409112AbgJPQCZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 12:02:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C5C061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 09:02:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so3498912wrv.7
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idIwMLR1qbs0LEcD4O/aA7HLr22tz18ZNCJ0k8fk7cI=;
        b=bfcdoIjsQPz/8DQCpMyYBVd2UI3qSwKRY7v0yRNoQQEj+Rp6gz/TJ+c+2aWwlGHNVl
         tiWyM8kv8AOh7Ry003DOQGVEY/Yo37LIfjtqubjeH+3GIc7jpULAg9u9A04CLk6Gu0jw
         /yHdR+t2GMgvN4HgERBfhetl6TIGtenJyPCUVu9f0A5KjcDVAt1VGQuBWexBUxlScauj
         qXh81fyybu0RrScobfpBu4N+/1SeZ+vk0sL9lFOyJAAxEPH/RrUItlQpfY+BqoIuODn9
         3iiy7tMPTXq85miUzLQmeHsOmh1kCps1DU5tNZfoEk77LDH1+enI9uxbUIpTWvRPCf5j
         qz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idIwMLR1qbs0LEcD4O/aA7HLr22tz18ZNCJ0k8fk7cI=;
        b=pbll56rEWuodIZashbjJJ+jPFnvICxELQdkewWA2NauM47vIL6DEgtdv4/84IhAfMr
         11relu0xtNAh9JV+fKEAkiAeCMbAK6CNCRSD2ZSzwJ1UflQ1i4qT5ZkZCY4dDs7fRLAH
         UusvC/+ZDGw4txG8M4HKtEp4n1UOPOzIgwabcqO7puwUGBrZSuaozXPXNugibgCfijPO
         ogf5roT96VXw9OLMxPlYG/CMBLCuE5GPwfCwhJq0hIKCQZ4rwqhZS1pBNkLZsLuMRHET
         bTcsipgNkX+70/73UW0j0KNtOnDFta63e3oub6uZ5tOaiWLK61MVQC7XV3cgcUbJMMt3
         hAlg==
X-Gm-Message-State: AOAM533XQ4ZxlWWVYho+t7yv/r2ZlEHapzFneRLHw+b228Lz17qdocWV
        ROwoBhvcwaLdNJ4/I+WzfW5TOw==
X-Google-Smtp-Source: ABdhPJxB52djZ3CepWUJhRrmaEr1bcJ872guTYx2BYGnWlp5WrfpVEhYvfdeFcH5WB/FurcQW0ROnQ==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr4751369wrp.413.1602864143339;
        Fri, 16 Oct 2020 09:02:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id p9sm3193871wmm.4.2020.10.16.09.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:02:21 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:02:18 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
Message-ID: <20201016160218.GC2426638@google.com>
References: <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
 <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
 <20201016130905.GA2426638@google.com>
 <deffb2b4-34cb-3f46-af89-cc216d1cf5c5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deffb2b4-34cb-3f46-af89-cc216d1cf5c5@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 16 Oct 2020 at 15:42:57 (+0100), Lukasz Luba wrote:
> Do you mean a new entry in DT which will be always below
> 'dynamic-power-coefficient' and/or 'sustainable-power' saying the unit
> of above value?

Yes, something like that.

> There was discussion with Rob (and Doug) about this. I got the
> impression he was against any new DT stuff [1].
> We don't have to, I think we all agree that DT will only support mW.

Right, I agree this is a 'nice-to-have'.

> I have agreed to this idea having a 'flag' inside EM [2], which
> indicates the mW or bogoWatts. It could be set via API:
> em_dev_register_perf_domain() and this new last argument.
> 
> I can write that patch. There is only two usage (3rd is on LKML) of
> that function. The DT way, which is via:
> dev_pm_opp_of_register_em() will always set 'true';
> Driver direct calls of em_dev_register_perf_domain(), will have to
> set appropriate value ('true' or 'false'). The EM struct em_perf_domain
> will have the new bool field set based on that.
> Is it make sense?

I had something more complicated in mind, where units are arbitrary
('milliwats', 'scmi-bogowatts', ...) as that would help if units can be
specified in the DT too, but if we don't care about that then yes I
suppose a boolean flag should do.

Thanks!
Quentin
