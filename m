From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/3] cpufreq: Tegra: implement intermediate frequency callbacks
Date: Sat, 17 May 2014 10:22:02 +0530
Message-ID: <CAKohpondZuWyA+oLOTbFHn2D1g6DdNu0PaoTfAau8jXw4VVc3Q@mail.gmail.com>
References: <9e1ed1bf8c3610709436fe5ef8df3a63856f8f5c.1400230695.git.viresh.kumar@linaro.org>
	<b3e68b08ca8175fde81ef1a85db1fde506f835b9.1400230695.git.viresh.kumar@linaro.org>
	<5376696F.9090006@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34413 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbaEQEwD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 May 2014 00:52:03 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so3874972obc.25
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 21:52:02 -0700 (PDT)
In-Reply-To: <5376696F.9090006@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

On 17 May 2014 01:09, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>  static int
>>  tegra_target_intermediate(struct cpufreq_policy *policy, unsigned int frequency)
>>  {
>> +       WARN_ON(frequency != clk_get_rate(pll_p_clk) / 1000);
>> +
>> +       /*
>> +        * Take an extra reference to the main pll so it doesn't turn
>> +        * off when we move the cpu off of it
>> +        */
>> +       clk_prepare_enable(pll_x_clk);
>> +
>>         return clk_set_parent(cpu_clk, pll_p_clk);
>> +       /* FIXME: if error, remove pll_x reference */

Fixed this as well
