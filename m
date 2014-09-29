From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Mon, 29 Sep 2014 02:05:15 -0700
Message-ID: <CAKohponrb872=EDKea8U+j8ofOF0cs75Nh6VehByXWZhj1eCUQ@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<28824009.MYR6qnPOLR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34026 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaI2JFQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 05:05:16 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so1789061qcy.16
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 02:05:16 -0700 (PDT)
In-Reply-To: <28824009.MYR6qnPOLR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Yuantian Tang <yuantian.tang@freescale.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, Li Yang <leoli@freescale.com>

On 24 September 2014 16:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, September 02, 2014 09:11:24 AM Viresh Kumar wrote:
>> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
>> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
>> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> I'm not sure about the status here?

Apply only the first patch (1/2) with

Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>
