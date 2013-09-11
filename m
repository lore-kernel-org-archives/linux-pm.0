From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/4] cpufreq: fixes for v3.12
Date: Wed, 11 Sep 2013 10:23:45 +0800
Message-ID: <20130911022343.GJ5815@S2101-09.ap.freescale.net>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 10, 2013 at 06:59:45PM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi Shawn, Guennadi,
> 
> These are the fixes for the issue reported by Guennadi.
> cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
> devices. The dev_id is also updated while registering the cpu clocks.
> 
> Can you review these ? Tested-by is much appreciated as I don't
> have hardware to check the fix.

For IMX,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

