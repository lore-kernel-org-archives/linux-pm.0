From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: cpufreq v3.17-rc7 error: "cpufreq: cpufreq_resume: Failed to
 start governor for policy: f6909a00"
Date: Thu, 02 Oct 2014 13:55:11 +0200
Message-ID: <1412250911.3060.13.camel@x41>
References: <1412250350.3060.9.camel@x41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:58791 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208AbaJBLzO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 07:55:14 -0400
In-Reply-To: <1412250350.3060.9.camel@x41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Bolle schreef op do 02-10-2014 om 13:45 [+0200]:
> Running v3.17-rc7 I see a new (for me) error, apparently during each
> resume (from suspend) or thaw (from hibernate):
>      cpufreq: cpufreq_resume: Failed to start governor for policy: f6909a00

So there are only two recent commits:
    7106e02baed4 ("cpufreq: release policy->rwsem on error")
    8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for
        intel_pstate")

Would it be useful to test whether reverting the oldest commit,
8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate"),
changes anything?


Paul Bolle

