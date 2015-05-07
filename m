From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [BUG] ThinkPad T520 overheating with P-State driver
Date: Wed, 6 May 2015 19:51:19 -0700
Message-ID: <000601d08870$b2979e60$17c6db20$@net>
References: <2208008.uDRZL3Gdb7@merkaba>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:43106 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbEGCvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 May 2015 22:51:24 -0400
In-Reply-To: <2208008.uDRZL3Gdb7@merkaba>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Martin Steigerwald' <martin@lichtvoll.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 'Kristen Carlson Accardi' <kristen@linux.intel.com>

On 2015.05.06 13:37 Martin Steigerwald wrote:

> I get frequencies like:
>
> 3080566
> 3068945
> 3009082
> 2999902 

Please know that the intel_pstate driver reports actual CPU frequencies
over the last sample interval. In terms of heat, they don't mean anything,
you would have to look at how much time the CPU spent in the C0 and other states.

> Yet with acpi-cpufreq without limiting maximum performance at all, I get the 
> following with the *same* workload:

> 2501000
> 2501000
> 1000000
> 1000000

Please know that the acpi-cpufreq driver reports what frequency (pstate)
It is asking for, not what might actually be happening.
If your CPU 2 and 3 were ever active during that sample time
They would be at the same frequency as your turbostate CPU 0 or 1,
which ever is higher.

> There is also some other bug report about this:
> Please change intel_pstate default to disable 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647
> appears to be quite old, but still seems unresolved.

That bug report is very old, and is closed.
I made a late entry on that bug report on 2014.06.08,
and have submitted a patch set to deal with, among other things,
the long duration issue. 


