From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: of_property_count_u32_elems() can return errors
Date: Fri, 18 Sep 2015 20:21:13 -0700
Message-ID: <20150919032113.GA24314@linux>
References: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
 <20150917181328.GQ23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34138 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbbISDVR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 23:21:17 -0400
Received: by padhy16 with SMTP id hy16so66350118pad.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2015 20:21:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150917181328.GQ23081@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 17-09-15, 11:13, Stephen Boyd wrote:
> > +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> > +	if (count < 0) {
> 
> We can't test count for -EINVAL to detect the missing property
> because -EINVAL is also returned on a non-multiple of u32 length
> property? Maybe we shouldn't worry about that case and turn
> -EINVAL into 0.

So you are saying that we go ahead without regulators if a incorrect
values are present in opp-microvolt? i.e. even if the length property
was invalid, we return 0 from this function.

The problem here is that we will try changing the frequency without
changing the regulator in that case, and it might not be safe for the
platform, isn't it?

-- 
viresh
