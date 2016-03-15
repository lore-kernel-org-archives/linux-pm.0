From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in
 cpufreq_resume()
Date: Tue, 15 Mar 2016 13:10:59 +0700
Message-ID: <20160315061059.GB13831@vireshk-mac-ubuntu>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34164 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbcCOGLJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 02:11:09 -0400
Received: by mail-pf0-f173.google.com with SMTP id x3so14369336pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2016 23:11:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 12-03-16, 03:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> cpufreq_resume() attempts to resync the current frequency with
> policy->cur for the first online CPU, but first it does that after
> restarting governors for all active policies (which means that this
> is racy with respect to whatever the governors do) and second it

Why? Its doing the update withing policy->rwsem ..

> already is too late for that when cpufreq_resume() is called (that
> happens after invoking ->resume callbacks for all devices in the
> system).
> 
> Also it doesn't make sense to do that for one CPU only in any case,
> because the other CPUs in the system need not share the policy with
> it and their policy->cur may be out of sync as well in principle.

Its done just for the boot CPU, because that's the only CPU that goes to
suspend. All other CPUs are disabled/enabled and so the policies are
reinitialized for policy->cur as well.

I think, its still important to get things in sync, as some bootloader may
change the frequency to something else during resume.

And our code may not be safe for the case, the current frequency of the CPU
isn't part of the freq-table of the policy.

-- 
viresh
