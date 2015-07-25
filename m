From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/9] Platform support for thermal management on Junoe
Date: Sat, 25 Jul 2015 06:57:27 +0530
Message-ID: <20150725012727.GB14916@linux>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
 <20150723092930.GM5322@linux>
 <9hhk2tpbpzf.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35291 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbGYB1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 21:27:32 -0400
Received: by pdrg1 with SMTP id g1so21254996pdr.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2015 18:27:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9hhk2tpbpzf.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, edubezval@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com, linux@roeck-us.net

On 24-07-15, 15:16, Punit Agrawal wrote:
> Hi Viresh,
> 
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 22-07-15, 15:02, Punit Agrawal wrote:
> >>   cpufreq-dt: Supply power coefficient when registering cooling devices
> >>   cpufreq: arm_big_little: Add support to register a cpufreq cooling
> >>     device
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks for the acks.
> 
> Once the device tree property is agreed upon, will you be picking up these
> patches?

Since it is already present in patchwork, Rafael can apply these.

-- 
viresh
