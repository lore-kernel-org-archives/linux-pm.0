From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] cpufreq: Reuse gov_attr_* macros in schedutil
 governor
Date: Thu, 19 May 2016 07:43:26 +0530
Message-ID: <20160519021326.GG24777@vireshk-i7>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
 <8db591e521218af3c4b21ccc0d50606bfbde106b.1463574213.git.viresh.kumar@linaro.org>
 <CAJZ5v0jtj8DnKjb6n8PYYw-Fx_aa=FJf3uvN+dtfLScfT4gVpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35087 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcESCNa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 22:13:30 -0400
Received: by mail-pa0-f44.google.com with SMTP id tb2so6189855pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 19:13:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jtj8DnKjb6n8PYYw-Fx_aa=FJf3uvN+dtfLScfT4gVpg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-05-16, 23:01, Rafael J. Wysocki wrote:
> On Wed, May 18, 2016 at 2:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > These macros can be used by governors which don't use the common
> > governor code present in cpufreq_governor.c and should be moved to the
> > relevant header.
> >
> > Now that they are getting moved to the right header file, reuse them in
> > schedutil governor as well (that required rename of show/store
> > routines).
> 
> I'm not sure what the benefit is to be honest.
> 
> It adds one level of indirection to the definition of rate_limit_us,
> but why is that better?

I agree.

I did it because I am required to use these macros for the
interactive-governor and have to move them to cpufreq.h anyway.

Now that we have to move them out, I thought that we should perhaps
use them for schedutil as well. This would look more relevant to
schedutil once it has more tunables instead of just one.

-- 
viresh
