From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 Resend 1/5] PM / OPP: reuse of_parse_phandle()
Date: Tue, 1 Sep 2015 15:48:07 -0700
Message-ID: <20150901224807.GA21112@codeaurora.org>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <be1d2761b6c83004b35c8f9e410baa1d019d4b96.1441083292.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <be1d2761b6c83004b35c8f9e410baa1d019d4b96.1441083292.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 09/01, Viresh Kumar wrote:
> We already have a better API to get the opp descriptor block's node from
> cpu-node. Lets reuse that instead of creating our own routines for the
> same stuff. That cleans the code a lot.
> 
> This also kills a check we had earlier (as we are using the generic API
> now). Earlier we used to check if the operating-points-v2 property
> contained multiple phandles instead of a single phandle.
> 
> Killing this check isn't an issue because, we only parse the first entry
> with of_parse_phandle(). So, if a user passes multiple phandles, its
> really his problem :)
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
