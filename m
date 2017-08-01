From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: x86: Make scaling_cur_freq behave more as expected
Date: Tue, 01 Aug 2017 02:50:22 +0200
Message-ID: <7022398.sQJh69VhN8@aspire.rjw.lan>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> <8753755.adRLzWASdR@aspire.rjw.lan> <002201d30a57$44f2ed40$ced8c7c0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58634 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751102AbdHAA6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2017 20:58:30 -0400
In-Reply-To: <002201d30a57$44f2ed40$ced8c7c0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, rafael@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>

On Monday, July 31, 2017 04:46:42 PM Doug Smythies wrote:
> On 2017.07.28 05:45 Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After commit f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to
> > calculate KHz using APERF/MPERF" the scaling_cur_freq policy attribute
> > in sysfs only behaves as expected on x86 with APERF/MPERF registers
> > available when it is read from at least twice in a row.  The value
> > returned by the first read may not be meaningful, because the
> > computations in there use cached values from the previous iteration
> > of aperfmperf_snapshot_khz() which may be stale.
> >
> > To prevent that from happening, modify arch_freq_get_on_cpu() to
> > call aperfmperf_snapshot_khz() twice, with a short delay between
> > these calls, if the previous invocation of aperfmperf_snapshot_khz()
> > was too far back in the past (specifically, more that 1s ago).
> 
> ...[deleted the rest]...
> 
> This patch seems to work fine and addresses my complaints from last week.
> Thanks.

Thanks for the confirmation!

Rafael
