From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
Date: Tue, 19 Sep 2017 15:58:40 -0700
Message-ID: <20170919225840.GI30848@ubuntu>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:53229 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdISW6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 18:58:42 -0400
Received: by mail-pg0-f45.google.com with SMTP id i195so632802pgd.9
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 15:58:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com

On 24-08-17, 00:10, Dong Aisheng wrote:
> This is useful to support platforms which only the clk setting is
> different from the generic OPP set rate but others like voltage
> setting are still the same.
> 
> Users can use this function to register a custom OPP set clk helper
> working in place of the default simple clk setting in the generic
> dev_pm_opp_set_rate(). Then user can still use dev_pm_opp_set_rate()
> with .set_clk() to save a lot duplicated work.

I am not inclined to add this support really. What prevents you to
register a clock for the device (which is CPU in your case) and the
generic clk_set_rate() will eventually call into the platform specific
routine. That's what everyone else is doing.

-- 
viresh
