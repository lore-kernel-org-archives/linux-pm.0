From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Wed, 29 Jul 2015 19:51:48 +0530
Message-ID: <20150729142148.GF5100@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <4080510.IQ60sVQvbL@vostro.rjw.lan>
 <20150727143935.GB18535@linux>
 <2112385.YuDJ7h1x56@vostro.rjw.lan>
 <20150729091136.GN7557@n2100.arm.linux.org.uk>
 <CAJZ5v0iUn0rSVSqyXscCfGgujpM7r9o9xjQgDOk+JQ=y6seRgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35636 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbG2OVy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 10:21:54 -0400
Received: by pabkd10 with SMTP id kd10so6550742pab.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 07:21:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iUn0rSVSqyXscCfGgujpM7r9o9xjQgDOk+JQ=y6seRgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 29-07-15, 15:57, Rafael J. Wysocki wrote:
> In practice, this means a cpufreq driver registration done in parallel
> with CPU hotplug.

Not necessarily. Also consider the case where cpufreq driver is already working
for a set of CPUs. And a new set of CPUs (that will share the policy) are
getting physically added to the system.

Anyway, even if there is no problem at all, I do agree with Russell that it will
be better to do operations on behalf of the devices only when we are requested
for those devices.

-- 
viresh
