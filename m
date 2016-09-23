From: Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH v2 0/2] cpufreq: pcc-cpufreq: Re-introduce deadband effect to
 reduce number of frequency changes
Date: Fri, 23 Sep 2016 18:56:32 +0200
Message-ID: <20160923165632.GA9786@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819121814.GA17296@suselix.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi,

following patches address the performance degradation due to commit
6393d6a102 (cpufreq: ondemand: Eliminate the deadband effect) on
systems using pcc-cpufreq driver and ondemand governor.

Patch 1 introduces a generic_map_load_to_freq function which is
similar to what is used since commit 6393d6a102 (cpufreq: ondemand:
Eliminate the deadband effect) to calculate freq_next in od_update.

Patch 2 provides a specific function for pcc-cpufreq driver which
falls back to the calculation that was in the used before commit
6393d6a102.

I've also tested a pcc-specific function without deadband effect but
using only 10 frequency values. That was suboptimal in comparison to
patch 2. Here the performance data for this comparison (kernel
compilation with different number of jobs):

            pcc specific map_load_to_freq     pcc specific map_load_to_freq
              function (with deadband)        function (10 frequency steps)
 # of jobs  user    sys   elapsed   % CPU      user    sys   elapsed   % CPU
    2      413.19  102.34  250.97   205.00    426.21  106.32  260.00   204.00
    4      390.56  120.79  127.25   401.20    408.38  124.03  132.63   401.00
    8      354.22  140.09   64.20   769.60    383.33  146.31   68.70   770.40
   16      384.20  148.69   37.07  1436.60    466.20  164.18   43.30  1455.00
   32      496.70  152.77   25.15  2581.40    658.50  179.74   31.27  2680.60
   64      399.48   49.13   12.80  3505.80    404.27   51.24   13.14  3467.00
  120      406.52   46.89   13.60  3331.60    409.42   48.71   13.58  3371.40


Regards,

Andreas
