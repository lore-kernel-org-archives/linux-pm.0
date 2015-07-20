From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/3] ACPI / cpufreq: ACPI processor driver and ACPI cpufreq driver cleanups
Date: Tue, 21 Jul 2015 00:12:21 +0200
Message-ID: <1504169.B7TvYS4CS0@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 18, 2015 03:13:41 AM Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches clean up a couple of things in the ACPI processor
> driver and the ACPI cpufreq driver:
> 
> [1/2] Drop the unused first argument of acpi_processor_unregister_performance().
> [2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.

New versios of the two above (as [2/3] and [3/3], respectively) plus one
more ACPI cpufreq driver cleanup (discussed on linux-pm previously).

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
