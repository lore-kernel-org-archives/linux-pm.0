From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update][PATCH v2 5/5] cpufreq: intel_pstate: Document the current behavior and user interface
Date: Tue, 18 Apr 2017 16:24:59 +0200
Message-ID: <1603932.3tl1vUv8H6@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan> <2495384.H9v0BLlUnK@aspire.rjw.lan> <4096353.uPKQmKGfWK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44221 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751456AbdDRObE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 10:31:04 -0400
In-Reply-To: <4096353.uPKQmKGfWK@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

Hi Jon,

On Thursday, March 30, 2017 11:01:48 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a document describing the current behavior and user space
> interface of the intel_pstate driver in the RST format and
> drop the existing outdated intel_pstate.txt document.
> 
> Also update admin-guide/pm/cpufreq.rst with proper RST references
> to the new intel_pstate.rst document.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
> Mention the previously requested target P-state in the description of the
> "Core" variant of active mode "powersave" algorithm and drop the example
> part of the "Tuning Interface in ``debugfs``" section which was off-base by
> a wide margin (thanks to Doug for pointing out these issues to me).

This was posted some time ago and all of the functionality described by it has
been in linux-next for quite a while, so I'm wondering if it's possible to
route it through the documentation tree as it epends on 
Documentation/admin-guide/pm/cpufreq.rst already in there?

I can resend it afresh if that helps.

Thanks,
Rafael
