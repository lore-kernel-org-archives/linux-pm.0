From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH 7/7] cpufreq: Separate CPU device registration
 from CPU online
Date: Tue, 28 Jul 2015 16:13:48 +0200
Message-ID: <CAJZ5v0h4GobCKg1R_DQZtYaQ9H56yJ5NG3VVqVWDjnazSv9d=A@mail.gmail.com>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
	<3874727.Jpay9zgokc@vostro.rjw.lan>
	<1739669.kedIsxdRK2@vostro.rjw.lan>
	<1702607.RH80fBCN6J@vostro.rjw.lan>
	<20150728022056.GN18535@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34547 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbG1ONt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 10:13:49 -0400
In-Reply-To: <20150728022056.GN18535@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Viresh,

On Tue, Jul 28, 2015 at 4:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-15, 23:55, Rafael J. Wysocki wrote:
>> +static void cpufreq_online(unsigned int cpu)
>
> As I said in the earlier message, I need the return value of this to
> be used for add_dev() callback. Which is required to retry probing the
> device if it wasn't ready on a earlier call, i.e. it returns
> -EPROBE_DEFER. My other patch already fixes the subsys layer for this.

If this is the patch I've looked at, it doesn't fix this.  It only
fixes one case.

It also doesn't fix the hotplug notifier failure case.

I can retain the return value, but we need to be consistent about using it.

Thanks,
Rafael
