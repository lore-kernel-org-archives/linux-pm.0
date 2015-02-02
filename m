From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle states from DT if available
Date: Mon, 02 Feb 2015 17:09:17 +1100
Message-ID: <m3fvaou9o2.fsf@oc8180480414.ibm.com>
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:37069 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbbBBGJZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Feb 2015 01:09:25 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Mon, 2 Feb 2015 01:09:24 -0500
In-Reply-To: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, use better
> APIs to parse the powermgmt device tree node so as to avoid endianness
> transformation.
>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Same acked-by as before, from perspective of "I merged the firmware side
of things" and things look godo in relation to firmware PoV.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

