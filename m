From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 20:05:23 +0530
Message-ID: <20170629143523.GN29665@vireshk-i7>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <136334fe-c2a7-875b-91e0-329a0d7a2304@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36220 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF2Of1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 10:35:27 -0400
Received: by mail-pg0-f44.google.com with SMTP id u62so48918609pgb.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 07:35:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <136334fe-c2a7-875b-91e0-329a0d7a2304@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 29-06-17, 15:01, Mason wrote:
> On 29/06/2017 13:41, Mason wrote:
> 
> > On 29/06/2017 12:04, Viresh Kumar wrote:
> > 
> >> There is one thing you can do to avoid adding OPP entries in the DT.
> >> You can rather add them dynamically with help of: dev_pm_opp_add() and
> >> cpufreq-dt will continue to work with that too.
> > 
> > In what driver should I call these... the clk driver?
> > (drivers/clk/tegra/cvb.c seems to be doind that)
> 
> The problem I run into is that calling get_cpu_device(0) from the
> clk driver returns NULL, because topology_init() has not run yet
> (to initialize the cpu_sys_devices).
> 
> So the OPP table needs to be built *after* topology_init() but
> *before* dt_cpufreq_probe().
> 
> subsys_initcall(topology_init);
> device_initcall(cpufreq_dt_platdev_init);
> 
> I'm not sure how to proceed.

As we discussed over IRC, you can control the creation of cpufreq-dt
platform device and hence when the cpufreq-dt driver gets probed. Your
own cpufreq driver is the way to go here.

-- 
viresh
