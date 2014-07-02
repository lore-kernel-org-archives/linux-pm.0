From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/14] clk: Create of_clk_shared_by_cpus()
Date: Wed, 2 Jul 2014 07:27:37 +0530
Message-ID: <CAKohpomaHVYsjJmQ+FyMDkgVTm-YYb7UjBP3SAqRMkY6fWcpwg@mail.gmail.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<5f7164d789e87c62d722b575980c92dfd0504334.1404231535.git.viresh.kumar@linaro.org>
	<53B2F741.2000501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44878 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbaGBB5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 21:57:38 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so11548722oag.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2014 18:57:37 -0700 (PDT)
In-Reply-To: <53B2F741.2000501@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <rob.herring@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, linux-arm-msm@vger.kernel.org, Sachin Kamat <spk.linux@gmail.com>, Thomas P Abraham <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Tomasz Figa <t.figa@samsung.com>, Mike Turquette <mturquette@linaro.org>

On 1 July 2014 23:30, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/01/14 09:32, Viresh Kumar wrote:
>> Create a new routine of_clk_shared_by_cpus() that finds if clock lines are
>> shared between two CPUs. This is verified by comparing "clocks" property from
>> CPU's DT node.
>>
>> Returns 1 if clock line is shared between them, 0 if clock isn't shared and
>> return appropriate errors in case nodes/properties are missing.
>>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/clk/clk.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/clk.h |  6 ++++++
>
> This doesn't make much sense to me. This function doesn't deal with
> struct clk pointers or any of the internals of the common clock
> framework so why put it in clk.c? It looks more like an internal
> function that the cpufreq-generic driver should have.

I thought this is what Rob suggested when he said:
"I think a clock api function would be better."

I had it in cpufreq-cpu0 driver earlier and moved it to a separate API
yesterday only.

Sorry if I misunderstood his comment.
