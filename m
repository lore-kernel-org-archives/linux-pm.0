From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Wed, 03 Aug 2016 01:27:45 +0200
Message-ID: <1547887.jMFZtBx5tV@vostro.rjw.lan>
References: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46797 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754585AbcHBX3P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 19:29:15 -0400
In-Reply-To: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

On Tuesday, August 02, 2016 05:18:57 PM Prashanth Prakash wrote:
> cpufreq drivers such as CPPC works on contigious scale and does
> not have a static frequency table. This commit adds cpufreq_stats
> support for such drivers by creating a pseudo frequency table by
> discretizing the contigious scale.

No.

And why?

Thanks,
Rafael

