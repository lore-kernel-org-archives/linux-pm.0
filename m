From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user space reporting
Date: Wed, 14 Sep 2016 03:09:32 +0200
Message-ID: <1638694.s4oPcnuXuT@vostro.rjw.lan>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49769 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1756477AbcINBDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 21:03:24 -0400
In-Reply-To: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>

On Wednesday, July 20, 2016 03:10:04 PM Al Stone wrote:
> When CPPC is being used by ACPI on arm64, user space tools such as
> cpupower report CPU frequency values from sysfs that are incorrect.
> 
> What the driver was doing was reporting the values given by ACPI tables
> in whatever scale was used to provide them.  However, the ACPI spec
> defines the CPPC values as unitless abstract numbers.  Internal kernel
> structures such as struct perf_cap, in contrast, expect these values
> to be in KHz.  When these struct values get reported via sysfs, the
> user space tools also assume they are in KHz, causing them to report
> incorrect values (for example, reporting a CPU frequency of 1MHz when
> it should be 1.8GHz).
> 
> The downside is that this approach has some assumptions:
> 
>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>    value for a processor is set to a non-zero value.
> 
>    (2) It assumes that all processors run at the same speed, or that
>    the CPPC values have all been scaled to reflect relative speed.
>    This patch retrieves the largest CPU Max Frequency from a type 4 DMI
>    record that it can find.  This may not be an issue, however, as a
>    sampling of DMI data on x86 and arm64 indicates there is often only
>    one such record regardless.  Since CPPC is relatively new, it is
>    unclear if the ACPI ASL will always be written to reflect any sort
>    of relative performance of processors of differing speeds.
> 
>    (3) It assumes that performance and frequency both scale linearly.
> 
> For arm64 servers, this may be sufficient, but it does rely on
> firmware values being set correctly.  Hence, other approaches will
> be considered in the future.
> 
> This has been tested on three arm64 servers, with and without DMI, with
> and without CPPC support.
> 
> Changes for v5:
>     -- Move code to cpufreq/cppc_cpufreq.c from acpi/cppc_acpi.c to keep
>        frequency-related code together, and keep the CPPC abstract scale
>        in ACPI (Prashanth Prakash)
>     -- Fix the scaling to remove the incorrect assumption that frequency
>        was always a range from zero to max; as a practical matter, it is
>        not (Prasanth Prakash); this also allowed us to remove an over-
>        engineered function to do this math.
> 
> Changes for v4:
>     -- Replaced magic constants with #defines (Rafael Wysocki)
>     -- Renamed cppc_unitless_to_khz() to cppc_to_khz() (Rafael Wysocki)
>     -- Replaced hidden initialization with a clearer form (Rafael Wysocki)
>     -- Instead of picking up the first Max Speed value from DMI, we will
>        now get the largest Max Speed; still an approximation, but slightly
>        less subject to error (Rafael Wysocki)
>     -- Kconfig for cppc_cpufreq now depends on DMI, instead of selecting
>        it, in order to make sure DMI is set up properly (Rafael Wysocki)
> 
> Changes for v3:
>     -- Added clarifying commentary re short-term vs long-term fix (Alexey
>        Klimov)
>     -- Added range checking code to ensure proper arithmetic occurs,
>        especially no division by zero (Alexey Klimov)
> 
> Changes for v2:
>     -- Corrected thinko: needed to have DEPENDS on DMI in Kconfig.arm,
>        not SELECT DMI (found by build daemon)
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

Applied.

Thanks,
Rafael

