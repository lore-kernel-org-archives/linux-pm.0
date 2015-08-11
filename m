From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Mon, 10 Aug 2015 23:09:24 -0700
Message-ID: <20150811060924.GI9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
 <20150811023349.GM5766@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811023349.GM5766@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 08/11, Viresh Kumar wrote:
> On 10-08-15, 17:31, Stephen Boyd wrote:
> > I am not insisting anything. But another patch to get rid of the
> > goto sounds fine.
> 
> The separate patch to kill goto.
> 
> ---------------------8<-------------------------
> 
> Message-Id: <9f9b9ea6ea3685d5f71c132e7efb18917253961f.1439260355.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 11 Aug 2015 08:01:01 +0530
> Subject: [PATCH] PM / OPP: Remove unnecessary goto statements
> 
> The code simply returns after jumping to the out label and doesn't free
> any resources, etc.
> 
> Kill the unnecessary goto statements.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
