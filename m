From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: Remove OF dependency on
 dev_pm_opp_of_{cpumask_,}remove_table
Date: Thu, 28 Apr 2016 16:45:29 +0530
Message-ID: <20160428111529.GC2915@vireshk-i7>
References: <1461839114-29857-1-git-send-email-sudeep.holla@arm.com>
 <20160428111221.GB2915@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160428111221.GB2915@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28-04-16, 16:42, Viresh Kumar wrote:
> On 28-04-16, 11:25, Sudeep Holla wrote:
> > + * dev_pm_opp_remove_table() - Free OPP table static entries associated with
> > + *			       the device
> 
> Its not about static entries anymore, right? We will end up removing everything
> we had in the table.

Pardon me, that's not true..

-- 
viresh
