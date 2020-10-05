Return-Path: <SRS0=LE0X=DM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D567C4363A
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31C02083B
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 23:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgJEXQa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:16:30 -0400
Received: from foss.arm.com ([217.140.110.172]:60900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJEXQa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Oct 2020 19:16:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5353B113E;
        Mon,  5 Oct 2020 16:16:29 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C5F3F70D;
        Mon,  5 Oct 2020 16:16:28 -0700 (PDT)
Date:   Tue, 6 Oct 2020 00:16:27 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20201005231627.GB18029@arm.com>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
 <20200825095629.GA15469@arm.com>
 <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
 <20200827112740.GA9923@arm.com>
 <20201005075822.6odp2ulk6wopcwtn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005075822.6odp2ulk6wopcwtn@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Monday 05 Oct 2020 at 13:28:22 (+0530), Viresh Kumar wrote:
> On 27-08-20, 12:27, Ionela Voinescu wrote:
> > I am in the middle of unifying AMU counter and cpufreq invariance through
> > something like this, so if you like the idea and you don't think I'm
> > stepping too much on your toes with this, I can consider the usecase in
> > my (what should be) generic support. So in the end this might end up
> > being just a matter of adding a new invariance source (CPPC counters).
> 
> Any update on this ?
> 

I have some code for this, but not yet in the final state I wanted to
bring it to. The code has some dependencies/conflicts with the FFH support
and in small part with the new BL_SWITCHER patches so I wanted to get
those through first.

I'm in the middle of some distractions now, so probably it will take a
around two-three more weeks before I submit the code for review.

Sorry for the delay,
Ionela.

> -- 
> viresh
