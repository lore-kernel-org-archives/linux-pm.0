From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Wed, 8 Jul 2015 10:21:03 +0530
Message-ID: <20150708045103.GA19130@linux>
References: <559BC96E.8020804@intel.com>
 <20150707171126.GB12491@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34597 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbbGHEvV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 00:51:21 -0400
Received: by pabvl15 with SMTP id vl15so124741616pab.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 21:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150707171126.GB12491@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pan Xinhui <xinhuix.pan@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

Hi Dmitry,

On 07-07-15, 10:11, Dmitry Torokhov wrote:
> > +	data = policy->driver_data;
> > +	cpufreq_cpu_put(policy);
> 
> If we put policy here can we guarantee that memory pointed to by data
> stays valid? Shoudln't we issue cpufreq_cpu_put(policy) after we done
> assessing the pointer?

Ideally yes, you are right. But this was a special case as a callback
of the cpufreq-driver is being called and any such issues must be
handled at the core level, it at all they are relevant.

So probably we can do cpufreq_cpu_put() as soon as we have used it.

-- 
viresh
