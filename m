From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Revert "cpufreq: postfix policy directory with the first
 CPU in related_cpus"
Date: Wed, 9 Mar 2016 14:12:19 +0100
Message-ID: <CAJZ5v0gh41=19yHaZFRyxNd7uiVcU8sxhMpiZS64y+RYGYzBnA@mail.gmail.com>
References: <eb862848df536cb2921945cca690161014c84750.1456996795.git.viresh.kumar@linaro.org>
	<20160309093927.GI23015@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33147 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbcCINMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 08:12:25 -0500
In-Reply-To: <20160309093927.GI23015@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 9, 2016 at 10:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 03-03-16, 14:51, Viresh Kumar wrote:
>> This reverts commit 3510fac45492 ("cpufreq: postfix policy directory
>> with the first CPU in related_cpus").
>>
>> Earlier, the policy->kobj was added to the kobject core, before ->init()
>> callback was called for the cpufreq drivers. Which allowed those drivers
>> to add or remove, driver dependent, sysfs files/directories to the same
>> kobj from their ->init() and ->exit() callbacks.
>>
>> That isn't possible anymore after commit 3510fac45492 got applied.
>>
>> Now, there is no other clean alternative that people can adopt.
>>
>> Its better to revert the earlier commit to allow cpufreq drivers to
>> create/remove sysfs files from ->init() and ->exit() callbacks.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Sorry about missing SoB (Just noticed it in bleeding-edge).

For a revert that's not a problem, but I'll add it.

Thanks,
Rafael
