From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: drivers/cpufreq/cpufreq.c:51:17: sparse: symbol
 'cpufreq_online_mask' was not declared. Should it be static?
Date: Fri, 11 Jan 2013 19:38:26 +0530
Message-ID: <CAKohponzGnFdzAk0PzTsvrt9PA2OH1Aaa9VQh4+En3KdGbJwFA@mail.gmail.com>
References: <50f017f7.SoVcNexmm6uNvfQX%yuanhan.liu@linux.intel.com>
	<20130111140301.GA25489@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48967 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab3AKOI1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jan 2013 09:08:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so1756152obb.33
        for <linux-pm@vger.kernel.org>; Fri, 11 Jan 2013 06:08:26 -0800 (PST)
In-Reply-To: <20130111140301.GA25489@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On 11 January 2013 19:33, Fengguang Wu <fengguang.wu@intel.com> wrote:
> FYI, there are new sparse warnings show up in
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> head:   f3bb59ab652c781155b1c5e42ef7e29bf936d86b
> commit: 536ff06aba714c1d2d53cfca86b1a2e455842387 cpufreq: Don't use cpu removed during cpufreq_driver_unregister
> date:   15 hours ago
>
> drivers/cpufreq/cpufreq.c:43:8: sparse: symbol 'cpufreq_cpu_data' was not declared. Should it be static?
>    drivers/cpufreq/cpufreq.c:46:8: sparse: symbol 'cpufreq_cpu_governor' was not declared. Should it be static?
>>> drivers/cpufreq/cpufreq.c:51:17: sparse: symbol 'cpufreq_online_mask' was not declared. Should it be static?
>    drivers/cpufreq/cpufreq.c:72:8: sparse: symbol 'cpufreq_policy_cpu' was not declared. Should it be static?
>    drivers/cpufreq/cpufreq.c:73:8: sparse: symbol 'cpu_policy_rwsem' was not declared. Should it be static?
>
> Please consider folding the attached diff :-)

Thanks for the fix :)
@Rafael: I hope you can apply that?
