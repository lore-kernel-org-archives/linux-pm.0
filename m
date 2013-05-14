From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 15:52:40 +0530
Message-ID: <CAKohponfQ11Ak9Q-HmSK83g1XB5_KF0UDHaSQh_jiEZBNtSUMw@mail.gmail.com>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com>
	<51914FC3.7080003@linux.vnet.ibm.com>
	<2474384.pn7hhNIAGR@vostro.rjw.lan>
	<65F5F98566038744B1B43C8FD3B7549F191199BC@IRSMSX104.ger.corp.intel.com>
	<51920D6B.7030904@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46176 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab3ENKWl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2013 06:22:41 -0400
Received: by mail-ob0-f177.google.com with SMTP id wn6so104206obc.8
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2013 03:22:40 -0700 (PDT)
In-Reply-To: <51920D6B.7030904@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Jarzmik, Robert" <robert.jarzmik@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 14 May 2013 15:39, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> And losing permissions isn't specific to suspend-to-ram right?
> You said that yourself, that on regular cpu online/offline you lose
> the changed permissions. So just write a resume hook to restore whatever
> permissions you want after suspend-resume. See /usr/lib64/pm-utils/sleep.d
> for some sample resume scripts.

This is what i feel about losing chages on cpu hotplug/unplug:
- On normal online/offline, we aren't required to preserve earlier settings.
- But on suspend/resume, user shouldn't know that cpus have been
  removed/added and so permissions should stay as is.

What do you say?
