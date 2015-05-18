From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 14/14] cpufreq: Add support for physical hoplug of CPUs
Date: Mon, 18 May 2015 07:41:07 +0530
Message-ID: <20150518021107.GA5102@linux>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
 <3771347.4CYzBDSQ1Q@vostro.rjw.lan>
 <20150516021307.GE4600@linux>
 <6810633.U8XLCHe8Cd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35022 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbERCLM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2015 22:11:12 -0400
Received: by pdea3 with SMTP id a3so126419287pde.2
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 19:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6810633.U8XLCHe8Cd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 18-05-15, 02:30, Rafael J. Wysocki wrote:
> Well, if the sysfs directories are removed on every offline, then in particular
> they will be removed when the device is physically going away, so it should
> actually work (unless we've broken it already and nobody noticed).

The problem is that the remove routine is called twice and I thought
it might not be safe to call it twice. Ofcourse I missed the
cpu_offline() checks in the sysfs removal path.

> If you want to keep them around after offline, you need to become careful
> about the "physical hot-remove" case at the same time (and not several patches
> later).

Sure, will do that today.

-- 
viresh
