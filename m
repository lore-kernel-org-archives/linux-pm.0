From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 26 May 2015 10:44:09 +0530
Message-ID: <20150526051409.GI23464@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
 <555D6CC8.9050201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33108 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbEZFON (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 01:14:13 -0400
Received: by padbw4 with SMTP id bw4so84064064pad.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 22:14:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555D6CC8.9050201@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 21-05-15, 00:27, Nishanth Menon wrote:
> I would suggest adding a link to how future vendor specific extension
> docs might look like - maybe this is probably not the time to discuss
> this.. but anyways.. we could make some statement to the effect of "SoC
> vendor specfic extensions are documented as
> Documentation/devicetree/bindings/power/<vendor>,opp.txt and should
> clearly indicate that the extensions are permitted only under the
> operating-points-v2 compatible description."

Will this work ?:

If required, this can be extended for SoC vendor specfic bindings. Such bindings
should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
and should have a compatible description like: "operating-points-v2-<vendor>".

-- 
viresh
