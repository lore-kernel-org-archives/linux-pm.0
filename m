Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C555C4338F
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24B960E97
	for <linux-pm@archiver.kernel.org>; Tue, 10 Aug 2021 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhHJPsF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhHJPsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 11:48:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B449C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 08:47:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 6so1249689wme.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDaGuwWbiFYHv/+u9xTKhERWor1NRN9LJwDDU43ZPlM=;
        b=Zw9cPJo1djs0P+aiL4Z/uQBZO7+xZbCaqaA0wZD859awofWDpQew9kIJ+YMvQXP6zf
         LcLqeVcIrZEC946/btXSi+LIGio8KqU6aPfnAc4R/qVR5DRCEhy/XwoEw4lCAhkHzEjo
         kC1vUPy81d0ihEi9HNCSB9i60gpv1z0rpmnwCzFuOT0MsjbQoJ7cAp5jscmduHW8TIKf
         Scfqpm3nnAm4s4eE8xWvnYRXZEZ5rBj/MpJltLRqpgd2ghuSeZriEClDKT9ITheAiepp
         C0vnmnN81qWxRSnuV9kzDSvUN318xPhBOjtMZEftH591aCQrPbEYvhjACyGyaLXBoWn/
         d1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDaGuwWbiFYHv/+u9xTKhERWor1NRN9LJwDDU43ZPlM=;
        b=ZZ/EjvRCakI1eD+ouZEDI95ujQcKQDtacSVbOa7BelVD+DKWvyIh58DY4lv9sKZkFc
         PCGuDGu0XrVVcxRk8bX0JeoVOnBWyO5gbFafjsXDWZUI+Z+SXH+tMPF7hoT54v/BneLj
         di7f8l0+qSvfBN3Vo+ylzg3Iq8Yp3PME97zdm440hzTMN706LsNqWhOZ7F9aC+meADzA
         hV3sjqd+5cJjZC0J/oxpRoMgUuAGUtt2Qiz19mlgR6LrT1/BOAf72IHMBT3D1lNi0DhL
         ohrLXeJxvePqFzOSY3e+5JGHbxso6tU6uf6RM90Q8GyTFv6RmA4Bzt2atoMRFR2I75Wa
         ysTg==
X-Gm-Message-State: AOAM533QNm37DV8cW5whLtgFeb0l2E5MHcTyWGaHVfFQ4SvqrH+TTZhD
        HEY3nsLub3ycKJt21e4nxdYnAg==
X-Google-Smtp-Source: ABdhPJw70tHNLWZeI/EEou5AcrDTftv1+g96Lmw+NLH5xI0MNk7/l3taECzY7vXzOuEm9nwaS+S0Nw==
X-Received: by 2002:a05:600c:3b15:: with SMTP id m21mr23356236wms.99.1628610461080;
        Tue, 10 Aug 2021 08:47:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e920:cedf:a082:9d02])
        by smtp.gmail.com with ESMTPSA id z13sm12663882wrs.71.2021.08.10.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:47:40 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:47:34 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, r@google.com
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <YRKfluMP8G41/P61@google.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
 <YRKINFhDmYqvgxsN@google.com>
 <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
 <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 10 Aug 2021 at 16:12:29 (+0100), Lukasz Luba wrote:
> I've checked that. It's not the policy notifier and arch_topology which
> cause an issue, but the cpufreq governor setup code. Anyway, we cannot
> wait so late with the EM registration, till e.g. ::ready() callback.

Aha, yes, because by the time the arch_topology driver rebuilds the
sched domains, the governor is not 'installed', which means the
scheduler is not in a position to enable EAS yet. So we need to wait
until sched_cpufreq_governor_change() is called for that. Makes sense,
thanks for checking, and +1 to your conclusion.
