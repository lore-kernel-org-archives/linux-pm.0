From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v2] cpufreq: intel_pstate: Generic governors support
Date: Thu, 17 Nov 2016 09:27:15 -0800
Message-ID: <000301d240f7$d86604b0$89320e10$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: 6pwucKlLvdmHH6pwzcpEkV
In-Reply-To: 6pwucKlLvdmHH6pwzcpEkV
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016.11.15 18:35 Rafael J. Wysocki wrote:

> -> v2:
> Notice that intel_cpufreq_target() generally can be called on a CPU
> different from the target one, so it needs to ensure that the right
> MSR will be written, so update the code accordingly.  This makes
> the performance and powersave governors work with this driver as
> expected (at least).

With V2 I did the exact same tests with the ondemand, powersave,
and performance governors as I did with the previous versions 
of this patch. Now everything works fine and as expected.

Thanks.

Also from this previous reply to 
"[RFC/RFT][PATCH] cpufreq: intel_pstate: Generic governors support":

On 2016.11.01 17:14 Srinivas Pandruvada wrote:
> On Tue, 2016-11-01 at 14:11 -0700, Doug Smythies wrote:
>> On 2016.10.22 17:17 Rafael J. Wysocki wrote: 
>> 
>> It is not clear to me why users that currently use
>> intel_pstate=disable on the kernel command line would benefit from
>> this change.
> Two reasons I think:
> - We have a big turbo zone, where current acpi-cpufreq can't select any
> target frequency even if controllable.
>
> - We can still target ACPI-CPPC compatible devices in legacy mode and
> later in non-legacy mode.

V2 also fixes the test results (I was using clock modulation as
my test case), that caused me to erroneously think there would
be no benefit from intel_pstate=passive over intel_pstate=disable
in cases where the user has to use disable for proper operation.

... Doug
