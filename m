From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: stats: do cpufreq_cpu_put() corresponding to cpufreq_cpu_get
Date: Fri, 22 Mar 2013 13:12:30 +0100
Message-ID: <2999694.A2YTRdtkxt@vostro.rjw.lan>
References: <234906745c34fb72b0c450d897f261a22ed18d40.1363947023.git.viresh.kumar@linaro.org> <38998218.UX7TkEXzYs@vostro.rjw.lan> <CAKohpo=TFO5CEtO_tDxTthC3K01yh08v9h7hXr2Oq4zffgb2OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33408 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab3CVMFK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Mar 2013 08:05:10 -0400
In-Reply-To: <CAKohpo=TFO5CEtO_tDxTthC3K01yh08v9h7hXr2Oq4zffgb2OQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, linux-pm@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Steve Bannister <Steve.Bannister@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>

On Friday, March 22, 2013 05:25:13 PM Viresh Kumar wrote:
> On 22 March 2013 17:29, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Sure.  Can you please remind me what hardware is that, though?
> 
> Not yet upstreamed: big LITTLE :)
> 
> But, this is broken for all other platforms too.. You just need to compile
> your driver as module and insmod/remove it to call
> cpufreq_driver_unregister().

Which would be useful to write in the changelog, wouldn't it?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
