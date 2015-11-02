From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Mon, 2 Nov 2015 11:21:44 -0800
Message-ID: <20151102192144.GQ19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030214907.GJ19782@codeaurora.org>
 <20151031021612.GU3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151031021612.GU3716@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 10/31, Viresh Kumar wrote:
> On 30-10-15, 14:49, Stephen Boyd wrote:
> > I suppose if you wanted to have 64 possible combinations of some
> > attribute you would just extend it to two 32 bit numbers in
> > sequence? I don't see the limitation here, and hopefully there
> > isn't a limitation so that we can specify sufficiently large
> > numbers with more bits if we need to.
> 
> Yeah, we discussed this earlier when Lee had the same query and I
> suggested the exact same thing to him then.
> 

Ah I see that after looking at the previous thread. Perhaps we
can add such information into the documentation so that people
aren't misled into thinking they're limited to 32 bits?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
