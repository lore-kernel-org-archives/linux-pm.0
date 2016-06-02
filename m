From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Thu, 2 Jun 2016 21:12:25 +0530
Message-ID: <CAKohpokG3P4PmmGVD7PcEMramLUv5yrhPY4MkEif3QH0e7EySA@mail.gmail.com>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
	<CAJZ5v0hF5vk_KPCu0xrRA3mzRBGqW4wtPODkCRk47_n5h_y7jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38034 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcFBPtk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 11:49:40 -0400
Received: by mail-it0-f54.google.com with SMTP id i127so55054023ita.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 08:49:40 -0700 (PDT)
In-Reply-To: <CAJZ5v0hF5vk_KPCu0xrRA3mzRBGqW4wtPODkCRk47_n5h_y7jw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

On 2 June 2016 at 20:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 2, 2016 at 4:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi Rafael,
>>
>> This series fixes all cpufreq drivers that provide a 'target_index'
>> callback or in other words, which provide a freq-table to cpufreq core,
>> to make sure they *only* use the 'index' argument to ->target_index()
>> with the policy->freq_table.
>>
>> This change allows us to remove the (duplicate) sorted-freq-table, which
>> was added by following series:
>>
>> [PATCH V2 0/2] cpufreq: Use sorted frequency tables
>
> Which I'm not going to apply.
>
> If this series depended on that one, please rework it.

Hi Rafael,

The first 9 patches can be applied without any dependency
on the earlier series, but not the last two.

The target of this series is to make freq-table lookup faster
and so most of its patches would make sense only if we
are trying to solve that problem. Otherwise they may not
be required at all.

I hope that you will be replying to the earlier series [1] as well,
to convey the concerns you have with it.

Thanks

--
viresh

[1] [PATCH V2 0/2] cpufreq: Use sorted frequency tables
