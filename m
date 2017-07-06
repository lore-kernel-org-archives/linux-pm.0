From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] powernv:idle: Change return type of
 pnv_probe_idle_states to int
Date: Fri, 7 Jul 2017 01:01:49 +1000
Message-ID: <20170707010149.7526c784@roar.ozlabs.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
        <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34665 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdGFPCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 11:02:03 -0400
In-Reply-To: <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed,  5 Jul 2017 22:08:13 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In the current idle initialization code, if there are failures in
> pnv_probe_idle_states, then no platform idle state is
> enabled. However, since the error is not propagated to the top-level
> function pnv_init_idle_states, we continue initialization in this
> top-level function even though this will never be used.
> 
> Hence change the the return type of pnv_probe_idle_states from void to
> int and in case of failures, bail out early on in
> pnv_init_idle_states.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I wonder if the warnings are strong enough here to let people know
idle won't be used so power consumption will be high and performance
significantly reduced on SMT machines?
