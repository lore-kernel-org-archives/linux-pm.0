From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Resend][PATCH] cpufreq: intel_pstate: Document the current behavior and user interface
Date: Fri, 12 May 2017 22:47:25 +0200
Message-ID: <67965801.hz0ikIzEtN@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan> <4096353.uPKQmKGfWK@aspire.rjw.lan> <1740586.nd9tWxCWqD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47119 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755994AbdELUx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2017 16:53:58 -0400
In-Reply-To: <1740586.nd9tWxCWqD@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Documentation <linux-doc@vger.kernel.org>

On Friday, May 05, 2017 11:38:42 PM Rafael J. Wysocki wrote:
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
> Hi Jon,
> 
> All of the dependencies for this patch have been merged, so I can route it
> through the PM tree.
> 
> Please let me know if you prefer to take it into the documentation tree instead.

I'm taking the lack of response as the lack of objections, so I'll route this
document through the PM tree.

Thanks,
Rafael
