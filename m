From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency
 switching
Date: Tue, 29 Mar 2016 19:50:56 +0530
Message-ID: <20160329142056.GL31619@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan>
 <20160328070341.GJ32495@vireshk-i7>
 <2467412.EHWtmERkoP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2467412.EHWtmERkoP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29-03-16, 14:10, Rafael J. Wysocki wrote:
> In that case the loop will break for freq = 9000 (as per the above
> freq >= freq_target check), so it looks like you've misread it.

My bad ..

-- 
viresh
