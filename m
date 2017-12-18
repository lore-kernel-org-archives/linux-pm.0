From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 3/3] powernv-cpufreq: Treat pstates as opaque 8-bit
 values
Date: Mon, 18 Dec 2017 14:13:29 +0530
Message-ID: <20171218084329.GB28881@in.ibm.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <1513148261-21097-4-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=qMNECSSfVGXNfN9JfxAZUB86-dwtx1ZCicmj7b7Kweg@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757933AbdLRInf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 03:43:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBI8cgQ9065951
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 03:43:35 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ex6eq8evh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 03:43:34 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 18 Dec 2017 03:43:34 -0500
Content-Disposition: inline
In-Reply-To: <CAKTCnz=qMNECSSfVGXNfN9JfxAZUB86-dwtx1ZCicmj7b7Kweg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

Hi Balbir,

On Sun, Dec 17, 2017 at 02:17:02PM +1100, Balbir Singh wrote:
> On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
[..snip..]
> >
> > -static inline int extract_pstate(u64 pmsr_val, unsigned int shift)
> > +static inline u8 extract_pstate(u64 pmsr_val, unsigned int shift)
> >  {
> > -       int ret = ((pmsr_val >> shift) & 0xFF);
> > -
> > -       if (!ret)
> > -               return ret;
> > -
> > -       return (pstate_sign_prefix | ret);
> > +       return ((pmsr_val >> shift) & 0xFF);
> >  }
> 
> So we just added this and moved from an int to u8. I was going to ask
> if we still need an int in patch1, but I thought the driver dealt with
> just integers because of the larger framework.

The larger framework is with respect to the device tree which defines
pstates as 32-bit integers (I am not aware of the reasons for this
choice, but perhaps device-tree doesn't have a s8/u8 type?!). The
driver still knows that pstates are only 8-bits wide because of the
PMSR,PMCR definitions. Before this patch, the driver was still doing
the conversions from 8-bit to int and vice-versa every time. With this
patch, we do it only once, i.e at the initialization. After that we
treat pstates as 8-bit integers. 


> 
> Balbir Singh.
> 
