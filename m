From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powernv:idle: Change return type of
 pnv_probe_idle_states to int
Date: Fri, 7 Jul 2017 17:56:38 +0530
Message-ID: <20170707122638.GB8913@in.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
 <20170707010149.7526c784@roar.ozlabs.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750938AbdGGMez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 08:34:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v67CYQen121734
        for <linux-pm@vger.kernel.org>; Fri, 7 Jul 2017 08:34:55 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bhw6e9xk9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 08:34:55 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Fri, 7 Jul 2017 08:34:51 -0400
Content-Disposition: inline
In-Reply-To: <20170707010149.7526c784@roar.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hello Nicholas,

On Fri, Jul 07, 2017 at 01:01:49AM +1000, Nicholas Piggin wrote:
> On Wed,  5 Jul 2017 22:08:13 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > In the current idle initialization code, if there are failures in
> > pnv_probe_idle_states, then no platform idle state is
> > enabled. However, since the error is not propagated to the top-level
> > function pnv_init_idle_states, we continue initialization in this
> > top-level function even though this will never be used.
> > 
> > Hence change the the return type of pnv_probe_idle_states from void to
> > int and in case of failures, bail out early on in
> > pnv_init_idle_states.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Looks good to me.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> I wonder if the warnings are strong enough here to let people know
> idle won't be used so power consumption will be high and performance
> significantly reduced on SMT machines?

Good point. Will try to print an error message to this effect.

--
Thanks and Regards
gautham.
