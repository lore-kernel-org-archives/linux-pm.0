From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 3 Oct 2013 14:30:03 +0530
Message-ID: <CAKohpo=90LQawdZGmm2-CU3U-kHL6uUkmFKGRGZFCwY5YckLEg@mail.gmail.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
	<CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>
	<524D3170.7080406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:39188 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab3JCJAE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 05:00:04 -0400
Received: by mail-qe0-f41.google.com with SMTP id 1so1506871qee.28
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 02:00:04 -0700 (PDT)
In-Reply-To: <524D3170.7080406@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 3 October 2013 14:27, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> Agreed, but there's no cluster node in DT. So platforms using DT would have
> these clocks in cpu@n node as it's used for CPU frequency scaling. One example I
> can see is highbank(it uses cpufreq-cpu0 meaning its single cluster clock). So
> AFAICT if any big-little systems wants to pass cluster clocks through DT, it has
> to be cpu@n nodes. Let me know if you have any alternate thoughts ?

I understand your point, but shouldn't we name it then: cpu clock? Probably
cluster clock was wrong from the beginning.. As there is no cluster clock,
or there is ? :)
