From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 01/16] PM / OPP: get/put regulators from OPP core
Date: Mon, 8 Feb 2016 14:52:05 -0800
Message-ID: <20160208225205.GE10791@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <69e87438205ee12c7e884f9a3114b2f695e8b59a.1453965717.git.viresh.kumar@linaro.org>
 <20160202022921.GI4848@codeaurora.org>
 <20160202032347.GA31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49531 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbcBHWwH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 17:52:07 -0500
Content-Disposition: inline
In-Reply-To: <20160202032347.GA31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 02/02, Viresh Kumar wrote:
> On 01-02-16, 18:29, Stephen Boyd wrote:
> > I'm still lost why we need this API. When the OPP is torn down we
> > can call regulator_put there instead. The same style seems to be
> > done for supported hw, and prop_name, which doesn't make any
> > sense either. Just tear everything down when there aren't any
> > more OPPs in the table.
> 
> I explained that earlier as well, but you never replied to that :)
> Let me paste that again here:
> 
> Consider this case:
> - Platform code sets regulator for cpuX (Create OPP-table struct and
>   set regulator)
> - insmod cpufreq-dt.ko (Fill OPP table)
> - rmmod cpufreq-dt.ko (Remove OPP table and struct, according to your
>   suggestion)
> - insmod cpufreq-dt.ko (No regulator found).
> 
> The platform code is supposed to set regulator, supported-hw,
> prop-name only once from some init-code. And it should just work out
> of the box after that. And so these calls are really required.
> 

Ok the sequence makes sense now that it's clearly explained. I
wonder if we should create and destroy OPP tables when a device
is created and destroyed instead of triggering that from a
driver. I suppose not creating the tables until they're used is
good for saving memory though?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
