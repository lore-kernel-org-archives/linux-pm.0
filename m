From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 01/16] PM / OPP: get/put regulators from OPP core
Date: Tue, 9 Feb 2016 09:23:20 +0530
Message-ID: <20160209035320.GC10843@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <69e87438205ee12c7e884f9a3114b2f695e8b59a.1453965717.git.viresh.kumar@linaro.org>
 <20160202022921.GI4848@codeaurora.org>
 <20160202032347.GA31828@vireshk>
 <20160208225205.GE10791@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34288 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbcBIDxY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:53:24 -0500
Received: by mail-pa0-f54.google.com with SMTP id kp3so960171pab.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:53:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160208225205.GE10791@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 08-02-16, 14:52, Stephen Boyd wrote:
> Ok the sequence makes sense now that it's clearly explained. I
> wonder if we should create and destroy OPP tables when a device
> is created and destroyed instead of triggering that from a
> driver. I suppose not creating the tables until they're used is
> good for saving memory though?

That is one of the aspects, over that, there are cases where we want to do few
things from platform code before initializing the OPP tables. For examples,
setting the hw-version or '-name', as done in ST's case.

-- 
viresh
