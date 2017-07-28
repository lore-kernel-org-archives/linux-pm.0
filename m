From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: x86: Make scaling_cur_freq behave more as expected
Date: Thu, 27 Jul 2017 23:01:39 -0700
Message-ID: <001901d30766$fc66a3c0$f533eb40$@net>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> <006201d30595$e0a23870$a1e6a950$@net> at1wdL9D9BxRWat21ddU41
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: at1wdL9D9BxRWat21ddU41
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Len Brown' <lenb@kernel.org>, rafael@kernel.org, tglx@linutronix.de, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2017.07.27 17:13 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to
> calculate KHz using APERF/MPERF" the scaling_cur_freq policy attribute
> in sysfs only behaves as expected on x86 with APERF/MPERF registers
> available when it is read from at least twice in a row.
>
> The value returned by the first read may not be meaningful, because
> the computations in there use cached values from the previous
> aperfmperf_snapshot_khz() call which may be stale.  However, the
> interface is expected to return meaningful values on every read,
> including the first one.
>
> To address this problem modify arch_freq_get_on_cpu() to call
> aperfmperf_snapshot_khz() twice, with a short delay between
> these calls, if the previous invocation of aperfmperf_snapshot_khz()
> was too far back in the past (specifically, more that 1s ago) and
> adjust aperfmperf_snapshot_khz() for that.
>
> Fixes: f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF"
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> arch/x86/kernel/cpu/aperfmperf.c |   36 +++++++++++++++++++++++++++++-------
> 1 file changed, 29 insertions(+), 7 deletions(-)
>
> Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c

...[deleted the rest]...

This proposed patch would be good. However, I can only try it maybe by Sunday.
I think the maximum time span means that this code:

        /*
         * if (cpu_khz * aperf_delta) fits into ULLONG_MAX, then
         *      khz = (cpu_khz * aperf_delta) / mperf_delta
         */
        if (div64_u64(ULLONG_MAX, cpu_khz) > aperf_delta)
                s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
        else    /* khz = aperf_delta / (mperf_delta / cpu_khz) */
                s->khz = div64_u64(aperf_delta,
                        div64_u64(mperf_delta, cpu_khz));

Could be reduced to this:

        s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);

Because it could never overflow anymore.

... Doug
