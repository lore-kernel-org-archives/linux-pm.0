From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.15-rc2: longhaul cpufreq stalls tasks for 120s+
Date: Fri, 25 Apr 2014 13:01:26 +0530
Message-ID: <CAKohpokQ5xHF8ZYs+1RkBCX_J910FWfoKK1gN0KBRf9eUQ+2ug@mail.gmail.com>
References: <alpine.SOC.1.00.1404241249480.13595@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <alpine.SOC.1.00.1404241249480.13595@math.ut.ee>
Sender: cpufreq-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 24 April 2014 15:26, Meelis Roos <mroos@linux.ee> wrote:
> This is VIA EPIA board with 533 MHz VIA Samuel 2 CPU. Normally, longhaul
> is not enabled automatically but with longhaul.enable=1. It used to work
> up to 3.14 but in 3.15-rc, different cpufreq-related codepaths block for
> long times and cause warnings.
>
> /usr/bin/cpufreq-set --cpu 0 --governor ondemand
> is running since boot and hangs in D state.
> Running cpufreq-info seems to just hang too.

Okay, I know WTF is going on here. My mistake, but as I said earlier this
patch only highlighted the issue by serializing things its there since last
6-8 months.

I will send out patches shortly, please test them. Description of what actually
happened will be present there in details.

In short, we are sending double notifications here, once from core and once
from driver :(
