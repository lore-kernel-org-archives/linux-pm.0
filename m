From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Tue, 5 Apr 2016 04:20:47 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com> <20160405031152.GA22836@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160405031152.GA22836@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rcochran@linutronix.de" <rcochran@linutronix.de>, "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The first idle driver to register with cpuidle wins.

intel_idle should always get the opportunity
to probe and register before acpi_idle (processor_idle.c)

When intel_idle was allowed to be modular,
some distros build their kernel and loaded modules
such that acpi_idle could probe first.  In such
a kernel, intel_idle became dead code.

As intel_idle is a small driver, the q	uick fix
was to make it Y/N so that it would always probe
before acpi_idle, no matter how acpi_idle
is build and loaded.

Yes, even though intel_idle is a tiny driver, I think
it would be good to be able to unload it when it doesn't probe.

Today, it appears that acpi_idle (acpi/processor_idle.c)
is compiled Y/N.

thanks,
-Len

ps.

No, I do not believe that cpuidle should bother
supporting changing idle drivers at run-time.
