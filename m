From: Borislav Petkov <bp@alien8.de>
Subject: Re: [TEST PATCH] cpufreq: intel_pstate: Workaround to for wrong ACPI
 perf table entry
Date: Wed, 18 Nov 2015 18:20:16 +0100
Message-ID: <20151118172015.GF4138@pd.tnic>
References: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <8524647.rknTxxgTfO@vostro.rjw.lan>
 <1447812635.2778.90.camel@spandruv-desk3.jf.intel.com>
 <CAJZ5v0ideLEQB9m-s6ApL6ub-6sdPFunf4_vspF_HR6DVzxOag@mail.gmail.com>
 <564CA83A.6080304@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44433 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbbKRRU2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 18 Nov 2015 12:20:28 -0500
Content-Disposition: inline
In-Reply-To: <564CA83A.6080304@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Nov 18, 2015 at 08:32:58AM -0800, Srinivas Pandruvada wrote:
> Here we tried to match 0xff in the _PSS and failed. From Borslov's log

That is most likely me calling

powertop --auto-tune

...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
