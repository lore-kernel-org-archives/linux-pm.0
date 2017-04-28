From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove
 duplicate code
Date: Fri, 28 Apr 2017 14:54:56 +0530
Message-ID: <20170428092456.GF21517@vireshk-i7>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
 <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33743 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946063AbdD1JZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2017 05:25:06 -0400
Received: by mail-pf0-f179.google.com with SMTP id i4so9598237pfc.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Apr 2017 02:25:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 28-04-17, 10:21, Sudeep Holla wrote:
> scpi_ops now provide APIs to get the transition_latency and to add
> OPPs to the devices making those logic redundant here.
> 
> This patch makes use of those APIs and removes the redunant code in
> this driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
