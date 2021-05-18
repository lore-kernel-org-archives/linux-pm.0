Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2179DC433ED
	for <linux-pm@archiver.kernel.org>; Tue, 18 May 2021 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0144F611BD
	for <linux-pm@archiver.kernel.org>; Tue, 18 May 2021 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbhERLe2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 May 2021 07:34:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348839AbhERLeV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 May 2021 07:34:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66DBFAF19;
        Tue, 18 May 2021 11:33:02 +0000 (UTC)
Message-ID: <be4d7573a33a1d515fab5e6368ef33dee5a06187.camel@suse.cz>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 18 May 2021 13:33:02 +0200
In-Reply-To: <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com>
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
         <20210513132051.31465-1-ggherdovich@suse.cz>
         <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
         <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-05-17 at 17:26 +0200, Rafael J. Wysocki wrote:
> On Fri, May 14, 2021 at 5:31 PM Doug Smythies <dsmythies@telus.net> wrote:
> > Hi All,
> > 
> > Can I on-board to this patch or do you want me to submit another?
> 
> Please send another one.

Hello Rafael, Doug,

I can resend a series with two patches, one adding ICELAKE_X and the
second adding COMETLAKE to the intel_pstate_cpu_ids array.
I'll prepare it.


Giovanni

