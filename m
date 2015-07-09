From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] Kernel splat when taking CPUs offline
Date: Thu, 9 Jul 2015 10:27:14 +0530
Message-ID: <20150709045714.GH1805@linux>
References: <20150708152456.4438d60f@gandalf.local.home>
 <1625417.XZkzNdoaJA@vostro.rjw.lan>
 <20150709040445.GG1805@linux>
 <20150709002552.32fa492c@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35281 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbGIE5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 00:57:20 -0400
Received: by pdrg1 with SMTP id g1so26448734pdr.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 21:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150709002552.32fa492c@grimm.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Saravana Kannan <skannan@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 09-07-15, 00:25, Steven Rostedt wrote:
> On Thu, 9 Jul 2015 09:34:45 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> 
> > I think it might be related to what I chased down yesterday:
> > 
> > http://marc.info/?l=linux-kernel&m=143633485824975&w=2
> > 
> > @Steven: Can you please give this a try ?
> > 
> 
> Yes that seems to fix my issue as well.
> 
> Tested-by: Steven Rostedt <rostedt@goodmis.org>

Awesome, so the problem was that cpufreq_set_policy() was failing
because of the latest bug I planted :), and that caused ->exit() but
didn't free the policy completely. (I have fixed that as well in a
separate patch).

And so you are hitting a policy which has already exited. Sorry about
that :)

-- 
viresh
