From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Mon, 22 Jan 2018 11:03:08 +0000
Message-ID: <20180122110307.GA31111@e108498-lin.cambridge.arm.com>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-3-quentin.perret@arm.com>
 <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeAVLDQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 06:03:16 -0500
Content-Disposition: inline
In-Reply-To: <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On Friday 19 Jan 2018 at 15:15:41 (-0800), Joel Fernandes wrote:
> > @@ -675,18 +668,15 @@ __cpufreq_cooling_register(struct device_node *np,
> >                         pr_debug("%s: freq:%u KHz\n", __func__, freq);
> >         }
> >
> > -       if (capacitance) {
> > -               ret = update_freq_table(cpufreq_cdev, capacitance);
> > -               if (ret) {
> > -                       cdev = ERR_PTR(ret);
> > -                       goto remove_ida;
> > -               }
> > -
> > -               cooling_ops = &cpufreq_power_cooling_ops;
> > -       } else {
> > -               cooling_ops = &cpufreq_cooling_ops;
> 
> Instead of this, is it better to add an API to OPP library to query it
> if it has power data for all OPPs? Then you don't need to have a
> 'found_power' variable and also don't unnecessarily call
> dev_pm_opp_find_freq_ceil in update_freq_table.

I had an API that looked like that in v1 and v2 (not used here though)
but we agreed with Viresh that it wasn't absolutely necessary so I got
rid of it. I'm not sure how I can avoid to call dev_pm_opp_find_freq_ceil
though. What did you mean by that ?

Thanks,
Quentin
