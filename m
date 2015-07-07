From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] acpi-cpufreq.c: fix a memory leak in
 acpi_cpufreq_cpu_exit
Date: Tue, 7 Jul 2015 12:24:49 +0530
Message-ID: <20150707065449.GD14598@linux>
References: <559A2073.1000301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34084 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbGGGy5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 02:54:57 -0400
Received: by pabvl15 with SMTP id vl15so108309410pab.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2015 23:54:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559A2073.1000301@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On 06-07-15, 14:30, Pan Xinhui wrote:
> 
> policy->cpu in acpi_cpufreq_cpu_init/exit is the same cpu in most cases.
> However during cpu hotplug,
> cpufreq core might nominate a new cpu for policy->cpu.

Why aren't above lines well aligned? A simple trick to share for vim
users:

- Select lines you want to auto-align with shift+v and up-down keys
- press gq
- That's it and vim will do it for you. You need to set vim's
  'textwidth' to 72 or 80, based on what you are editing, so that vim
  knows where you need to break the line. I have this in vimrc

        set textwidth=80
        au FileType gitcommit set textwidth=72



Back to the real stuff. Few core changes have gone into v4.2-rc1 and
policy->cpu doesn't change any longer on hotplug (unless its a
physical hotplug). So you shouldn't see any issues.

-- 
viresh
