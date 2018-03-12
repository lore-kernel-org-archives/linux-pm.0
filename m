From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
Date: Mon, 12 Mar 2018 10:02:09 +0530
Message-ID: <20180312043209.GS6842@vireshk-i7>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-01-18, 15:22, Viresh Kumar wrote:
> This extends the sysfs interface for thermal cooling devices and exposes
> some pretty useful statistics. These statistics have proven to be quite
> useful specially while doing benchmarks related to the task scheduler,
> where we want to make sure that nothing has disrupted the test,
> specially the cooling device which may have put constraints on the CPUs.
> The information exposed here tells us to what extent the CPUs were
> constrained by the thermal framework.

@Eduardo/Zhang: Are you going to merge this for 4.17 ?

-- 
viresh
