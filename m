From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 4/10] cpufreq: governor: Move abstract gov_attr_set
 code to seperate file
Date: Fri, 4 Mar 2016 11:22:41 +0530
Message-ID: <20160304055241.GD27109@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <8439076.su0yJP41kh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8439076.su0yJP41kh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-03-16, 04:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move abstract code related to struct gov_attr_set to a separate (new)
> file so it can be shared with (future) goverernors that won't share
> more code with "ondemand" and "conservative".
> 
> No intentional functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes from the previous version:
> - Different name of the new file.
> - Different name of the new Kconfig symbol.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
