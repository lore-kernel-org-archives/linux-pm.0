From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded
 systems
Date: Tue, 2 Apr 2019 14:22:38 +0100
Message-ID: <20190402132236.7h264nffbgnojznw@queper01-lin>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-4-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308212047.28767-4-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Friday 08 Mar 2019 at 22:20:47 (+0100), Daniel Lezcano wrote:
> Despite the naive idle state selection for this first iteration, the
> governor provides a performance improvement of 30% for Jankbench
> throughout for the same amount of energy than the menu governor

Wow, that sounds really good. Which kernel and board did you use for
testing ? What's the perf. metric here ? The 99% percentile of frame
completion time ?

Cheers,
Quentin
