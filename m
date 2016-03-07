From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Do not modify perf bias performance setting by default at boot
Date: Mon, 07 Mar 2016 17:17:10 +0100
Message-ID: <5136165.3o99Coufiu@skinner>
References: <4687430.mfM0GbdeDL@skinner> <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com> <5246881.PY2xISUnh1@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52316 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbcCGQRM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 11:17:12 -0500
In-Reply-To: <5246881.PY2xISUnh1@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>

On Monday, March 07, 2016 02:24:54 PM Thomas Renninger wrote:
> It came out that on certain CPUs perf bias MSR has to be set to performance,
> so that the CPU enters turbo states at all.
> 
> Better do not try to wrongly adjust perf bias value,
> its value probably is intended by BIOS.

This whole perf bias CPU feature and trying to adjust the value
at boot time gets more and more a mess.

I try to sum this up, try to collect some missing bits and get them
published through mailing lists. Hopefully some root causes of what
went wrong are identified and passed on to the right people to get
things fixed.

1. It started with:
commit abe48b108247e9b90b4c6739662a2e5c765ed114
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jul 14 00:53:24 2011 -0400

    x86, intel, power: Initialize MSR_IA32_ENERGY_PERF_BIAS

...
    However, the typical BIOS fails to initialize the MSR, presumably
    because this is handled by high-volume shrink-wrap operating systems...
    
    Linux distros, on the other hand, do not yet invoke x86_energy_perf_policy(8).
    As a result, WSM-EP, SNB, and later hardware from Intel will run in its
    default hardware power-on state (performance), which assumes that users
    care for performance at all costs and not for energy efficiency.
    While that is fine for performance benchmarks, the hardware's intended default
    operating point is "normal" mode...
    
    Initialize the MSR to the "normal" by default during kernel boot.
...


2. Four years later it has been identified that the boot processor's perf bias
switches back to 0 on suspend.

I wonder whether this happens generally. Or do BIOS hooks also reset the BIAS
value on suspend?

3. It has now be identified that specific CPUs can only enter Turbo modes, if
the perf BIAS value is set to 0 (performance). But the performance value cannot
be set anymore by BIOS because of above patches.


My questions:

1. If this is true:
"While that is fine for performance benchmarks, the hardware's intended default
operating point is "normal" mode..."
Then the HW (CPU) must initialize to 5 (normal).
It's not the BIOS' fault which forgets to set something,
this may always be intended.
commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
commit abe48b108247e9b90b4c6739662a2e5c765ed114

Intel must tell their microcode writers to initialize perf BIAS with 5, if this
is what Intel wants.

2. Why is the value for the boot processor reset to 0 on suspend?
Is this a platform/BIOS issue only?
Or could this be another major misdesign in perf BIAS CPU implementation.

3. What exactly was the problem?
The argumentation that the perf BIAS "should" be 5 was rather vague.
What exactly are the concequences? Getting a dirty workaround into the x86 core
code only by this information without any values or references is bad.

          Thomas

PS: I will submit the patch (revert of commit b51ef52df71cb2, 17edf2d79f1ea6d and
abe48b108247e9) now to our SLE code base.

