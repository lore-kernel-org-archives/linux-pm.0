From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Ensure sufficiently large sampling
 intervals
Date: Mon, 18 Dec 2017 10:08:03 +0530
Message-ID: <20171218043803.GD19815@vireshk-i7>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <002001d37577$9706a730$c513f590$@net>
 <002501d375d2$54f942c0$feebc840$@net>
 <5893809.nB6uDLgMiy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33043 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdLREiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Dec 2017 23:38:06 -0500
Received: by mail-pl0-f65.google.com with SMTP id 1so2685382plv.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2017 20:38:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5893809.nB6uDLgMiy@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, 'Andy Tang' <andy.tang@nxp.com>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

On 18-12-17, 02:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit aa7519af450d (cpufreq: Use transition_delay_us for legacy
> governors as well) the sampling_rate field of struct dbs_data may be
> less than the tick period which causes dbs_update() to produce
> incorrect results, so make the code ensure that the value of that
> field will always be sufficiently large.
> 
> Fixes: aa7519af450d (cpufreq: Use transition_delay_us for legacy governors as well)
> Reported-by: Andy Tang <andy.tang@nxp.com>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
