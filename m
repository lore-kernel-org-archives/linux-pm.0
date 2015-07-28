From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/7] cpufreq: Separate CPU device removal from CPU online
Date: Tue, 28 Jul 2015 07:36:44 +0530
Message-ID: <20150728020644.GL18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1739669.kedIsxdRK2@vostro.rjw.lan>
 <20150727150655.GI18535@linux>
 <CAJZ5v0gT4e2=VRPcF5S2fSBUiNZ3+dAeOrt5rRy_PAT5-+Y4Ow@mail.gmail.com>
 <CAJZ5v0hJYpY7k1+zM41oG=sSM=Zhf4LXZH9FBJFL4O7H2cTJfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35376 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbbG1CGs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 22:06:48 -0400
Received: by pdrg1 with SMTP id g1so61603770pdr.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 19:06:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hJYpY7k1+zM41oG=sSM=Zhf4LXZH9FBJFL4O7H2cTJfg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 23:56, Rafael J. Wysocki wrote:
> OK, I've just seen that patch, but it doesn't modify bus_probe_device() AFAICS.

Why is bus_probe_device() required to be modified?

I wrote this patch to propagate -EPROBE_DEFER from the ->init()
callback, which is called from cpufreq_register_driver().

And that worked after my patch..

> Plus we also ignore the return value of cpufreq_add_dev() in the
> hotplug notifier callback.

My use case needed it for the subsys callback.

-- 
viresh
