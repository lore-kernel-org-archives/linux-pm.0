From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] Force cppc_cpufreq to report values in KHz to fix
 user space reporting
Date: Thu, 19 May 2016 15:46:19 +0530
Message-ID: <20160519101619.GJ32001@vireshk-i7>
References: <1463614882-26101-1-git-send-email-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463614882-26101-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18-05-16, 17:41, Al Stone wrote:
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
> While the investigation for a long term fix proceeds (several options
> are being explored, some of which may require spec changes or other
> much more invasive fixes), this patch forces the values read by CPPC
> to be read in KHz, regardless of what they actually represent.
> 
> The downside is that this approach has some assumptions:
> 
>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>    value for a processor is set to a non-zero value.
> 
>    (2) It assumes that all processors run at the same speed, or that
>    the CPPC values have all been scaled to reflect relative speed.
>    This patch retrieves the first CPU Max Frequency from a type 4 DMI
>    record that it can find.  This may not be an issue, however, as a
>    sampling of DMI data on x86 and arm64 indicates there is often only
>    one such record regardless.  Since CPPC is relatively new, it is
>    unclear if the ACPI ASL will always be written to reflect any sort
>    of relative performance of processors of differing speeds.
> 
>    (3) It assumes that performance and frequency both scale linearly.
> 
> For arm64 servers, this may be sufficient, but it does rely on
> firmware values being set correctly.  Hence, other approaches are
> also being considered.
> 
> This has been tested on three arm64 servers, with and without DMI, with
> and without CPPC support.
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
> ---
>  drivers/acpi/cppc_acpi.c    | 96 ++++++++++++++++++++++++++++++++++++++++++---
>  drivers/cpufreq/Kconfig.arm |  1 +
>  2 files changed, 92 insertions(+), 5 deletions(-)

I can't keep it unread in my Inbox forever and so I am replying here
to mark it read :)

I don't have enough knowledge of this stuff and so I leave it for
Ashwin and Rafael to do it. :)

-- 
viresh
