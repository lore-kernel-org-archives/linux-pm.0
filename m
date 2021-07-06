Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7567EC07E9B
	for <linux-pm@archiver.kernel.org>; Tue,  6 Jul 2021 08:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C58561995
	for <linux-pm@archiver.kernel.org>; Tue,  6 Jul 2021 08:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGFIp5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 6 Jul 2021 04:45:57 -0400
Received: from foss.arm.com ([217.140.110.172]:34810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGFIp5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 04:45:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01A931B;
        Tue,  6 Jul 2021 01:43:18 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E7033F5A1;
        Tue,  6 Jul 2021 01:43:17 -0700 (PDT)
Date:   Tue, 6 Jul 2021 09:43:12 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210706084312.GA219414@e120877-lin.cambridge.arm.com>
References: <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com>
 <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
 <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
 <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
 <20210706083741.2ihy6wf6bfff6lvs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706083741.2ihy6wf6bfff6lvs@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 06, 2021 at 02:07:41PM +0530, Viresh Kumar wrote:
> On 06-07-21, 09:12, Vincent Donnefort wrote:
> > Of course, I can implement this instead of a cpufreq_policy flag in v4.
> 
> Why should this ever be a policy flag and not governor's flag ?

I was referring to how letting know a driver which registers ->target() that we
want or not inefficient frequencies. My proposal was to rely on a
cpufreq_policy's flag that the driver can read. 

> 
> -- 
> viresh
