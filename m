From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 22 May 2015 19:34:57 +0530
Message-ID: <20150522140457.GB7730@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum>
 <20150513085528.GA6994@linux>
 <555D750F.80304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36554 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204AbbEVOFE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 10:05:04 -0400
Received: by paza2 with SMTP id a2so11270486paz.3
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2015 07:05:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555D750F.80304@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rob.herring@linaro.org, Nishanth Menon <nm@ti.com>
Cc: Michael Turquette <mike.turquette@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, broonie@kernel.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 21-05-15, 01:02, Nishanth Menon wrote:
> This argues that clock is an input to the cpu, this is not in-correct,
> but, it could also be argued that OPP tables are clock dependent.
> 
> For example, with multiple clock source options that a device might
> choose to select from internally(by some means.. lets not just restrict
> ourselves to just CPUs here for a moment), the tables might be
> different. We can always debate that this then is the responsibility of
> the driver handling the description for that device and we might want
> possibility of vice versa as well - same OPP table used by different
> clock source selections as well.

@Rob: Any inputs ?

-- 
viresh
