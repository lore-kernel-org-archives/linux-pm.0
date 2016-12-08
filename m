From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Thu, 8 Dec 2016 12:15:13 +0530
Message-ID: <20161208064513.GC31711@vireshk-i7>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org>
 <20161207032555.GE31255@vireshk-i7>
 <20161207211343.GA5423@codeaurora.org>
 <20161208033059.GA24152@vireshk-i7>
 <20161208063918.GG2749@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36643 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbcLHGpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 01:45:17 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so170317190pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 22:45:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161208063918.GG2749@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 08-12-16, 14:39, Shawn Guo wrote:
> Yes, it's the best effort.

That may get a risky IMO. What if we fail to add all OPPs except the last one,
which selects the highest frequency? We will surely overheat most of the SoCs
and burn them out.

I think its better to fail and return in such cases.

> For example, a duplicated OPP shouldn't be a
> stopper for the driver.

That's a different case and is already supported properly, as we wouldn't fail
in that case.

Thanks for your inputs Shawn.

-- 
viresh
