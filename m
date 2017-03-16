From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] intel_pstate: More fixes related to limits
Date: Thu, 16 Mar 2017 13:22:02 +0100
Message-ID: <2197582.ZRFqQc3Dx5@aspire.rjw.lan>
References: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64555 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752317AbdCPM1l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 08:27:41 -0400
In-Reply-To: <2130954.RIJyMN1BRu@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

On Tuesday, March 14, 2017 04:14:54 PM Rafael J. Wysocki wrote:
> Hi,
> 
> Three limits-related fixes more.
> 
> [1/3] fixes a regression introduced by another recent fix.
> 
> [2/3] gets rid of excessive rounding errors in computations.
> 
> [3/3] makes limits work in the most straightforward way possible.
> 
> On top of https://patchwork.kernel.org/patch/9622401/ .

Patches [1/3] and [3/3] from this series went too far for this stage of the cycle,
so I'm withdrawing them.  I'll send a replacement fix for the regression addressed
by the [1/3] shortly.

Patch [2/3] is still relevant, though.

Thanks,
Rafael
