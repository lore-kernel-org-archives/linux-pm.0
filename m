Return-Path: <SRS0=+SOU=6Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D833C54E4B
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D0320736
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMThPhoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKK5M (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 May 2020 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKK5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 06:57:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F61C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NgxUJK4Gufs1lsI78fSnObijojqUBqcEKYBaQKCWPGk=; b=WMThPhoA7SSSDN8xnuHz+ITH8L
        1+akJTwEnAUroSL1OLxBQD8h9xLQ26kL43J/4NNjfz9p3CiW6hrF2uLPun6C8IiRgKpIYHTNVQDEN
        jZ1vLZ/0GmtfN/DuM3Uu1ZKh6Vl7eN83rnd7jT3Z5dBWfqxwioFtKfAGKC+2BE74ftSkO3aNAjm56
        Pkyv5BF8KB8N+93JReheYxMb/dUppB0XtfhBzds4XUMh0ucbev09clVyR3lQA1o3Wo0Jmr6LdajyV
        oeSAGh/VhqnPWKw1sz6WNEIZjungHWNllHGjKQJnH8P9uv4rwsXU8AlTSjq+um3ghfFqsOU8Pod9S
        Xl8nJVtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY67N-0003Oa-6s; Mon, 11 May 2020 10:57:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D82EF3010C8;
        Mon, 11 May 2020 12:57:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E9EC200FC689; Mon, 11 May 2020 12:57:01 +0200 (CEST)
Date:   Mon, 11 May 2020 12:57:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Subject: Re: [RFC] GPU-bound energy efficiency improvements for the
 intel_pstate driver (v2.99)
Message-ID: <20200511105701.GA2940@hirez.programming.kicks-ass.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 08:22:47PM -0700, Francisco Jerez wrote:
> This addresses the technical concerns people brought up about my
> previous v2 revision of this series.  Other than a few bug fixes, the
> only major change relative to v2 is that the controller is now exposed
> as a new CPUFREQ generic governor as requested by Rafael (named
> "adaptive" in this RFC though other naming suggestions are welcome).
> Main reason for calling this v2.99 rather than v3 is that I haven't
> yet addressed all the documentation requests from the v2 thread --
> Will spend some time doing that as soon as I have an ACK (ideally from
> Rafael) that things are moving in the right direction.
> 
> You can also find this series along with the WIP code for non-HWP
> platforms in this branch:
> 
> https://github.com/curro/linux/tree/intel_pstate-vlp-v2.99
> 
> Thanks!
> 
> [PATCHv2.99 01/11] PM: QoS: Add CPU_SCALING_RESPONSE global PM QoS limit.
> [PATCHv2.99 02/11] drm/i915: Adjust PM QoS scaling response frequency based on GPU load.
> [PATCHv2.99 03/11] OPTIONAL: drm/i915: Expose PM QoS control parameters via debugfs.
> [PATCHv2.99 04/11] cpufreq: Define ADAPTIVE frequency governor policy.
> [PATCHv2.99 05/11] cpufreq: intel_pstate: Reorder intel_pstate_clear_update_util_hook() and intel_pstate_set_update_util_hook().
> [PATCHv2.99 06/11] cpufreq: intel_pstate: Call intel_pstate_set_update_util_hook() once from the setpolicy hook.
> [PATCHv2.99 07/11] cpufreq: intel_pstate: Implement VLP controller statistics and target range calculation.
> [PATCHv2.99 08/11] cpufreq: intel_pstate: Implement VLP controller for HWP parts.
> [PATCHv2.99 09/11] cpufreq: intel_pstate: Enable VLP controller based on ACPI FADT profile and CPUID.
> [PATCHv2.99 10/11] OPTIONAL: cpufreq: intel_pstate: Add tracing of VLP controller status.
> [PATCHv2.99 11/11] OPTIONAL: cpufreq: intel_pstate: Expose VLP controller parameters via debugfs.

What I'm missing is an explanation for why this isn't using the
infrastructure that was build for these kinds of things? The thermal
framework, was AFAIU, supposed to help with these things, and the IPA
thing in particular is used by ARM to do exactly this GPU/CPU power
budget thing.

If thermal/IPA is found wanting, why aren't we improving that?

How much of that ADAPTIVE crud is actually intel_pstate specific? On a
(really) quick read it appears to me that much of the controller bits
there can be applied more generic, and thus should not be part of any
one governor.

Specifically, I want to use sched_util as cpufreq governor and use the
intel_pstate as a passive driver.


