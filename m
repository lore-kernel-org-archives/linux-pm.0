From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Allow accessing freq_table for offline CPUs
Date: Fri, 10 Jul 2015 02:10:43 +0200
Message-ID: <1701322.hsK9gPMk5I@vostro.rjw.lan>
References: <c07ccbe7f415d20e055c9d1ba025a71b902e6b0f.1436340899.git.viresh.kumar@linaro.org> <2953689.ETebrTym45@vostro.rjw.lan> <20150709051356.GK1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51127 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751198AbbGIXoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 19:44:13 -0400
In-Reply-To: <20150709051356.GK1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Thursday, July 09, 2015 10:43:56 AM Viresh Kumar wrote:
> On 09-07-15, 02:40, Rafael J. Wysocki wrote:
> > The above sentence is completely unclear to anyone unfamiliar with the
> > code in question.
> > 
> > The fix is to access the policy data structure for the given CPU directly
> > (which also returns a valid policy for offline CPUs), but the policy
> > itself has to be active (meaning that at least one CPU using it is online)
> > for the frequency table to be returned.
> > 
> > Right?
> 
> Yeah..

Applied with minor tweaks to the subject & changelog, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
