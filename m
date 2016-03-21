From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_resume warning issue
Date: Mon, 21 Mar 2016 15:14:41 +0530
Message-ID: <20160321094441.GC27778@vireshk-i7>
References: <678F3D1BB717D949B966B68EAEB446ED0A6D8624@SZXEMA509-MBX.china.huawei.com>
 <20160321073228.GC1803@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D96C7@SZXEMA509-MBX.china.huawei.com>
 <20160321083422.GE1803@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D9738@SZXEMA509-MBX.china.huawei.com>
 <20160321090920.GB27778@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D9756@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36418 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcCUJop (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 05:44:45 -0400
Received: by mail-pf0-f177.google.com with SMTP id u190so259653187pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 02:44:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6D9756@SZXEMA509-MBX.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 21-03-16, 09:26, Zengtao (B) wrote:
> Actually the freq is tunable, but voltage is fixed, So we fix it to a high freq because little benefit by freq tuning.

Okay, then just enable cpufreq and select performace governor for it, which will
select the highest frequency for the CPU.

> Since the DVFS has percpu dvfs policy, so I think it is reasonable to allow cpu to disable dvfs, what do you think about that?

Its not that we can't update core code for some specific use cases, but here you
should be using cpufreq core for the CPU0 as well, with a proper governor which
would not have any overheads during operations.

-- 
viresh
