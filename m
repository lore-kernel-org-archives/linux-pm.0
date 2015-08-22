From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] [v3] x86, suspend: Save/restore THERM_CONTROL register for suspend
Date: Sat, 22 Aug 2015 08:04:03 -0700
Message-ID: <000001d0dceb$ca97ddc0$5fc79940$@net>
References: <1440241376-31889-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:39268 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbbHVPMV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 22 Aug 2015 11:12:21 -0400
In-Reply-To: <1440241376-31889-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Chen Yu' <yu.c.chen@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, marcin.kaszewski@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@redhat.com, pavel@ucw.cz, tglx@linutronix.de, rjw@rjwysocki.net

On 2015.08.22 04:03 Chen Yu wrote:

> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> that, after resuming from S3, CPU is working at a low speed.

That bug report has restricted access, even if one creates a Red Hat
Bugzilla account. Once I created an account I got:

"Most likely the bug has been restricted for internal development processes
and we cannot grant access."

Can it be set for public access?

As a side note on this one:

The current version of the intel_pstate driver is incompatible with
any use of Clock Modulation, always resulting in driving the target
pstate to the minimum, regardless of load. The result is the apparent
CPU frequency stuck at minimum * modulation percent.

Proposed intel_pstate driver versions using some sort of C0 time again
works fine with Clock Modulation, resulting in
desired frequency * modulation percent.

The acpi-cpufreq driver works fine with Clock Modulation, resulting in
desired frequency * modulation percent.

> After investigation, it is found that, BIOS has modified the value
> of THERM_CONTROL register during S3,

There are other reports of what I think is the same issue on other
bug reports and forum posts. To confirm or deny, I am attempting to
get sufferers to do your test and report back.


