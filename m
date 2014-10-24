From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 0/2] cpufreq: cpufreq-dt: Improvements for set_target()
Date: Fri, 24 Oct 2014 09:21:04 +0200
Message-ID: <5449FDE0.9020101@i2se.com>
References: <1413583789-24294-1-git-send-email-stefan.wahren@i2se.com> <CAKohpokjczrGvZ6e7JOwkPtq1-MC0Cr_s+bp=wwKt4x+FdumWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62578 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaJXHUw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 03:20:52 -0400
In-Reply-To: <CAKohpokjczrGvZ6e7JOwkPtq1-MC0Cr_s+bp=wwKt4x+FdumWQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Am 20.10.2014 um 06:43 schrieb Viresh Kumar:
> On 18 October 2014 03:39, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> This patch series contains 2 improvements for set_target().
>>
>> changes in V2:
>>   - rebase because of name change cpufreq-cpu0 to cpufreq-dt
>>
>> Stefan Wahren (2):
>>   cpufreq: cpufreq-dt: Improve debug about matching OPP
>>   cpufreq: cpufreq-dt: Handle regulator_get_voltage() failure
>>
>>  drivers/cpufreq/cpufreq-dt.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks. But maybe the patch series won't apply anymore.

Should i rebase again?

Stefan

