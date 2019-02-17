From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v2] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date: Sun, 17 Feb 2019 11:25:37 -0800
Message-ID: <000c01d4c6f6$914a7f20$b3df7d60$@net>
References: <2038590.kmssd2ZIyd@aspire.rjw.lan> <16144228.tcT5YVROcV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16144228.tcT5YVROcV@aspire.rjw.lan>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2019.02.07 03:51 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current iowait boosting mechanism in intel_pstate_update_util()
> is quite aggressive, as it goes to the maximum P-state right away,
> and may cause excessive amounts of energy to be used, which is not
> desirable and arguably isn't necessary too.
>
> Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> more energy efficient") that reworked the analogous iowait boost
> mechanism in the schedutil governor and make the iowait boosting
> in intel_pstate_update_util() work along the same lines.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2:
>   * Follow the Doug's suggestion and drop the immediate jump to
>     max P-state if boost is max.  The code is simpler this way and
>     the perf impact should not be noticeable on average.

Hi Rafael,

Something has broken on my incoming e-mail sorting stuff, and I
missed this one (and some others).

This V2 is not actually what I was proposing. I was O.K. with
the immediate jump, but I didn't want the set_pstate step
by-passed if it was already at max because that would also
by-pass the trace sample, if it was enabled.

Anyway, this V2 seems O.K. to me. I tested it compared to V1
and, as you mentioned, wasn't able to detect any energy consumption
or performance differences.

... Doug
