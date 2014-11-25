From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 25 Nov 2014 16:44:16 +0530
Message-ID: <CAKohpomC=54PDxf+ry4LRGr6mJfAvGe3PnX+iy=TzBq1yF_4FA@mail.gmail.com>
References: <20141125054226.GA20738@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:58656 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbaKYLOR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 06:14:17 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so199780qab.16
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 03:14:16 -0800 (PST)
In-Reply-To: <20141125054226.GA20738@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>

On 25 November 2014 at 11:12, Srinidhi Kasagar
<srinidhi.kasagar@intel.com> wrote:
> This adds the SFI based cpu freq driver for some of the Intel's
> Silvermont based Atom architectures like Z34xx and Z35xx.
>
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>

> v6:
> * release the mutex in case of error in register_performance
> (comments from Viresh)
> * drop local perf pointer in ->target and ->init
> * fix the order of freeing memories in the error path of ->init
> * remove alloc_percpu, rather allocate it at runtime in ->init

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
