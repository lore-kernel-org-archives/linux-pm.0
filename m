From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 3 Oct 2013 15:08:33 +0530
Message-ID: <CAKohpomaymtyvz=5W34ofHo5xBZyUz1N5oHNR-Ur4MfAAfehTg@mail.gmail.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
	<CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>
	<524D3170.7080406@arm.com>
	<CAKohpo=90LQawdZGmm2-CU3U-kHL6uUkmFKGRGZFCwY5YckLEg@mail.gmail.com>
	<524D377C.90200@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <524D377C.90200@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 3 October 2013 14:53, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> Ok I would phrase it as, it's a clock shared by all the cpus in the cluster.
> So like any other shared clocks in the system, each device sharing it would have
> it as input clock but it would be single clock output from the clock/power
> controller. Does it make any sense ?

Sure.. I already know that :) .. what I am not able to decide is, if we should
talk about CPU clocks in our driver or cluster clocks..
