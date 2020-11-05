Return-Path: <SRS0=Evqw=EL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4DEC4742C
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 14:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE6221FA
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKEOrP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:47:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52836 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgKEOrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:47:14 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 18280cb34b1dfbb5; Thu, 5 Nov 2020 15:47:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] acpi: fix NONE coordination for domain mapping failure
Date:   Thu, 05 Nov 2020 15:47:11 +0100
Message-ID: <2133387.cqCEZmzLhk@kreacher>
In-Reply-To: <20201105140202.GA16751@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com> <CAJZ5v0hheK3WrpKFXDUF1A4D9wt8ro3KJ73wqNwxn9DJyrt6zw@mail.gmail.com> <20201105140202.GA16751@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, November 5, 2020 3:02:02 PM CET Ionela Voinescu wrote:
> Hi Rafael,
> 
> On Thursday 05 Nov 2020 at 14:05:55 (+0100), Rafael J. Wysocki wrote:
> > On Thu, Nov 5, 2020 at 1:57 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >
> > > For errors parsing the _PSD domains, a separate domain is returned for
> > > each CPU in the failed _PSD domain with no coordination (as per previous
> > > comment). But contrary to the intention, the code was setting
> > > CPUFREQ_SHARED_TYPE_ALL as coordination type.
> > >
> > > Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
> > > the domain information. The function still return the error and the caller
> > > is free to bail out the domain initialisation altogether in that case.
> > >
> > > Given that both functions return domains with a single CPU, this change
> > > does not affect the functionality, but clarifies the intention.
> > 
> > Is this related to any other patches in the series?
> > 
> 
> It does not depend on any of the other patches. I first noticed this in
> acpi_get_psd_map() which is solely used by cppc_cpufreq.c, but looking
> some more into it showed processor_perflib.c's
> acpi_processor_preregister_performance() had the same inconsistency.
> 
> I can submit this separately, if that works better.

No need this time, but in general sending unrelated changes separately is less
confusing.

Thanks!



