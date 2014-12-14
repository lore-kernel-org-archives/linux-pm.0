From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Sun, 14 Dec 2014 23:23:48 +0100
Message-ID: <7573578.UE8ufgjWuX@vostro.rjw.lan>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62236 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750857AbaLNWCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Dec 2014 17:02:11 -0500
In-Reply-To: <20141214213655.GA11285@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

On Sunday, December 14, 2014 09:36:55 PM Russell King - ARM Linux wrote:
> Here's a nice Christmas present one of my iMX6 machines gave me tonight.
> I haven't begun to look into it.
> 
> ======================================================
> [ INFO: possible circular locking dependency detected ]
> 3.18.0+ #1453 Not tainted
> -------------------------------------------------------
> rc.local/770 is trying to acquire lock:
>  (cooling_cpufreq_lock){+.+.+.}, at: [<c04abfc4>] cpufreq_thermal_notifier+0x34/0xfc
> 
> but task is already holding lock:
>  ((cpufreq_policy_notifier_list).rwsem){++++.+}, at: [<c0042f04>]  __blocking_notifier_call_chain+0x34/0x68
> 
> which lock already depends on the new lock.

Well, that's for Viresh.

Also adding Eduardo as he's been working with Viresh on the cooling stuff recently.

Rafael

