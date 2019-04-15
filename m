Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF2EC10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0B6218DA
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 18:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfDOSD7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:03:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:25531 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfDOSD7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Apr 2019 14:03:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 11:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="164943833"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2019 11:03:58 -0700
Message-ID: <1411b93ccc156d6712b9e9bb7ba3e03049489c02.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86: intel_pstate: Fix wrong definition of Disable
 Energy Efficiency Optimization bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date:   Mon, 15 Apr 2019 11:03:58 -0700
In-Reply-To: <CDD74CD9-4DF0-4403-8140-12008DB86E7A@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
         <d1825fdb9b1c9d759bcfefa7ef80a380cd9ece78.camel@linux.intel.com>
         <CDD74CD9-4DF0-4403-8140-12008DB86E7A@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-04-15 at 11:32 +0300, Liran Alon wrote:
> > On 15 Apr 2019, at 5:00, Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
> > > Bit definition can be found in Intel SDM Section 2.16 MSRS IN THE
> > > 6TH
> > > GENERATION, 7TH GENERATION AND 8TH GENERATION
> > > INTEL® CORE™ PROCESSORS, INTEL® XEON® PROCESSOR SCALABLE
> > > FAMILY, AND FUTURE INTEL® CORE™ PROCESSORS.
> > > 
> > > Definition of all Skylake MSR_POWER_CTL bits can also be found at
> > > EDK2
> > > source at UefiCpuPkg/Include/Register/Msr/SkylakeMsr.h union
> > > MSR_SKYLAKE_POWER_CTL_REGISTER.
> > > 
> > > Fixes: 6e978b22efa1 ("cpufreq: intel_pstate: Disable energy
> > > efficiency optimization")
> > 
> > What are you trying to address? This bit 19 has a special meaning
> > when
> > system is in HWP mode. So this is correct.
> > 
> > Bit 20 has a different meaning depending on legacy or in HWP mode.
> > 
> > Thanks,
> > Srinivas
> > 
> 
> Maybe I’m misinterpreting Intel SDM, but it seems to me that bit 19
> in MSR_POWER_CTL is always "Disable Race to Halt Optimization (R/W)”
> while bit 20 is the "Disable Energy Efficiency Optimization (R/W)”.
> 
> I didn’t find a place in Intel SDM where it is discussed that bit 19
> have a special meaning when system is in HWP mode.
> Can you point me to relevant place in Intel SDM?
> 

SDM doesn't describe the algorithms. This is a feature of Intel Speed
Shift Technology aka HWP. Both bits target disabling some energy
efficiency features of the processor. I wish there are some better
names of these bits. Ideas is to pick the best for a platform based on
the performance needs. Here based on the experiments, setting bit 19
gave the required performance on Kaby Lake desktops.

So unless you found some performance/power issue with setting of bit 19
vs bit 20, on Kaby Lake based platforms, we shouldn't change (may be
rename as per SDM definition).

Thanks,
Srinivas

> Thanks,
> -Liran
> 

