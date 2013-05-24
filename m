From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix governor start/stop race condition
Date: Fri, 24 May 2013 11:01:35 +0530
Message-ID: <CAKohpok_7pQHD3T+r2us0xOmKRQpm-0azEVbh4osFjWiO0nS9w@mail.gmail.com>
References: <1368442050-16548-1-git-send-email-chenxg@marvell.com>
	<51947935.50607@marvell.com>
	<CAKohpokR0igX3Z4P9eyoJikmBwnG90eN003wAaJW-Ynu7zU7Aw@mail.gmail.com>
	<519D8287.5020004@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:40340 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3EXFbg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2013 01:31:36 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so1742653obc.20
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2013 22:31:36 -0700 (PDT)
In-Reply-To: <519D8287.5020004@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiaoguang Chen <chenxg@marvell.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ning Jiang <njiang1@marvell.com>, Yilu Mao <ylmao@marvell.com>, Zhoujie Wu <zjwu@marvell.com>

On 23 May 2013 08:14, Xiaoguang Chen <chenxg@marvell.com> wrote:
> Do you mean my patch will cause deadlock? I once tried to add another lock
> to protect the GOV_STOP/START sequence instead of using the rwsem in this
> patch.
> But I saw deadlock indeed.
> In cpufreq_add_policy_cpu, the lock has to be added before the rwsem since
> GOV_STOP is
> before lock_policy_rwsem_write, but in cpufreq_update_policy, it will first
> get the rwsem, and then
> call __cpufreq_set_policy which will contain GOV_STOP again, if we add the
> new lock before this GOV_STOP,
> then we may get deadlock in below sequence:
> 1) hotplug in one cpu by calling cpufreq_add_policy_cpu in which new lock is
> locked first then rwsem is locked.
> 2) governor change in cpufreq_update_policy in which rwsem is locked first
> then new lock is locked.
> this is a deadlock issue if above two steps interleaves

Check this patch.

https://patchwork-mail.kernel.org/patch/2575231/
