From: Borislav Petkov <bp@alien8.de>
Subject: Re: 37afb0003242 ("cpufreq: intel_pstate: Use ACPI perf
 configuration") makes intel_pstate kaputt
Date: Tue, 17 Nov 2015 19:14:27 +0100
Message-ID: <20151117181427.GH8819@pd.tnic>
References: <20151117090947.GC8819@pd.tnic>
 <7244050.99ueqT3SFL@vostro.rjw.lan>
 <1447779990.2778.47.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34514 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbKQSOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 13:14:37 -0500
Content-Disposition: inline
In-Reply-To: <1447779990.2778.47.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Nov 17, 2015 at 09:06:30AM -0800, Srinivas Pandruvada wrote:
> Also can you try with processor.ignore_ppc=1 in kernel command line.

Doesn't change anything.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
