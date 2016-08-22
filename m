From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Mon, 22 Aug 2016 15:53:44 -0700
Message-ID: <001701d1fcc8$0b39ef60$21adce20$@net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>  <1572483.RZjvRFdxPx@vostro.rjw.lan> <001b01d1ee1c$e6a6a170$b3f3e450$@net>       <10156236.RI1knH5Wfs@vostro.rjw.lan> <000301d1f57b$9e1fed10$da5fc730$@net> <1471892026.3745.77.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471892026.3745.77.camel@linux.intel.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016.08.22 11:54 Srinivas Pandruvada wrote:

> I am not able to apply this patch. Can you send as a patch on top of
> Rafael's RFC 7/7. Since test takes long time, I want to apply correct
> patch.

...[cut]...

O.K. I have included a couple of changes as per the feedback from Peter Zijlstra,
but all of my "To Do" notes are still there.

Coming shortly as patch 8 of 7 as per below:

doug@s15:~/temp-k-git/linux$ git log --oneline

305e905 cpufreq: intel_pstate: add iir filter to pstate.
a29457f cpufreq: intel_pstate: Change P-state selection algorithm for Core
75cf618 cpufreq: schedutil: Add iowait boosting
01b35b0 cpufreq / sched: UUF_IO flag to indicate iowait condition
81d0b42 cpufreq / sched: Add flags argument to cpufreq_update_util()
cb8f8e0 cpufreq / sched: Check cpu_of(rq) in cpufreq_update_util()
ffa049b cpufreq / sched: Drop cpufreq_trigger_update()
a3c19c3 cpufreq / sched: Make schedutil access utilization data directly
fa8410b Linux 4.8-rc3

... Doug
