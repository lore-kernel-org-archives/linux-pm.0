Return-Path: <SRS0=ei9F=7S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952CDC433E0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Jun 2020 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C537207D0
	for <linux-pm@archiver.kernel.org>; Fri,  5 Jun 2020 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHAiRDHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgFEUeW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEUeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 16:34:22 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9CC08C5C2;
        Fri,  5 Jun 2020 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mw8VvWe7EE3uVg13FxiUrEz8BgF0q+z7XfuLsYKCdMs=; b=XHAiRDHRfrtWsqJ/5YI/J+wEym
        fa0fexDxTJwq+EdTS7AbxsFSe4+NNIUeHBU/6Rxr80OklDhzTfHrDx9rfj9NSAHJ1sEzKB3Fsr4u6
        uuB6SkvEOPuqg9UUbJSS7oXcrqYzKKDLrV065Z6kEWqNL7fkS7OZVR4ZQFImCgKTTGtdGdogA5nVU
        YPTBrWzCqBkNOdpvF6yG3rYiCeMxY1W4IuK89xhywUDqKsA0Bgd1ubp+pbpOE93I3yqPqG9Ef8bzv
        3qH49us5CbN4FNIv4YyIW05myBHUjNt//8ENJgJi93Gfqf2IVDhXIAa7NtDsxP4dwt/xCFNiIs0Wz
        P80sOuYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhJ2E-0003eW-T9; Fri, 05 Jun 2020 20:33:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65DBB30067C;
        Fri,  5 Jun 2020 22:33:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E18221A308C6; Fri,  5 Jun 2020 22:33:47 +0200 (CEST)
Date:   Fri, 5 Jun 2020 22:33:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, qperret@google.com,
        juri.lelli@redhat.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: schedutil issue with serial workloads
Message-ID: <20200605203347.GM3976@hirez.programming.kicks-ass.net>
References: <alpine.LNX.2.20.13.2006042341160.3984@monopod.intra.ispras.ru>
 <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 05, 2020 at 06:51:12PM +0200, Rafael J. Wysocki wrote:
> On 6/4/2020 11:29 PM, Alexander Monakov wrote:

> > this is a question/bugreport about behavior of schedutil on serial workloads
> > such as rsync, or './configure', or 'make install'. These workloads are
> > such that there's no single task that takes a substantial portion of CPU
> > time, but at any moment there's at least one runnable task, and overall
> > the workload is compute-bound. To run the workload efficiently, cpufreq
> > governor should select a high frequency.
> > 
> > Assume the system is idle except for the workload in question.
> > 
> > Sadly, schedutil will select the lowest frequency, unless the workload is
> > confined to one core with taskset (in which case it will select the
> > highest frequency, correctly though somewhat paradoxically).
> 
> That's because the CPU utilization generated by the workload on all CPUs is
> small.
> 
> Confining it to one CPU causes the utilization of this one to grow and so
> schedutil selects a higher frequency for it.

My initial question was why doesn't io-boosting fix this up, but a quick
look at our pipe code shows me that it doesn't seem to use
io_schedule().

That is currently our only means to express 'someone is waiting on us'
to which we then say 'lets hurry up a bit'.

Because, as you've found, if the tasks do not queue up, there is nothing
to push the frequency up.
