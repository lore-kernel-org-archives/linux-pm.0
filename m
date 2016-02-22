From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Mon, 22 Feb 2016 22:18:22 +0530
Message-ID: <20160222164822.GV28226@vireshk-i7>
References: <000401d16bfc$21338450$639a8cf0$@net>
 <87a8mv9ujm.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
 <87egc6zc2q.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
 <56CA17D4.8080802@linux.intel.com>
 <87lh6du7lu.fsf@iki.fi>
 <20160222061637.GF28226@vireshk-i7>
 <871t84vgvq.fsf@iki.fi>
 <20160222164114.GU28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33233 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbcBVQsl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 11:48:41 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so95313199pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 08:48:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160222164114.GU28226@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 22-02-16, 22:11, Viresh Kumar wrote:
> > Thanks. I tried this, and somewhat surprisingly it doesn't change the
> > result. I guess we are back to doing a full bisect?
> 
> Good. That was kind of what I expected, so no surprise :)
> 
> I think bisect wouldn't be that difficult, please try :)

Okay, for record, I looked at all the patches that went into 4.5-rcs
into drivers/cpufreq/ directory and there is absolutely nothing in
there, that could have caused this. I suspect some x86 core changes
have broken this stuff.

-- 
viresh
