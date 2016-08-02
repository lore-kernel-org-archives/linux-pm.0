From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Tue, 2 Aug 2016 17:41:24 -0600
Message-ID: <5a559b20-28f5-5b51-6b8e-11d7884709ab@codeaurora.org>
References: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
 <1547887.jMFZtBx5tV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57772 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbcHBXwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 19:52:13 -0400
In-Reply-To: <1547887.jMFZtBx5tV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

Hi Rafael,

On 8/2/2016 5:27 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 02, 2016 05:18:57 PM Prashanth Prakash wrote:
>> cpufreq drivers such as CPPC works on contigious scale and does
>> not have a static frequency table. This commit adds cpufreq_stats
>> support for such drivers by creating a pseudo frequency table by
>> discretizing the contigious scale.
> No.
>
> And why?
The motivation is to be able to collect the frequency distribution data via
time_in_state sysfs entry as we can collect for other cpufreq drivers that
uses a frequency table.

Thanks,
Prashanth
