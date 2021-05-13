Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B5C433B4
	for <linux-pm@archiver.kernel.org>; Thu, 13 May 2021 12:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1BF61285
	for <linux-pm@archiver.kernel.org>; Thu, 13 May 2021 12:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhEMMNP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 May 2021 08:13:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbhEMMLZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 08:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23ACEB02C;
        Thu, 13 May 2021 12:10:12 +0000 (UTC)
Message-ID: <d150564ba71180cad5cf68e7b4c2821dcf5982aa.camel@suse.cz>
Subject: Re: [PATCH] cpufreq: intel_pstate: Force intel_pstate to load when
 HWP disabled in firmware
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 14:10:11 +0200
In-Reply-To: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
References: <20210513075930.22657-1-ggherdovich@suse.cz>
         <3fdc70c267d40561bed10fc722a8223a0b161200.camel@linux.intel.com>
         <bb90b6cac2f4adcc6c80b7fddf54dbe0a6b8ff66.camel@suse.cz>
         <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-05-13 at 04:03 -0700, Srinivas Pandruvada wrote:
> On Thu, 2021-05-13 at 12:10 +0200, Giovanni Gherdovich wrote:
> > [...]
> > An alternative approach to register intel_pstate in the case I'm
> > describing
> > would be to add ICELAKE_X (and every CPU model after that, forever?)
> > to the
> > list intel_pstate_cpu_ids.
>
> This is not nice, but unlike client server CPUs don't get released
> often. There is couple of years in between.

True.

> > [...]
> > The wording "hwp_broken_firmware" deliberately has a negative
> > connotation (the
> > intended meaning is: "firmware is broken, regarding HWP"), carrying
> > the
> > not-so-subtle message "OEM folks, please don't do this". My
> > understanding is
> > that the preferred way to disable HWP is with intel_pstate=no_hwp,
> > the
> > firmware should stay out of it.
>
> For me "broken" means that Intel has some bug, which is not the case,
> even if the intention is to carry message to OEM.
> 
> no_hwp is for disabling HWP even if the HWP is supported.
> 
> The problem is that if we override the supported CPU list using some
> kernel command line, some users may crash the system running on some
> old hardware where some of the MSRs we rely are not present. We don't
> read MSR in failsafe mode, so they will fault. We are checking some
> MSRs but not all.

Fair enough.

> Also what will be default
> (struct pstate_funcs *)id->driver_data if the cpu model doesn't match.

Whoops... You're totally right, the patch I sent is broken! "id" must be a
valid pstate_funcs* pointer, or some other default methods must be provided.

And besides...

> I think better to add CPU model instead. We did that for SKX on user
> requests.

... I agree. Let's just add ICX to the list of explicitly supported CPUs.
I'll send a new patch doing that, please discard this one.


Giovanni

