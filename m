From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 4/9] PM / QOS: Add DEV_PM_QOS_PERFORMANCE request
Date: Thu, 20 Apr 2017 10:04:02 +0530
Message-ID: <20170420043402.GE5436@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <1dbed263e2fcc42906daaf584d3257c01aa11e13.1490001099.git.viresh.kumar@linaro.org>
 <CAPDyKFqH3PHeZ0T_63VgGRy_AUuDJ8WUCCovNRvBM2KCTJpG7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35881 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbdDTEeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 00:34:06 -0400
Received: by mail-io0-f174.google.com with SMTP id o22so56910913iod.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2017 21:34:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqH3PHeZ0T_63VgGRy_AUuDJ8WUCCovNRvBM2KCTJpG7g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>

On 19-04-17, 16:07, Ulf Hansson wrote:
> On 20 March 2017 at 10:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > @@ -571,6 +589,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
> >                 req = dev->power.qos->flags_req;
> >                 dev->power.qos->flags_req = NULL;
> >                 break;
> > +       case DEV_PM_QOS_PERFORMANCE:
> > +               dev_err(dev, "Invalid user request (performance)\n");
> > +               return;
> 
> Isn't it possible to drop a performance request?

I am not exposing the performance QOS via sysfs. Should we ? I thought
this has to be worked out within kernel only and so haven't provided
any user interface.

> > @@ -96,9 +98,11 @@ struct pm_qos_flags {
> >  struct dev_pm_qos {
> >         struct pm_qos_constraints resume_latency;
> >         struct pm_qos_constraints latency_tolerance;
> > +       struct pm_qos_constraints performance;
> >         struct pm_qos_flags flags;
> >         struct dev_pm_qos_request *resume_latency_req;
> >         struct dev_pm_qos_request *latency_tolerance_req;
> > +       struct dev_pm_qos_request *performance_req;
> 
> I didn't find performance_req being used at all...

I just over-copied it seems. The OPP framework creates its own request
structure and so this should be dropped.

-- 
viresh
