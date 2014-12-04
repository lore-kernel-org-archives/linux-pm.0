From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 4 Dec 2014 09:05:53 +0530
Message-ID: <CAOh2x==6j6m5_5aKt=rwLPAh6_pBCBvafeCo6OKUb40zMaik-g@mail.gmail.com>
References: <20141125054226.GA20738@intel-desktop>
	<CAJvTdKku-ioem5iP0xz=uFkom2XMsKMrRHQ7k8vD5FFKt33P9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58106 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaLDDfy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 22:35:54 -0500
Received: by mail-vc0-f174.google.com with SMTP id id10so7541042vcb.19
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 19:35:53 -0800 (PST)
In-Reply-To: <CAJvTdKku-ioem5iP0xz=uFkom2XMsKMrRHQ7k8vD5FFKt33P9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On Thu, Dec 4, 2014 at 8:51 AM, Len Brown <lenb@kernel.org> wrote:
> I like this trend:
>
> drivers/cpufreq/sfi-cpufreq.c |  529 +++++++++++++++++++++++++++++++++++++++++
> v1: drivers/cpufreq/sfi-cpufreq.c |  426
> +++++++++++++++++++++++++++++++++++++++++
> v2: drivers/cpufreq/sfi-cpufreq.c |  332
> +++++++++++++++++++++++++++++++++++++++++
> v3: drivers/cpufreq/sfi-cpufreq.c |  326
> +++++++++++++++++++++++++++++++++++++++++
> v4: drivers/cpufreq/sfi-cpufreq.c |  317
> +++++++++++++++++++++++++++++++++++++++++
> v5: drivers/cpufreq/sfi-cpufreq.c         |  238
> +++++++++++++++++++++++++++++++++
> v6: drivers/cpufreq/sfi-cpufreq.c         |  230
> +++++++++++++++++++++++++++++++++

Nice outcome of our reviews :)

> On Tue, Nov 25, 2014 at 12:42 AM, Srinidhi Kasagar
> <srinidhi.kasagar@intel.com> wrote:
>
>> +++ b/drivers/cpufreq/sfi-cpufreq.c
>
>> +#define SFI_FREQ_MASK          0xff00
>> +
>> +static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
>> +static DEFINE_MUTEX(performance_mutex);
>
> I'm not sure that cpufreq is able to call driver init's in parallel,
> so I'm not sure that the driver init needs to lock against other
> invocations of itself.

No. Its not possible.
