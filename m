From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / cpufreq: ACPI processor driver and ACPI cpufreq driver cleanups
Date: Sat, 18 Jul 2015 03:13:41 +0200
Message-ID: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pan Xinhui <xinhuix.pan@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches clean up a couple of things in the ACPI processor
driver and the ACPI cpufreq driver:

[1/2] Drop the unused first argument of acpi_processor_unregister_performance().
[2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.

Both patches on top of the current linux-next branch of the linux-pm.git tree.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
