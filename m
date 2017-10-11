From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: use of_cpu_device_node_get() instead of
 of_get_cpu_node()
Date: Wed, 11 Oct 2017 09:53:47 +0530
Message-ID: <20171011042347.GL4031@vireshk-i7>
References: <1507632519-19648-1-git-send-email-sudeep.holla@arm.com>
 <20171010114543.GI4031@vireshk-i7>
 <cc282f1b-0b36-bf45-6a0b-5e017c3c44ea@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:47056 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdJKEXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 00:23:52 -0400
Received: by mail-pg0-f41.google.com with SMTP id k7so351560pga.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 21:23:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cc282f1b-0b36-bf45-6a0b-5e017c3c44ea@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 10-10-17, 13:39, Sudeep Holla wrote:
> We didn't take the reference before commit 762792913f8c as we were using
> cpu_dev->of_node directly.

Yeah, and so the refcount was never screwed for us.

> The above mentioned commit used
> of_get_cpu_node() which introduces the reference.

And it missing putting it down and we missed catching that in reviews.

> So I assumed it
> shouldn't matter much and in order to keep the change simple, I did it
> before _opp_of_get_opp_desc_node. I can move just after
> _opp_of_get_opp_desc_node and before if check to avoid having both
> before failure goto and after the block.

So the right thing to do based on current code is to put the reference only
after we are done using the pointer.

-- 
viresh
