From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv:idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails.
Date: Fri, 4 Aug 2017 22:30:19 +0530
Message-ID: <20170804170019.GA17813@in.ibm.com>
References: <1501830262-32399-1-git-send-email-ego@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbdHDRAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 13:00:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v74GwkQZ019117
        for <linux-pm@vger.kernel.org>; Fri, 4 Aug 2017 13:00:31 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c4r3q1u58-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 04 Aug 2017 13:00:31 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Fri, 4 Aug 2017 11:00:30 -0600
Content-Disposition: inline
In-Reply-To: <1501830262-32399-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Aug 04, 2017 at 12:34:22PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently, we use the opal call opal_slw_set_reg() to inform the
> Sleep-Winkle Engine (SLW) to restore the contents of some of the
> Hypervisor state on wakeup from deep idle states that lose full
> hypervisor context (characterized by the flag
> OPAL_PM_LOSE_FULL_CONTEXT).
> 
> However, the current code has a bug in that if opal_slw_set_reg()
> fails, we don't disable the use of these deep states (winkle on
> POWER8, stop4 onwards on POWER9).
> 
> This patch fixes this bug by ensuring that if programing the
> sleep-winkle engine to restore the hypervisor states in
> pnv_save_sprs_for_deep_states() fails, then we exclude such states by
> excluding their flags supported_cpuidle_states. Further, we ensure in
> the initialization of the cpuidle-powernv driver to only include those
> states whose flags are present in supported_cpuidle_states.
> 
> Fixes: 1e1601b38e6 ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")
>
Forgot to add

Reported-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.
