From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] devfreq: rk3399_dmc: Don't use OPP structures outside of RCU locks
Date: Thu, 08 Dec 2016 01:38:44 +0100
Message-ID: <2256096.rPjKFAJNx8@aspire.rjw.lan>
References: <dcd19eb862a0de24b441f4d43473a01ae90e20e9.1480908064.git.viresh.kumar@linaro.org> <CAJZ5v0iL9wvMfwqvpKVMEig=7xcoFtvhbgjOVche1Y58WfHnLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57906 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932141AbcLHAtn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 19:49:43 -0500
In-Reply-To: <CAJZ5v0iL9wvMfwqvpKVMEig=7xcoFtvhbgjOVche1Y58WfHnLw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Tuesday, December 06, 2016 11:40:18 PM Rafael J. Wysocki wrote:
> Hi MyungJoo,
> 
> On Mon, Dec 5, 2016 at 4:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The OPP structures are abused to the best here, without understanding
> > how the OPP core and RCU locks work.
> >
> > In short, the OPP pointer saved in 'rk3399_dmcfreq' can become invalid
> > under your nose, as the OPP core may free it.
> >
> > Fix various abuses around OPP structures and calls.
> >
> > Compile tested only.
> >
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V1->V2:
> > - Added Reviewed-by from Chanwoo.
> > - Fixed an issue reported by buildbot.
> 
> I think this along with https://patchwork.kernel.org/patch/9455789/
> and https://patchwork.kernel.org/patch/9455757/ should go into
> 4.10-rc1.
> 
> Are you going to send a pull request for this before the merge window
> or do you want me to apply them directly?

Due to the lack of response, I'm going to apply these three patches
directly.

Thanks,
Rafael

