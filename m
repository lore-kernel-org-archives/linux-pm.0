From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/2] cpufreq: intel_pstate: Base frequency attribute
Date: Fri, 12 Oct 2018 10:20:13 +0200
Message-ID: <CAJZ5v0i3_2pxX48iZOwm+AyuU12E2g-bEnxNEaFURUsXyJpX3w@mail.gmail.com>
References: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Prashanth Prakash <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, devel@acpica.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 9, 2018 at 11:46 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> This series presents base frequency to cpufreq sysfs when intel_pstate
> is in use in HWP mode.
>
> Changes:
> v2
> - Removed guaranteed attribute addition to acpi_cppc sysfs
> - Using the cppc_acpi interface to get base frequency and present

The code changes are fine by me, but what about documenting the new sysfs attr?

Thanks,
Rafael
