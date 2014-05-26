From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: governor: Be friendly towards latency-sensitive bursty workloads
Date: Tue, 27 May 2014 01:27:54 +0200
Message-ID: <2902116.OdbNv5KQzQ@vostro.rjw.lan>
References: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55682 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751266AbaEZXKv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 19:10:51 -0400
In-Reply-To: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: viresh.kumar@linaro.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Srivatsa,

On Tuesday, May 27, 2014 02:23:38 AM Srivatsa S. Bhat wrote:
> Cpufreq governors like the ondemand governor calculate the load on the CPU
> periodically by employing deferrable timers. A deferrable timer won't fire
> if the CPU is completely idle (and there are no other timers to be run), in
> order to avoid unnecessary wakeups and thus save CPU power.
> 
> However, the load calculation logic is agnostic to all this, and this can
> lead to the problem described below.

This is subtle enough that I need some more time to chew on it, but since the
merge window is coming, I'm not sure when that's going to happen honestly.

Rafael

