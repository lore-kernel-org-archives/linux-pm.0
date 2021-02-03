Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B8EC433E6
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 09:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CFB64E2A
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 09:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhBCJ5H (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:57:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:40616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhBCJ47 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 04:56:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65A0BAF4C;
        Wed,  3 Feb 2021 09:56:17 +0000 (UTC)
Message-ID: <1612346175.3640.32.camel@suse.cz>
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Wed, 03 Feb 2021 10:56:15 +0100
In-Reply-To: <CAJZ5v0icG4V5o8p1fAQY1Ne2vCe0CBq2YfSajSxkCE3VbuY_Ow@mail.gmail.com>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <20210122204038.3238-2-ggherdovich@suse.cz>
         <YA6XmO2nuivdpE8M@hirez.programming.kicks-ass.net>
         <1611653310.11983.66.camel@suse.cz>
         <CAJZ5v0jbw2X_Wk6We-uYOh9rMCrTTSSb32NFcYaFrtK+bMXMJQ@mail.gmail.com>
         <CAJZ5v0icG4V5o8p1fAQY1Ne2vCe0CBq2YfSajSxkCE3VbuY_Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-02-02 at 20:11 +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 2, 2021 at 7:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > 
> > On Tue, Jan 26, 2021 at 5:19 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > > 
> > >
> > > cpufreq core asks the driver what's the f_max. What's the answer?
> > > 
> > > intel_pstate says: 1C
> > 
> > Yes, unless turbo is disabled, in which case it is P0.
> 
> BTW, and that actually is quite important, the max_freq reported by
> intel_pstate doesn't matter for schedutil after the new ->adjust_perf
> callback has been added, because that doesn't even use the frequency.
> 
> So, as a long-term remedy, it may just be better to implement
> ->adjust_perf in acpi_cpufreq().

Thanks for pointing this out.

I agree that in the long term adding ->adjust_perf to acpi_cpufreq is
the best solution.

Yet for this submission, considering it's late in the 5.11 cycle,
the patch I propose is a reasonable candidate: the footprint is small and
it's gone through a fair amount of testing.


Thanks,
Giovanni
