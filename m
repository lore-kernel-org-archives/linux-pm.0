From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] cpufreq: governor: Rework API to use callbacks
 instead of events
Date: Mon, 16 May 2016 10:25:09 +0530
Message-ID: <20160516045509.GP9296@vireshk-i7>
References: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10707470.yIcqGAzuFY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-05-16, 00:58, Rafael J. Wysocki wrote:
> Hi,
> 
> This series is on top of the current linux-next witn the following two patches
> applied:
> 
> https://patchwork.kernel.org/patch/9080801/
> https://patchwork.kernel.org/patch/9080791/
> 
> It cleans up a few things and then reworks the governor API to get rid of
> governor events and use callbacks representing individual governor operations
> (init, exit, start, stop, limits update) instead.
> 
> I'm regarding it as v4.8 material, but I'd like to put it into linux-next as
> soon as 4.7-rc1 is out so subsequent cpufreq development happens on top of it.
> 
> It has been lightly tested without any problems showing up so far.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
