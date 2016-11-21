From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/12] thermal/x86_pkg_temp: Sanitize yet another hotplug
 and locking trainwreck
Date: Mon, 21 Nov 2016 22:34:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611212228220.3677@nanos>
References: <20161117231435.891545908@linutronix.de> <1479758532.6544.169.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1838706425-1479764079=:3677"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57640 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbcKUVhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 16:37:43 -0500
In-Reply-To: <1479758532.6544.169.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "rt@linutronix.de" <rt@linutronix.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1838706425-1479764079=:3677
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 21 Nov 2016, Pandruvada, Srinivas wrote:

> On Fri, 2016-11-18 at 00:03 +0000, Thomas Gleixner wrote:
> > We solely intended to convert that driver to the hotplug state
> > machine and
> > stumbled over a large pile of insanities, which are all interwoven
> > with the
> > package management:
> 
> Thanks Thomas for fixes.
> But I did a very simple test on 4.9.0-rc5 on a client machine, just
> rmmod and read zone, it will cause crash. I have not tested on a multi-
> socket system, which is also required where the real test of  last cpu
> on a package goes offline can be tested.

Stupid me. I tested putting a socket offline, which works, but did not
check what happens on module removal. Delta fix below. That needs to be
folded into the series as the wreckage already happens before the last
patch.

Thanks,

	tglx

8<--------------------
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -63,6 +63,7 @@ struct pkg_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
+	struct cpumask			cpumask;
 };
 
 static struct thermal_zone_params pkg_temp_tz_params = {
@@ -391,6 +392,7 @@ static int pkg_temp_thermal_device_add(u
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, pkgdev->msr_pkg_therm_low,
 	      pkgdev->msr_pkg_therm_high);
 
+	cpumask_set_cpu(cpu, &pkgdev->cpumask);
 	spin_lock_irq(&pkg_temp_lock);
 	packages[pkgid] = pkgdev;
 	spin_unlock_irq(&pkg_temp_lock);
@@ -399,13 +401,15 @@ static int pkg_temp_thermal_device_add(u
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
 {
-	int target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
 	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
 	bool lastcpu, was_target;
+	int target;
 
 	if (!pkgdev)
 		return 0;
 
+	target = cpumask_any_but(&pkgdev->cpumask, cpu);
+	cpumask_clear_cpu(cpu, &pkgdev->cpumask);
 	lastcpu = target >= nr_cpu_ids;
 
 	/*
@@ -492,8 +496,10 @@ static int pkg_thermal_cpu_online(unsign
 		return -ENODEV;
 
 	/* If the package exists, nothing to do */
-	if (pkgdev)
+	if (pkgdev) {
+		cpumask_set_cpu(cpu, &pkgdev->cpumask);
 		return 0;
+	}
 	return pkg_temp_thermal_device_add(cpu);
 }
 


--8323329-1838706425-1479764079=:3677--
