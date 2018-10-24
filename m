From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: add ratelimited thermal and power logging
Date: Wed, 24 Oct 2018 12:52:27 +0530
Message-ID: <20181024072227.achkbix2ndef2ule@vireshk-i7>
References: <20181022202901.1654-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181022202901.1654-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Zwisler <zwisler@google.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Stephen Barber <smbarber@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 22-10-18, 14:29, Ross Zwisler wrote:
> From: Ricky Liang <jcliang@chromium.org>
> 
> Add thermal logs in devfreq_cooling and cpu_cooling.

Why should we add them ?

> Also add logging to
> power_allocator when it starts to control power.
> 
> These changes can lead to excessive log spam when running up against
> thermal limits, so have this logging ratelimited to allow only 1 log each
> 30 seconds from each of those subsystems.

What's the use of these logs when we are going to print them only once every 30
seconds ?

I recently extended thermal sysfs support to share more stats.

commit 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")

Will that be helpful in your case ?

Otherwise we should probably add trace points instead.

-- 
viresh
