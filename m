From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cpufreq: Intel P state driver: add cycle counter for clock
 frequency monitoring
Date: Tue, 19 Jul 2016 00:06:01 +0200
Message-ID: <7b9c4007-bcc1-c2b2-86dc-d93c9a8031ed@osadl.org>
References: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
 <1468859382.13661.167.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:41964 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbcGRWKR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jul 2016 18:10:17 -0400
In-Reply-To: <1468859382.13661.167.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi Srinivas,

>> Most cpufreq drivers contain an interface to the cpufreq_stats plugin
>> that counts the time the processor stays in a given P state. The
>> Intel P
>> state driver, however, does not work on discrete P states but allows
>> to
>> run the processor at arbitrary clock frequencies within the allowed
>> range. Even if the frequencies were reduced to steps of 100 MHz, this
>> would result in too many P states.
> This is true even using acpi-cpufreq driver on Intel x86 processors for
> a while. Due to HW coordination, power limits, TDP the requested P
> state may not be honored for a given CPU. The stats shows, P states
> which are just requests.
Ah, ok.

>>  This patch, therefore, introduces the
>> additional cpufreq variable kcycles that contains the number of clock
>> cycles divided by 1000 since the most recent reboot. This allows to
>> monitor the average clock frequency during a defined time interval by
>> simply calculating the derivative. 
> Can you not use turbostat?
I've been using the acpi-cpufreq an all our systems including non-x86
ones and wanted to have a similar interface in the P state driver. If
this is not possible, I certainly can use turbostat which, however,
requires a separate data collection task.

>> With this patch, there are no longer
>> Intel processors around that do not provide a way to monitor the
>> clock
>> frequency. Such monitoring is important to fine tune a system's
>> energy
>> efficiency and to debug clock frequency modulation.
> What about using powercap/rapl? That will give more information about
> energy.
Yes, we monitor rapl-based energy consumption by default on all systems
that provide this interface.

>> (Earlier kernel versions can immediately use the now abandoned
>> function
>> intel_pstate_calc_freq(). I had to resuscitate it for kernel versions
>> where it disappeared.)
> Since the sampling function is called from scheduler hot path, we don't
> want any additional calculation.
Fair enough.

Thanks,
Carsten.
