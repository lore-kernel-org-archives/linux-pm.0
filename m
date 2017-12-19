From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
Date: Tue, 19 Dec 2017 14:50:37 +0530
Message-ID: <20171219092037.GA27991@in.ibm.com>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
 <20171214044239.GU3322@vireshk-i7>
 <93cc9d38-4fd8-d340-2263-108329b69b94@linux.vnet.ibm.com>
 <20171218082935.GH19815@vireshk-i7>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935685AbdLSJUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 04:20:43 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBJ9Jh8g008595
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2017 04:20:42 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2exyt7gude-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2017 04:20:42 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 19 Dec 2017 04:20:41 -0500
Content-Disposition: inline
In-Reply-To: <20171218082935.GH19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Abhishek <huntbag@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hi Viresh,
On Mon, Dec 18, 2017 at 01:59:35PM +0530, Viresh Kumar wrote:
> On 18-12-17, 10:41, Abhishek wrote:
> > We need to do it in this way as the current implementation takes the max of
> > the PMSR of the cores. Thus, when the frequency is required to be ramped up,
> > it suffices to write to just the local PMSR, but when the frequency is to be
> > ramped down, if we don't send the IPI it breaks the compatibility with P8.
> 
> Looks strange really that you have to program this differently for speeding up
> or down. These CPUs are part of one cpufreq policy and so I would normally
> expect changes to any CPU should reflect for other CPUs as well.
> 
> @Goutham: Do you know why it is so ?
> 

These are due to some implementation quirks where the platform has
provided a PMCR per-core to be backward compatible with POWER8, but
controls the frequency at a quad-level, by taking the maximum of the
four PMCR values instead of the latest one. So, changes to any CPU in
the core will reflect on all the cores if the frequency is higher than
the current frequency, but not necessarily if the requested frequency
is lower than the current frequency.

Without sending the extra IPIs, we will be breaking the ABI since if
we set userspace governor, and change the frequency of a core by
lowering it, then it will not reflect on the CPUs of the cores in the
quad.

Abhishek,
I think we can rework this by sending the extra IPIs only in the
presence of the quirk which can be indicated through a device-tree
parameter. If the future implementation fix this, then we won't need
the extra IPIs.

> -- 
> viresh
> 
