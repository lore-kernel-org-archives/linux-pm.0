From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] tools/power/x86: Debug utility for intel_pstate driver
Date: Mon, 13 Feb 2017 15:08:48 -0800
Message-ID: <003d01d2864e$23c50050$6b4f00f0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:58100 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdBMXRB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Feb 2017 18:17:01 -0500
References: RPtUcuNcxTU7uRPtVc4uRU
In-Reply-To: RPtUcuNcxTU7uRPtVc4uRU
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 2017.01.11 12:50 Srinivas Pandruvada wrote:

> This utility can be used to debug and tune the performance of the
> intel_pstate driver.
> This utility can be used in two ways:
> - If there is Linux trace file with pstate_sample events enabled, then
> this utility can parse the trace file and generate performance plots.
> - If user has not specified a trace file as input via command line
> parameters, then this utility enables and collects trace data for a user
> specified interval and generates performance plots.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> .../x86/intel_pstate_tracer/intel_pstate_tracer.py | 287 +++++++++++++++++++++
> 1 file changed, 287 insertions(+)
> create mode 100755 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py

...[cut]...

In a moment I will submit a version 2 of this script.

It will include some fixes and additions done by Srinivas since the
original submission, including the ability to specify which CPUs to graph and
the ability to plot by elapsed time instead of just by sample number.

Additionally, I made significant changes incorporating work from an earlier
but never formally released intel-pstate trace post processing tool, where
the number of CPUs was never a variable. Changes include, but are not limited to:

. make .csv (comma separated values) files instead of .dat files for direct import
  into spreadsheets. With column titles, also for spreadsheets using "freeze pane".
  The graphs are cool and such, but really usually just point to areas to examine
  in more detail, via spreadsheet. Also allows the user to make their own plots of
  some detail.
. Introduce some name for the test run, so as to be able to distinguish between
  graphs when comparing.
. Change from generic "data" to store stuff to "results/test_name".
  Thus unintended potential clobbering of old data is avoided.
. Add date and time to graph title.
. Add grid
. Move axis tick marks outside the graph.
. force leading zeros for CPU numbers on file names etc. Then they will sort right
  and not be ambiguous during grep.
. make the same graphs as Srinivas, but from the csv files. Add some more graphs.
. Assume verses elapsed time x-axis in file naming convention. 
  Use, for example, bla_vs_samples.png only when x-axis is not elapsed time.
. Change the fixed 0-100% scale because core_busy and scaled_busy can go over 100,
  and often we want to see those data points.
. Add a missed samples sanity check calculation column to the csv files.
  Add a corresponding graph.


