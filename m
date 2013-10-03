From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 03 Oct 2013 10:50:49 +0100
Message-ID: <524D3DF9.4080005@arm.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>	<524D3170.7080406@arm.com>	<CAKohpo=90LQawdZGmm2-CU3U-kHL6uUkmFKGRGZFCwY5YckLEg@mail.gmail.com>	<524D377C.90200@arm.com> <CAKohpomaymtyvz=5W34ofHo5xBZyUz1N5oHNR-Ur4MfAAfehTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomaymtyvz=5W34ofHo5xBZyUz1N5oHNR-Ur4MfAAfehTg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

On 03/10/13 10:38, Viresh Kumar wrote:
> On 3 October 2013 14:53, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> Ok I would phrase it as, it's a clock shared by all the cpus in the cluster.
>> So like any other shared clocks in the system, each device sharing it would have
>> it as input clock but it would be single clock output from the clock/power
>> controller. Does it make any sense ?
> 
> Sure.. I already know that :) .. what I am not able to decide is, if we should
> talk about CPU clocks in our driver or cluster clocks..
> 

I understand. Having cpu-cluster.<n> helps platforms not specifying cpu clocks
in DT or not registering clocks using cpu_dev. If you enforce clock lookups with
dev_id(cpu<n>) then I believe you can remove 'cpu-cluster.<n>', that's your call :)

Regards,
Sudeep

