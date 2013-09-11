From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] cpufreq: fixes for v3.12
Date: Thu, 12 Sep 2013 00:58:54 +0200
Message-ID: <1795989.18GOYqdUtX@vostro.rjw.lan>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 10, 2013 06:59:45 PM Sudeep KarkadaNagesha wrote:
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

I have a little problem with this series, because the last patch is based
on the current Linus' tree rather than on my master branch which is what
I have ready to push.  I don't think it makes sense to rebase it, however,
because that would introduce a merge conflict for Linus unnecessarily.

To avoid merging stuff back and forth, I'll push this series later in the
cycle.

Thanks,
Rafael

