From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/4] CPPC only changes for supporting ITMT 3.0
Date: Tue, 13 Sep 2016 00:13:59 +0200
Message-ID: <1885104.hSQlA9UJk6@vostro.rjw.lan>
References: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, alexey.klimov@arm.com
List-Id: linux-pm@vger.kernel.org

On Thursday, September 01, 2016 01:37:07 PM Srinivas Pandruvada wrote:
> This patchset is CPPC only changes from original "Support Intel® Turbo
> Boost Max Technology 3.0" series.
> 
> v2
> - Rebased on top of bleeding edge branch of Linux-pm git 
> - Instead of #ifdef in cppc_acpi using __weak attribute for
> functions implemented in arch/x86/kernel/acpi/
> - Removed integer support patch as this was already implemented
> in the latest code base
> - Instead of error return print warning on cppc probe failure
> 
> Srinivas Pandruvada (4):
>   acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
>   acpi: cppc: Don't return on CPPC probe failure
>   acpi: cppc: Add support for functional fixed hardware address
>   acpi: cppc: Add prefix cppc to cpudata structure name

All applied.

Thanks,
Rafael

