From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in of_cpumask_init_opp_table()
Date: Wed, 14 Oct 2015 23:28:51 +0200
Message-ID: <2178316.qF1soG5NSE@vostro.rjw.lan>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45333 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932399AbbJNVAJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:00:09 -0400
In-Reply-To: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Wednesday, October 14, 2015 05:52:23 PM Thomas Petazzoni wrote:
> The of_cpumask_init_opp_table() function will print an error message
> (with pr_err) if it cannot find the OPP table for a certain CPU in the
> Device Tree.
> 
> There are users of the cpufreq-dt driver (which is the one calling
> of_cpumask_init_opp_table) that do not have the OPP points defined in
> the Device Tree. Instead, such users dynamically create the OPP table
> at boot time depending on the system configuration. Such a case is
> planned in the cpufreq-dt driver, which on purpose ignores the return
> value of of_cpumask_init_opp_table() with the following comment: "OPPs
> might be populated at runtime, don't check for error here".
> 
> For such platforms, the of_cpumask_init_opp_table() prints a spurious
> and confusing error message for each CPU:
> 
> [    1.749548] of_cpumask_init_opp_table: couldn't find opp table for cpu:0, -19
> [    1.756784] of_cpumask_init_opp_table: couldn't find opp table for cpu:1, -19
> [    1.764031] of_cpumask_init_opp_table: couldn't find opp table for cpu:2, -19
> [    1.771268] of_cpumask_init_opp_table: couldn't find opp table for cpu:3, -19
> 
> This is confusing because everything is working fine, cpufreq works
> and it knows the OPP table that was registered at boot time (on
> Marvell Armada XP):
> 
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
> 666500 1884
> 1333000 23333
> 
> To avoid this confusion, this patch simply deletes the error message.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

That's only present in linux-next now, right?

Thanks,
Rafael

