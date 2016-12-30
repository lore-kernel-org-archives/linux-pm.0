From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/3] cpufreq: intel_pstate: Locking and limits fix-ups
Date: Fri, 30 Dec 2016 09:49:03 -0800
Message-ID: <1483120143.27585.83.camel@linux.intel.com>
References: <5344750.TOCWYON8QY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1412 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbcL3Rwr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Dec 2016 12:52:47 -0500
In-Reply-To: <5344750.TOCWYON8QY@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

On Fri, 2016-12-30 at 15:54 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This series fixes a couple of possible locking issues and limits
> synchronization
> in intel pstate.
> 
> [1/3] Add locking to intel_pstate_resume().
> [2/3] Add locking to intel_cpufreq_verify_policy().
> [3/3] Always keep all limits settings in sync.
> 
Looks good to me.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


Thanks,
Srinivas
