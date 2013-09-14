From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 069/228] cpufreq: kirkwood: Use generic cpufreq routines
Date: Sat, 14 Sep 2013 11:31:25 +0200
Message-ID: <20130914093125.GE23705@lunn.ch>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <c1cbe4428eb9708c437c9f63e661e6a82260b4cb.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53320 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab3INJeq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 Sep 2013 05:34:46 -0400
Content-Disposition: inline
In-Reply-To: <c1cbe4428eb9708c437c9f63e661e6a82260b4cb.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>

On Fri, Sep 13, 2013 at 06:30:15PM +0530, Viresh Kumar wrote:
> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
> 
> This patch uses these generic routines for this driver.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/kirkwood-cpufreq.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

Hi Viresh

You can add:

Tested-by: Andrew Lunn <andrew@lunn.ch>

to

[PATCH 069/228] cpufreq: kirkwood: Use generic cpufreq routines
[PATCH 107/228] cpufreq: kirkwood: don't initialize part of policy that is set by core
[PATCH 161/228] cpufreq: kirkwood: Convert to light weight ->target_index() routine
[PATCH 195/228] cpufreq: kirkwood: remove calls to cpufreq_notify_transition()

It does however require the patch:

http://www.spinics.net/lists/arm-kernel/msg273378.html

but this is not because of this patch series, it was already broken.

Thanks
	Andrew
