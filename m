From: Mason <slash.tmp@free.fr>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Thu, 29 Jun 2017 15:01:11 +0200
Message-ID: <136334fe-c2a7-875b-91e0-329a0d7a2304@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:63736 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbdF2NBY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jun 2017 09:01:24 -0400
In-Reply-To: <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 29/06/2017 13:41, Mason wrote:

> On 29/06/2017 12:04, Viresh Kumar wrote:
> 
>> There is one thing you can do to avoid adding OPP entries in the DT.
>> You can rather add them dynamically with help of: dev_pm_opp_add() and
>> cpufreq-dt will continue to work with that too.
> 
> In what driver should I call these... the clk driver?
> (drivers/clk/tegra/cvb.c seems to be doind that)

The problem I run into is that calling get_cpu_device(0) from the
clk driver returns NULL, because topology_init() has not run yet
(to initialize the cpu_sys_devices).

So the OPP table needs to be built *after* topology_init() but
*before* dt_cpufreq_probe().

subsys_initcall(topology_init);
device_initcall(cpufreq_dt_platdev_init);

I'm not sure how to proceed.

Regards.
