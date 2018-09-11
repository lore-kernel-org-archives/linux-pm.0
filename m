From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date: Tue, 11 Sep 2018 12:29:19 +0200
Message-ID: <2115864.0gBFVHkxzn@aspire.rjw.lan>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eero Tamminen <eero.t.tamminen@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, lenb@kernel.org, viresh.kumar@linaro.org, mgorman@techsingularity.net, currojerez@riseup.net, ggherdovich@suse.cz, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 3, 2018 5:10:27 PM CEST Eero Tamminen wrote:
> Hi,
> 
> On 31.08.2018 20:28, Srinivas Pandruvada wrote:
> ...
> > As per testing Eero Tamminen, the results are comparable to the patchset
> > https://patchwork.kernel.org/patch/10312259/
> > But he has to watch results for several days to check trend.
> 
> It's close, but there is some gap compared to Francisco's version.

It is unclear what exactly you are referring to without a link to the
patch.

Thanks,
Rafael
