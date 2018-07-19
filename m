From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Thu, 19 Jul 2018 12:46:17 +0200
Message-ID: <1932970.0qede6EoN4@aspire.rjw.lan>
References: <1531375675-52623-1-git-send-email-george.cherian@cavium.com> <41a6e3c7-db85-9ff1-daf4-07569c11fc8c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41a6e3c7-db85-9ff1-daf4-07569c11fc8c@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

On Saturday, July 14, 2018 12:20:43 AM CEST Prakash, Prashanth wrote:
> Hi George,
> 
> This version looks good. Thanks!
> 
> On 7/12/2018 12:07 AM, George Cherian wrote:
> > Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> > feedback via set of performance counters. To determine the actual
> > performance level delivered over time, OSPM may read a set of
> > performance counters from the Reference Performance Counter Register
> > and the Delivered Performance Counter Register.
> >
> > OSPM calculates the delivered performance over a given time period by
> > taking a beginning and ending snapshot of both the reference and
> > delivered performance counters, and calculating:
> >
> > delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
> >
> > Implement the above and hook this to the cpufreq->get method.
> >
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Prashanth Prakash <pprakash@codeaurora.org>
> 

Patch applied, thanks!
