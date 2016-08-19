From: Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH 0/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect to
 reduce number of frequency changes
Date: Fri, 19 Aug 2016 14:18:14 +0200
Message-ID: <20160819121814.GA17296@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60348 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbcHSMSo (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Fri, 19 Aug 2016 08:18:44 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

Hello,

I've observed performance degradation with different workloads on HP
ProLiant systems that use pcc-cpufreq driver between older and more
recent kernels. Bisection showed that commit 6393d6a102 (cpufreq:
ondemand: Eliminate the deadband effect) caused a significant
performance drop. This patch was introduced in v3.17.

I am not too familiar with the PCC stuff but I think that elimination
of the deadband effect causes a significant increase of requested
frequency changes which in turn will have to be served by pcc-cpufreq
and slow down corresponding systems significantly.

AFAIK there is no frequency table for this driver, instead the driver
just asks firmware to set any requested frequency for a CPU (if its in
the min-max-range of allowed frequencies). Thus I think the
probability that a requested target frequency is matching the current
frequency of a CPU is lower in comparison to drivers that use a
fixed set of frequencies.

This is with two exceptions:

(1) when a CPU is under full load -- maximum frequency already set and
    maximum frequency is requested.

(2) CPU has just "minor load" -- minimum frequency already set and
    minimum frequency is requested.

I think what commit 6393d6a102 caused is, that case (2) occurs only if
the CPU is fully idle. Whereas before commit 6393d6a102 this case
occurred in all situations when

	load < freq_min/freq_max * 100

I suggest to introduce the old behaviour (re-introduce the deadband effect)
for pcc-cpufreq with the patch that follows.

Here are typical numbers from kernel compilation tests with varying
number of compile jobs:

                     v4.8.0-rc2               4.8.0-rc2-pcc-cpufreq-deadband
 # of jobst   user     sys   elapsed   CPU     user     sys   elapsed   CPU
       2     440.39  116.49  4:33.35   203%   404.85  109.10  4:10.35   205%
       4     436.87  133.39  2:22.88   399%   381.83  128.00  2:06.84   401%
       8     475.49  157.68  1:22.24   769%   344.36  149.08  1:04.29   767%
      16     620.69  188.33  0:54.74  1477%   374.60  157.40  0:36.76  1447%
      32     815.79  209.58  0:37.22  2754%   490.46  160.22  0:24.87  2616%
      64     394.13   60.55  0:13.54  3355%   386.54   60.33  0:12.79  3493%
     120     398.24   61.55  0:14.60  3148%   390.44   61.19  0:13.07  3453%

As expected under full load (64, 120 jobs) performance is "almost"
comparable. But with partial load (esp. 32 jobs) length of kernel
build is just 2/3 with patched kernel in comparison to current
mainline. Similar behaviour is observable since introduction of commit
6393d6a102 (ie. since v3.17).

Numbers are from an HP ProLiant DL580 Gen8 system:
 	- Intel(R) Xeon(R) CPU E7-4890 v2 @ 2.80GHz
        - 60 CPUs, 128GB RAM

PCC info of this system

  PCCH header (virtual) addr: 0xffffc9000d840000
  PCCH header is at physical address: 0x7ac59000, signature: 0x24504343,
    length: 64 bytes, major: 1, minor: 0, supported features: 0x1,
    command field: 0x1, status field: 0x0, nominal latency: 300 us
    min time between commands: 50000 us, max time between commands: 1000000 us,
    nominal CPU frequency: 2800 MHz, minimum CPU frequency: 150 MHz,
    minimum CPU frequency without throttling: 1200 MHz

Kernel message when driver loads:
  pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz

My patch adds a debug message, which on this system looks like
  pcc-cpufreq: setting deadband limit to 1885000 kHz


Regards,

Andreas
