From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: Remove OF dependency on
 dev_pm_opp_of_{cpumask_,}remove_table
Date: Thu, 28 Apr 2016 16:42:21 +0530
Message-ID: <20160428111221.GB2915@vireshk-i7>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35329 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcD1LMZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 07:12:25 -0400
Received: by mail-pa0-f41.google.com with SMTP id iv1so31006239pac.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2016 04:12:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 28-04-16, 11:25, Sudeep Holla wrote:
> + * dev_pm_opp_remove_table() - Free OPP table static entries associated with
> + *			       the device

Its not about static entries anymore, right? We will end up removing everything
we had in the table.

Can you please update comments also in the same patch ?

-- 
viresh
