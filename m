From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date: Mon, 18 Feb 2019 23:03:03 +0100
Message-ID: <2407408.YatPz1rZtD@aspire.rjw.lan>
References: <2038590.kmssd2ZIyd@aspire.rjw.lan> <16144228.tcT5YVROcV@aspire.rjw.lan> <000c01d4c6f6$914a7f20$b3df7d60$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000c01d4c6f6$914a7f20$b3df7d60$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, February 17, 2019 8:25:37 PM CET Doug Smythies wrote:
> On 2019.02.07 03:51 Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The current iowait boosting mechanism in intel_pstate_update_util()
> > is quite aggressive, as it goes to the maximum P-state right away,
> > and may cause excessive amounts of energy to be used, which is not
> > desirable and arguably isn't necessary too.
> >
> > Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> > more energy efficient") that reworked the analogous iowait boost
> > mechanism in the schedutil governor and make the iowait boosting
> > in intel_pstate_update_util() work along the same lines.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2:
> >   * Follow the Doug's suggestion and drop the immediate jump to
> >     max P-state if boost is max.  The code is simpler this way and
> >     the perf impact should not be noticeable on average.
> 
> Hi Rafael,
> 
> Something has broken on my incoming e-mail sorting stuff, and I
> missed this one (and some others).
> 
> This V2 is not actually what I was proposing. I was O.K. with
> the immediate jump, but I didn't want the set_pstate step
> by-passed if it was already at max because that would also
> by-pass the trace sample, if it was enabled.
> 
> Anyway, this V2 seems O.K. to me. I tested it compared to V1
> and, as you mentioned, wasn't able to detect any energy consumption
> or performance differences.

Thanks for the confirmation!
