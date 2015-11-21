From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v1 2/2] intel_pstate: Change the setpoint for the cores
Date: Sat, 21 Nov 2015 08:22:24 -0800
Message-ID: <001801d12478$ceb35630$6c1a0290$@net>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com> <1446542840-14982-2-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:37152 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761228AbbKUQW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Nov 2015 11:22:26 -0500
In-Reply-To: <1446542840-14982-2-git-send-email-philippe.longepe@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Philippe Longepe' <philippe.longepe@linux.intel.com>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org

On 2015.11.03 01:27 Philippe Longepe wrote:

> Change the setpoint to 60 accordingly to the new core busy scaled formula.
> The new formaula is based on the number of cycles per seconds
> (average frequency) divided by the requested frequency. So, we need to
> chose a setpoint more aggressive to improve performance.

Myself, and so as to improve response to some games and such that use
many threads and such but often a lower overall CPU load, I think the setpoint should be set a little lower.

There is a tradeoff in reducing the setpoint further as it increases the noise
and tendency to oscillate in the response curve. Ultimately, it may be desirable
to introduce a little slope in the load / CPU frequency response curve.

I have a bunch of graphs comparing response curves. [1]

>
> Measured with this parameter, we noticed an improvement in Browsermark
> for power and perf compared to the old formula:

I would like to try this test on my system. What is the exact test?
Do I understand correctly, that I need a browser to do the test?
(my test system is a server, and it doesn't have a browser.)

>
> Score without the patch: 3517
> Power without the patch: 6856 mW
>
> Score with the patch: 3719
> Power with the patch: 6265 mW

There are some other Phoronix tests that we (the original maintainer and
the a couple of others working with him used to use. See [1].

Please be aware that the last time I tried to bring back load based calculations,
Kristen tested the proposed solution on some intel "specpower test bed and
experienced a regression on haswell based server platforms vs.  Dirks
algorithm." I don't have any details.
Your response curve, and in particular your step function response time,
is different, so it might worth re-testing.
  
References:

[1] double u double u double u dot smythies dot com/~doug/linux/intel_pstate/philippe_longepe/index.html



