From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/12] PM / OPP: Add 'struct kref' to struct dev_pm_opp
Date: Tue, 10 Jan 2017 09:56:32 +0530
Message-ID: <20170110042632.GC6332@vireshk-i7>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <1d5f61440dbfb640c330f77c9090e2ac23482ebc.1481106919.git.viresh.kumar@linaro.org>
 <20170109234427.GY17126@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33120 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764572AbdAJE0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 23:26:36 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so18744901pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 20:26:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109234427.GY17126@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 09-01-17, 15:44, Stephen Boyd wrote:
> On 12/07, Viresh Kumar wrote:
> > Add kref to struct dev_pm_opp for easier accounting of the OPPs.
> > 
> > Note that the OPPs are freed under the opp_table->lock mutex only.
> 
> I'm lost. Why add another level of krefs?

Heh. The earlier krefs were for the OPP table itself, so that it gets freed once
there are no more users of it.

The kref introduced now is for individual OPPs, so that they don't disappear
while being used and gets freed once all are done.

Also note that the OPP table will get freed only after all the OPPs are freed,
plus there are no more users left, like platform code which might have set
suppoerted-hw property.

-- 
viresh
