Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20310C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jan 2021 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44F5230FC
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jan 2021 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390748AbhAZJC4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jan 2021 04:02:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:42624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388923AbhAZJBo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 04:01:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B70CAC4F;
        Tue, 26 Jan 2021 09:01:01 +0000 (UTC)
Message-ID: <1611651660.11983.64.camel@suse.cz>
Subject: Re: [PATCH v2 0/1] AMD EPYC: fix schedutil perf regression
 (freq-invariance)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>,
        Michael Larabel <Michael@phoronix.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Tue, 26 Jan 2021 10:01:00 +0100
In-Reply-To: <YA6CqYcaEhUoyJdH@hirez.programming.kicks-ass.net>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
         <a5071cb5-6a5b-d2e4-ff06-fa7810b8127c@phoronix.com>
         <YA6CqYcaEhUoyJdH@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-01-25 at 09:34 +0100, Peter Zijlstra wrote:
> On Sun, Jan 24, 2021 at 04:30:57PM -0600, Michael Larabel wrote:
> > From ongoing tests of this patch, it still certainly shows to address most
> > of the Linux 5.11 performance regression previously encountered when using
> > Schedutil. Additionally, for a number of workloads where not seeing a
> > regression from 5.10 to 5.11 Git is still showing even better performance
> > with this patch. The power monitoring on the AMD EPYC server is showing
> > higher power spikes but the average power consumption rate is roughly
> > comparable to that of Linux 5.11 Git, which is higher than 5.10 by just
> > about 3%.
> > 
> > So this patch still seems to be working out well and indeed taking care of
> > some wide losses seen otherwise on Linux 5.11 when using Schedutil on AMD
> > Zen2/Zen3. Still have some other tests running but so far no unexpected
> > results.
> > 
> 
> Did you do all this writing and forget to add:
> 
> Tested-by: Michael Larabel <Michael@phoronix.com>
> 
> ?

Michael confirmed me off-list that yes, the patch should carry the
"Tested-by" tag with his name.


Giovanni
