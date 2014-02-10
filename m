From: Andy Lutomirski <luto@amacapital.net>
Subject: What should cpuinfo_cur_freq mean?
Date: Mon, 10 Feb 2014 12:47:12 -0800
Message-ID: <CALCETrVncODPCEU9_a7npHZdK-MJXJ3s7g1xsBacOW4Frxp+jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Naga Chumbalkar <nagananda.chumbalkar@hp.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

There are least three choices for what the "current frequency" is:

 1. The frequency that the cpufreq driver thinks it has requested.
This shows up in scaling_cur_freq.

 2. The frequency that is actually programmed into the CPU.  This is
what acpi_cpufreq's cpuinfo_cur_freq reports.

 3. A measurement of the number of cycles per unit time that are
currently or recently happening.  This is what intel_pstate reports.

The fact that acpi-cpufreq and intel_pstate behave differently here is
unfortunate.  I have servers [1] with broken BIOS that occasionally
screw up the requested P-state (i.e. MSR 0x199).  With acpi_cpufreq
loaded, I can at least tell that there's a problem by reading
cpuinfo_cur_freq.  With intel_pstate loaded, I get a rapidly
fluctuating value that depends on Turbo's current mood.

Can we separate out these concepts into separate sysfs files?

[1] These are fully up-to-date, recent generation Dell servers.
