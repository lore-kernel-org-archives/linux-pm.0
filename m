From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/5] x86 CPPC usage
Date: Thu, 18 Aug 2016 14:14:20 -0700
Message-ID: <1471554860.1602.17.camel@linux.intel.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63278 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754885AbcHSBpY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Aug 2016 21:45:24 -0400
In-Reply-To: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org

On Wed, 2016-08-10 at 17:17 -0700, Srinivas Pandruvada wrote:
> The x86 HWP (Hardware Controlled Performance States) is an
> implementation
> of the ACPI-defined Collaborative Processor Performance Control
> (CPPC).
> The current implementation of HWP doesn't use CPPC, but CPPC brings
> in
> some advanced features. So we will be submitting changes to use CPPC.
> 
> The first series only contains ACPI CPPC changes required for x86.
> 
Since I didn't see any major objection to this series, I will resubmit
these changes along with the use case of CPPC on x86 to support turbo
feature.

Thanks,
Srinivas

> Srinivas Pandruvada (5):
>   acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
>   acpi: cpcc: Add integer read support
>   acpi: cppc: Add support for function fixed hardware address
>   acpi: cppc: Add prefix cppc to cpudata structure name
>   acpi: bus: Enable HWP CPPC objects
> 
>  drivers/acpi/Kconfig            |  1 -
>  drivers/acpi/bus.c              |  7 ++++
>  drivers/acpi/cppc_acpi.c        | 88
> +++++++++++++++++++++++++++++++++++------
>  drivers/acpi/processor_driver.c |  5 ++-
>  drivers/cpufreq/cppc_cpufreq.c  | 14 +++----
>  include/acpi/cppc_acpi.h        |  4 +-
>  6 files changed, 95 insertions(+), 24 deletions(-)
> 
