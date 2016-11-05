From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 05 Nov 2016 19:21:42 +0800
Message-ID: <1478344902.2206.8.camel@intel.com>
References: <20161104083849.GA32688@amd> <20161104085830.GA4089@amd>
         <1478268311.26953.17.camel@intel.com> <20161104204439.GA2581@amd>
         <20161104221600.GA7007@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2884 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbcKELV7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Nov 2016 07:21:59 -0400
In-Reply-To: <20161104221600.GA7007@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Fri, 2016-11-04 at 23:16 +0100, Pavel Machek wrote:
> Hi!
> 
> > 
> > I'd prefer mails over bugzilla for now...
> > 
> > 4.9-rc2 has bios_limit:
> > 
> > pavel@duo:~$ cat /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
> > 1833000
> > 
> > and it has thermal zones:
> > 
> > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp 127000
> > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type
> > critical
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp 97000
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_type
> > critical
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp 92500
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_type
> > passive
> > 
> > ..so it should slow down CPU at 92C.
> > 
> > So lets push the temperature up a bit...
> > 
> > sudo watch cat /proc/acpi/ibm/thermal
> > /sys/devices/system/cpu/cpu0/cpufreq/bios_limit
> > /sys/devices/virtual/thermal/thermal_zone1/temp  /sys/devices/syste
> > m/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> > 
> > temperatures:   98 49 -128 85 28 -128 28 -128 49 58 -128 -128 -128
> > -128 -128 -128
> > 1833000
> > 95000
> > 1833000
> > 
> > Hmm. bios_limit does not seem to change, even when the temperature
> > is
> > clearly above the trip point. (It is also interestng that acpi/ibm
> > reports bigger temperatures than
> > /sys/devices/virtual/thermal/thermal_zone1/temp . I have seen 103C
> > there.)
> Under v4.8-rc, behaviour is different: bios_limit goes to 1GHz there
> when temperature is around 84C at the thermal zone.
>  That keeps
> ibm/thermal temperatures under 90C, and no "thermal emergency"
> messages in syslog.
> 
> So we seem to have thermal or ACPI regression in v4.9-rc3.
> 
To me, there are two problems,
the first one is a 4.9-rc regression that BIOS limit stops working,
results in overheating because of high cpu frequency. I agree with
Srinivas to check acpi_cpufreq driver code for this one.
the second problem is that thermal passive cooling can not prevent the
system from overheating, when there is no BIOS limit. To debug this,
you can enable thermal dynamic debug by
echo 'module thermal_sys +fp' > /sys/kernel/debug/dynamic_debug/control

thanks,
rui
> Best regards,
>  
>  									
> Pavel
>  
