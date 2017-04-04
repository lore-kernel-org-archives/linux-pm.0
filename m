From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very
 low thread priority
Date: Tue, 4 Apr 2017 09:43:43 +0530
Message-ID: <20170404041343.GE21029@drishya.in.ibm.com>
References: <20170403215414.16951-1-anton@ozlabs.org>
 <20170404095207.28fc5229@roar.ozlabs.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41201 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750877AbdDDENy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 00:13:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v344AZTP123983
        for <linux-pm@vger.kernel.org>; Tue, 4 Apr 2017 00:13:54 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbptsqg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2017 00:13:53 -0400
Received: from localhost
        by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
        Tue, 4 Apr 2017 09:43:50 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
        by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v344Dm1G13172914
        for <linux-pm@vger.kernel.org>; Tue, 4 Apr 2017 09:43:48 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
        by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v344Dj5D013145
        for <linux-pm@vger.kernel.org>; Tue, 4 Apr 2017 09:43:48 +0530
Content-Disposition: inline
In-Reply-To: <20170404095207.28fc5229@roar.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

* Nicholas Piggin <npiggin@gmail.com> [2017-04-04 09:52:07]:

> On Tue,  4 Apr 2017 07:54:12 +1000
> Anton Blanchard <anton@ozlabs.org> wrote:
> 
> > From: Anton Blanchard <anton@samba.org>
> > 
> > The core of snooze_loop() continually bounces between low and very
> > low thread priority. Changing thread priorities is an expensive
> > operation that can negatively impact other threads on a core.
> > 
> > All CPUs that can run PowerNV support very low priority, so we can
> > avoid the change completely.
> 
> This looks good. I have HMT_lowest() which does alt feature patching
> we can use for pseries and default idle code.

Alternatively, if we are going to set priority only once in various
other places, HMT_low(); HMT_very_low(); should not add to extra
cycles.  Let me code that up.

--Vaidy

 
