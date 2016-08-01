From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC][PATCH 4/7] cpufreq / sched: Add flags argument to
 cpufreq_update_util()
Date: Mon, 1 Aug 2016 09:33:12 +0200
Message-ID: <20160801073312.GB4220@light.dominikbrodowski.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <1797214.I7CKAT8Nb2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1797214.I7CKAT8Nb2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 01, 2016 at 01:36:46AM +0200, Rafael J. Wysocki wrote:
> +#define UUF_RT	0x01

What does UUF stand for?

Best
	Dominik
