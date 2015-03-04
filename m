From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: intel_soc_dts_thermal binding issues
Date: Wed, 4 Mar 2015 09:04:42 -0500
Message-ID: <CA+5PVA7SZ+csY8WwMkwRa-nOmsHP8SdVe4v=mUmq38RJ4LSsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi All,

We've seen a number of reports where people see:

[   20.499427] intel_soc_dts_thermal: request_threaded_irq ret -22
[   20.519160] intel_soc_dts_thermal: request_threaded_irq ret -22
[   20.532660] intel_soc_dts_thermal: request_threaded_irq ret -22

in their boot logs.  They view this as a kernel bug and report is as
such.  The above log came from an ASUS x200ma machine, which has a
quad core Baytrail-M Pentium CPU (N3530).

I can't tell if the issue is because the driver is trying to bind to
all 4 cores and only CPU0 works, or what other issue would cause this.
I personally have a Celeron based NUC with a N2820 that gets the error
above for both cores and the driver doesn't load at all.

Is there something else the driver should be doing to bind to the
various CPUs?  If there's nothing else it can key off of, can we drop
the pr_err so it stops showing up in dmesg?

josh
