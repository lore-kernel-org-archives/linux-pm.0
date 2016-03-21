From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq_resume warning issue
Date: Mon, 21 Mar 2016 14:04:22 +0530
Message-ID: <20160321083422.GE1803@vireshk-i7>
References: <678F3D1BB717D949B966B68EAEB446ED0A6D8624@SZXEMA509-MBX.china.huawei.com>
 <20160321073228.GC1803@vireshk-i7>
 <678F3D1BB717D949B966B68EAEB446ED0A6D96C7@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33347 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbcCUIe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 04:34:26 -0400
Received: by mail-pf0-f178.google.com with SMTP id 4so125849543pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 01:34:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6D96C7@SZXEMA509-MBX.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 21-03-16, 08:05, Zengtao (B) wrote:
> > Why doesn't you have DVFS for both the cores ?
> > 
> The CPU0 is low power, not so much benefit from dvfs, so we just design one power-domain for CPU1 to cost down. 

What CPU is that ? A7?

-- 
viresh
