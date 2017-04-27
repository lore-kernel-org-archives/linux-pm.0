From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 27 Apr 2017 16:20:34 +0530
Message-ID: <9019aebe-95ba-b1b8-65a9-5be927934218@codeaurora.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964858AbdD0Kun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 06:50:43 -0400
In-Reply-To: <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, devicetree@vger.kernel.org


On 04/27/2017 03:12 PM, Sudeep Holla wrote:
[]..

>>
>>> At qualcomm, we have an external M3 core (running its own firmware) which controls
>>> a few voltage rails (including AVS on those). The devices vote for the voltage levels
> 
> Thanks for explicitly mentioning this, but ...
> 
>>> (or performance levels) they need by passing an integer value to the M3 (not actual
> 
> you contradict here, is it just voltage or performance(i.e. frequency)
> or both ? We need clarity there to choose the right representation.

Its just voltage.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
