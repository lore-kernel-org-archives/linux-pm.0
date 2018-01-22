From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Mon, 22 Jan 2018 10:41:26 +0530
Message-ID: <20180122051126.GD2421@vireshk-i7>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-3-quentin.perret@arm.com>
 <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:47023 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeAVFL3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 00:11:29 -0500
Received: by mail-pg0-f43.google.com with SMTP id s9so6228623pgq.13
        for <linux-pm@vger.kernel.org>; Sun, 21 Jan 2018 21:11:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On 19-01-18, 15:15, Joel Fernandes wrote:
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

> also don't unnecessarily call
> dev_pm_opp_find_freq_ceil in update_freq_table.

He would need that anyway as he needs to get the real power numbers.

-- 
viresh
