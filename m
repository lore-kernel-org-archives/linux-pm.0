From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Thu, 8 Oct 2015 19:22:28 +0530
Message-ID: <20151008135228.GG18898@linux>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux>
 <1444296229.2847.9.camel@linaro.org>
 <20151008112454.GE18898@linux>
 <1444308924.2847.35.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444308924.2847.35.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-10-15, 13:55, Jon Medhurst (Tixy) wrote:
> Looking a bit more carefully, the reason your fix doesn't work is that
> bL_cpufreq_get_rate returns the last requested rate for this CPU,
> whereas target_rate/new_rate is the maximum rate requested by any CPU on
> the cluster (which is what we want the hardware set to).

Sigh..

> So sounds like my alternative fix of checking the 'actual' frequency
> immediately after setting it is probably the way forward, unless Sudeep
> chimes in with additional info about the issue he was trying to address.

Right.

-- 
viresh
