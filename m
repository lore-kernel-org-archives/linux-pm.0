From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 0/2] cpufreq: Sort policy->freq_table
Date: Wed, 08 Jun 2016 02:19:51 +0200
Message-ID: <27658050.4ol4GjkJ1n@vostro.rjw.lan>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59459 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753712AbcFHAPw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 20:15:52 -0400
In-Reply-To: <cover.1465295033.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org

On Tuesday, June 07, 2016 03:55:13 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> I have spent some more time on this stuff and finally came out with a
> very simple solution. I hope you will like it more than the previous
> versions.
> 
> Instead of trying to sort the freq-table passed by the drivers, which
> was complicated and would have broken some drivers for sure, this patch
> just checks if the freq-table is sorted or not.
> 
> If it is sorted, then we just use a different set of helpers for it. The
> table can be sorted in both ascending and descending orders now and
> helpers are present for both the cases.

Well, that's something I was thinking about from the start. :-)

> All the patches are pushed here for testing in case anyone wants to try:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table
> 
> V3->V4:
> - Written from scratch really, completely different approach.

I'll look at the code later this week.

Thanks,
Rafael

