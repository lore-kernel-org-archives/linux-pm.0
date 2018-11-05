From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date: Mon, 5 Nov 2018 14:09:54 -0800
Message-ID: <002601d47554$4a150060$de3f0120$@net>
References: <1899281.leNo2RexrE@aspire.rjw.lan>  <1541010981.3423.2.camel@suse.cz> <4168371.zz0pVZtGOY@aspire.rjw.lan> JkGTgcRwED1yAJkGYggSqP
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: JkGTgcRwED1yAJkGYggSqP
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.11.05 11:14 Giovanni Gherdovich wrote:
> On Sun, 2018-11-04 at 11:06 +0100, Rafael J. Wysocki wrote:
>>
>> You can use the cpu_idle trace point to correlate the selected state =
index
>> with the observed idle duration (that's what Doug did IIUC).
>
> True, that works; although I ended up slapping a tracepoint right at =
the
> beginning of the teo_update() and capturing the variables
> cpu_data->last_state, dev->last_residency and dev->cpu.
>
> I should have some plots to share soon. I really wanted to do =
in-kernel
> histograms with systemtap as opposed to collecting data with ftrace =
and doing
> post-processing, because I noticed that the latter approach generates =
lots of
> events and wakeups from idle on the cpu that handles the ftrace data. =
It's
> kind of a workload in itself and spoils the results.

I agree that we need to be careful not to influence the system we
are trying to acquire diagnostic data on via the act of acquiring
that data.

I did not find much, if any, effect of acquiring trace data during the
dbench with 12 clients test. Regardless I do the exact same test the =
exact
same way for the baseline reference kernel and the test kernel. To be
clear, I mean no effect while actually acquiring the trace samples.
Obviously there is a significant effect while the samples are eventually
written out to disk, after being acquired. But at that point, I =
don=E2=80=99t care.

For tests where I am also acquiring long term idle statistics, over many
hours, I never run a trace at the same time, and only sample the system =
once
per minute. For those test scenarios, when a trace is required, i.e. for
greater detail, it is done as an independent step. But yes, for my very =
high
idle state 0 entry/exit per unit time type tests, enabling trace has a =
very
significant effect on the system under test. I haven't figured out a way =
around that.
For example the test where ~6 gigabytes of trace data was collected in
2 minutes, at a cost of ~25% performance drop
(https://marc.info/?l=3Dlinux-pm&m=3D153897853630373&w=3D2)
For comparison, the 12 client Phoronix dbench test trace on kernel =
4.20-rc1
(baseline reference for TEO V3 tests) was only 199 Megabytes in 10 =
minutes.

... Doug
