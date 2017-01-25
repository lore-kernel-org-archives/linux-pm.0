From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Delayed acpi frequency governor call
Date: Wed, 25 Jan 2017 08:53:41 +0530
Message-ID: <20170125032341.GC20040@vireshk-i7>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
 <20170123101145.GB26681@vireshk-i7>
 <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
 <20170124042235.GA16906@vireshk-i7>
 <2f9b2f69-8b93-c77a-a09f-540240fecf1e@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36062 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdAYDXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 22:23:45 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so54771853pfu.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2017 19:23:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2f9b2f69-8b93-c77a-a09f-540240fecf1e@tik.ee.ethz.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 24-01-17, 15:49, Philipp Miedl wrote:
> Can you please describe how things changed from version 4.4 to 4.9 - I'm not
> sure if I understand correctly.
> Before 4.7 the governor was just running as a kernel process and triggered
> by the (free running) timers and
> now its hooked with the scheduler. So the scheduler ensures that the
> governor work is not delayed?!

Now the cpufreq callbacks gets called from within the scheduler every few
milliseconds. And once we have crossed the sampling-rate time, we reevaluate the
frequency. Though ondemand/conservative governors still used workqueue until
very recently for most of the platforms. Recently it is replaced by a RT thread.

-- 
viresh
