Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A7C3526A
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F5D22DA9
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgLPABc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:32 -0500
Received: from foss.arm.com ([217.140.110.172]:42396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLOXby (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Dec 2020 18:31:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895581FB;
        Tue, 15 Dec 2020 15:31:07 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB213F718;
        Tue, 15 Dec 2020 15:31:06 -0800 (PST)
Date:   Tue, 15 Dec 2020 23:31:05 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] cppc_cpufreq: fix, clarify and improve support
Message-ID: <20201215233105.GA31906@arm.com>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
 <20201214161158.GA11066@suse.de>
 <CAJZ5v0hn=Xcdyi=E_km-ZJNqY-fbP3w3kCcVWVKigHQh5NsZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hn=Xcdyi=E_km-ZJNqY-fbP3w3kCcVWVKigHQh5NsZhA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 15 Dec 2020 at 19:21:01 (+0100), Rafael J. Wysocki wrote:
> On Mon, Dec 14, 2020 at 5:14 PM Mian Yousaf Kaukab <ykaukab@suse.de> wrote:
> >
> > On Mon, Dec 14, 2020 at 12:38:19PM +0000, Ionela Voinescu wrote:
> > > Hi guys,
> > >
> > > I'm sending v2 of some of the patches at [1] in light of the discussions
> > > at [2].
> > >
> > > v2:
> > >  - Patches 1-3 are trivial rebase on linux next 20201211, with conflicts
> > >    fixed after eliminating what previously was "[PATCH 4/8] cppc_cpufreq:
> > >    replace per-cpu structures with lists." Therefore, I have kept
> > >    Viresh's acks.
> > >
> > >  - Patch 4 is a merge between:
> > >      - [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
> > >      - [PATCH] cppc_cpufreq: optimise memory allocation for HW and NONE
> > >        coordination
> > >    both found at [1].
> > >
> > >    This functionality was introducing the problem at [2] and it's fixed
> > >    in this version by bailing out of driver registration if a _CPC entry
> > >    is not found for a CPU.
> > >
> > >    Yousaf, it would be great if you can test this and make sure it
> > >    matches your expectations.
> > >
> > >    Rafael, Viresh if you think this last patch introduces too many
> > >    changes, you can skip it for 5.11 which is around the corner and
> > >    have more time for review for 5.12. I've added more eyes in the review
> > >    list.
> > >
> > >
> > > All patches are based on linux next 20201211 after patch at [3] is
> > > applied.
> > >
> > > [1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
> > > [2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/
> > > [3] https://lore.kernel.org/linux-pm/20201214120740.10948-1-ionela.voinescu@arm.com/
> > >
> > > Ionela Voinescu (4):
> > >   cppc_cpufreq: use policy->cpu as driver of frequency setting
> > >   cppc_cpufreq: clarify support for coordination types
> > >   cppc_cpufreq: expose information on frequency domains
> > >   cppc_cpufreq: replace per-cpu data array with a list
> > >
> > >  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
> > >  drivers/acpi/cppc_acpi.c                      | 141 ++++++------
> > >  drivers/cpufreq/cppc_cpufreq.c                | 204 ++++++++++--------
> > >  include/acpi/cppc_acpi.h                      |   6 +-
> > >  4 files changed, 181 insertions(+), 173 deletions(-)
> >
> > For the whole series:
> > Tested-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> All patches applied as 5.11-rc material, thanks!

Many thanks, guys!

Ionela.
