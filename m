From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove duplicate code
Date: Fri, 28 Apr 2017 23:34:31 +0200
Message-ID: <1644626.pZFp7GD5Yb@aspire.rjw.lan>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com> <1493371296-12465-2-git-send-email-sudeep.holla@arm.com> <20170428092456.GF21517@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54152 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1422932AbdD1Vks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 17:40:48 -0400
In-Reply-To: <20170428092456.GF21517@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday, April 28, 2017 02:54:56 PM Viresh Kumar wrote:
> On 28-04-17, 10:21, Sudeep Holla wrote:
> > scpi_ops now provide APIs to get the transition_latency and to add
> > OPPs to the devices making those logic redundant here.
> > 
> > This patch makes use of those APIs and removes the redunant code in
> > this driver.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
> >  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

OK

Sudeep, please route this through ARM.

Thanks,
Rafael
