From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 03 Oct 2013 10:23:08 +0100
Message-ID: <524D377C.90200@arm.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>	<524D3170.7080406@arm.com> <CAKohpo=90LQawdZGmm2-CU3U-kHL6uUkmFKGRGZFCwY5YckLEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55858 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3JCJXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 05:23:05 -0400
In-Reply-To: <CAKohpo=90LQawdZGmm2-CU3U-kHL6uUkmFKGRGZFCwY5YckLEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 03/10/13 10:00, Viresh Kumar wrote:
> On 3 October 2013 14:27, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> Agreed, but there's no cluster node in DT. So platforms using DT would have
>> these clocks in cpu@n node as it's used for CPU frequency scaling. One example I
>> can see is highbank(it uses cpufreq-cpu0 meaning its single cluster clock). So
>> AFAICT if any big-little systems wants to pass cluster clocks through DT, it has
>> to be cpu@n nodes. Let me know if you have any alternate thoughts ?
> 
> I understand your point, but shouldn't we name it then: cpu clock?
> Probably cluster clock was wrong from the beginning.. As there is no cluster clock,
> or there is ? :)
> 

Ok I would phrase it as, it's a clock shared by all the cpus in the cluster.
So like any other shared clocks in the system, each device sharing it would have
it as input clock but it would be single clock output from the clock/power
controller. Does it make any sense ?

Regards,
Sudeep

