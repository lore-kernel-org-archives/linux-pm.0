Return-Path: <SRS0=/aHr=64=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF8C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 14 May 2020 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3633820734
	for <linux-pm@archiver.kernel.org>; Thu, 14 May 2020 11:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENLud (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 14 May 2020 07:50:33 -0400
Received: from foss.arm.com ([217.140.110.172]:34948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLud (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 07:50:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987D630E;
        Thu, 14 May 2020 04:50:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124FA3F305;
        Thu, 14 May 2020 04:50:30 -0700 (PDT)
References: <20200428032258.2518-1-currojerez@riseup.net> <20200511105701.GA2940@hirez.programming.kicks-ass.net> <874ksmuqx6.fsf@riseup.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Lukasz Luba <Lukasz.Luba@arm.com>
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the intel_pstate driver (v2.99)
In-reply-to: <874ksmuqx6.fsf@riseup.net>
Date:   Thu, 14 May 2020 12:50:25 +0100
Message-ID: <jhjwo5erb0e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


(+Lukasz)

On 11/05/20 22:01, Francisco Jerez wrote:
>> What I'm missing is an explanation for why this isn't using the
>> infrastructure that was build for these kinds of things? The thermal
>> framework, was AFAIU, supposed to help with these things, and the IPA
>> thing in particular is used by ARM to do exactly this GPU/CPU power
>> budget thing.
>>
>> If thermal/IPA is found wanting, why aren't we improving that?
>
> The GPU/CPU power budget "thing" is only a positive side effect of this
> series on some TDP-bound systems.  Its ultimate purpose is improving the
> energy efficiency of workloads which have a bottleneck on a device other
> than the CPU, by giving the bottlenecking device driver some influence
> over the response latency of CPUFREQ governors via a PM QoS interface.
> This seems to be completely outside the scope of the thermal framework
> and IPA AFAIU.
>

It's been a while since I've stared at IPA, but it does sound vaguely
familiar.

When thermally constrained, IPA figures out a budget and splits it between
actors (cpufreq and devfreq devices) depending on how much juice they are
asking for; see cpufreq_get_requested_power() and
devfreq_cooling_get_requested_power(). There's also some weighing involved.

If you look at the cpufreq cooling side of things, you'll see it also uses
the PM QoS interface. For instance, should IPA decide to cap the CPUs
(perhaps because say the GPU is the one drawing most of the juice), it'll
lead to a maximum frequency capping request.

So it does sound like that's what you want, only not just when thermally
constrained.
